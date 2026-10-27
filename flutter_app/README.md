# قدم أمان

تطبيق Flutter عربي للفحص الأولي لصور القدم السكري، مرتبط بخادم FastAPI يحمل نموذج LightGBM المحفوظ. التطبيق يعرض التصنيف الفعلي القادم من الخادم بصياغة عربية، 

## التشغيل

1. ثبّت Flutter وAndroid SDK ثم نفّذ `flutter pub get` داخل هذا المجلد.
2. شغّل الخادم من مجلد المشروع:

```bash
cd flutter_app
python3 -m pip install fastapi uvicorn python-multipart joblib pillow numpy scikit-image scikit-learn lightgbm
python3 app.py
```

3. تحقق من أن `http://127.0.0.1:8000/docs` و`http://127.0.0.1:8000/health` يعملان.
4. عدّل `lib/config/api_config.dart`: استخدم `http://10.0.2.2:8000` لمحاكي Android، أو عنوان IPv4 للحاسوب عند الاختبار على هاتف حقيقي. استخدم HTTPS عند النشر.
5. نفّذ `flutter run`.

## ملاحظات Android

تمت إضافة أذونات الكاميرا وقراءة الصور، وتم تفعيل HTTP غير المشفر للتطوير المحلي فقط في `AndroidManifest.xml`.

## توافق النموذج

المعالجة في `app.py` تحول الصورة إلى RGB، وتعيد تحجيمها إلى 224×224 بخوارزمية Lanczos، ثم تستخرج HOG بإعدادات 8 orientations و16×16 pixels لكل cell و1×1 cell لكل block، وتضيف 8-bin RGB histograms. الناتج 1592 ميزة، وهو مطابق للبعد المسجل في النموذج المحفوظ. كما أن ترتيب الاحتمالات يُربط عبر `model.classes_` ثم `label_encoder.inverse_transform`.

لا يتم حفظ صور المستخدمين في التطبيق أو الخادم بعد إتمام الطلب، ويجب إضافة سياسات الخصوصية والمصادقة والتخزين الآمن قبل النشر العام.
