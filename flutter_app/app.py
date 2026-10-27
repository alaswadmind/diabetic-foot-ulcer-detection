import io
import os
from typing import Any

import joblib
import numpy as np
from fastapi import FastAPI, File, UploadFile
from fastapi.responses import JSONResponse
from PIL import Image, UnidentifiedImageError
from skimage.color import rgb2gray
from skimage.feature import hog

app = FastAPI(title="Diabetic Foot Ulcer Detection API")
MODEL_PATH = os.getenv("MODEL_PATH", "best_lightgbm_model.pkl")
ENCODER_PATH = os.getenv("ENCODER_PATH", "label_encoder.pkl")
MAX_IMAGE_BYTES = 8 * 1024 * 1024
model = joblib.load(MODEL_PATH)
label_encoder = joblib.load(ENCODER_PATH)


def preprocess_image(image_bytes: bytes) -> np.ndarray:
    try:
        image = Image.open(io.BytesIO(image_bytes)).convert("RGB")
    except (UnidentifiedImageError, OSError) as exc:
        raise ValueError("الصورة غير صالحة أو غير مدعومة.") from exc
    resized = image.resize((224, 224), Image.Resampling.LANCZOS)
    array = np.asarray(resized)
    gray = rgb2gray(array)
    hog_features = hog(gray, orientations=8, pixels_per_cell=(16, 16), cells_per_block=(1, 1), visualize=False)
    histograms = [np.histogram(array[:, :, channel], bins=8, range=(0, 256), density=True)[0] for channel in range(3)]
    features = np.concatenate([hog_features, np.concatenate(histograms)]).reshape(1, -1)
    expected = getattr(model, "n_features_in_", None)
    if expected is not None and features.shape[1] != expected:
        raise ValueError("إعدادات استخراج الميزات لا تطابق النموذج المحفوظ.")
    return features


def label_for_model_class(class_id: Any) -> str:
    return str(label_encoder.inverse_transform([int(class_id)])[0])


@app.get("/health")
def health() -> dict[str, str]:
    return {"status": "ok"}


@app.post("/predict")
async def predict(file: UploadFile = File(...)):
    try:
        if not file.content_type or not file.content_type.startswith("image/"):
            return JSONResponse({"status": "error", "message": "يرجى إرسال ملف صورة."}, status_code=415)
        contents = await file.read()
        if not contents or len(contents) > MAX_IMAGE_BYTES:
            return JSONResponse({"status": "error", "message": "حجم الصورة غير صالح."}, status_code=413)
        features = preprocess_image(contents)
        predicted_id = model.predict(features)[0]
        probabilities_array = model.predict_proba(features)[0]
        predicted_label = label_for_model_class(predicted_id)
        probabilities = {label_for_model_class(class_id): float(probability) for class_id, probability in zip(model.classes_, probabilities_array)}
        return {"status": "success", "class_name": predicted_label, "confidence": float(max(probabilities_array)), "probabilities": probabilities}
    except Exception as exc:
        return JSONResponse({"status": "error", "message": str(exc)}, status_code=500)


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
