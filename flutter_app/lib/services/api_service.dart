import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/prediction_result.dart';

class ApiException implements Exception {
  final String message;
  const ApiException(this.message);
}

class ApiService {
  Future<PredictionResult> predict(String imagePath) async {
    try {
      final request = http.MultipartRequest('POST', ApiConfig.predictUri)
        ..files.add(await http.MultipartFile.fromPath('file', imagePath));
      final streamed = await request.send().timeout(ApiConfig.requestTimeout);
      final response = await http.Response.fromStream(streamed);
      Map<String, dynamic> body;
      try {
        body = jsonDecode(response.body) as Map<String, dynamic>;
      } catch (_) {
        throw const ApiException('استجابة غير مفهومة من الخادم.');
      }
      if (response.statusCode < 200 || response.statusCode >= 300 || body['status'] == 'error') {
        throw const ApiException('تعذر تحليل الصورة من الخادم. حاول مرة أخرى.');
      }
      if (body['class_name'] == null) throw const ApiException('البيانات المستلمة ناقصة.');
      return PredictionResult.fromJson(body);
    } on SocketException {
      throw const ApiException('تعذر الاتصال بالخادم، تحقق من اتصال الإنترنت وحاول مرة أخرى.');
    } on HttpException {
      throw const ApiException('تعذر الوصول إلى خدمة التحليل.');
    } on ApiException {
      rethrow;
    } catch (_) {
      throw const ApiException('انتهت مهلة التحليل أو حدث خطأ غير متوقع. حاول مرة أخرى.');
    }
  }
}
