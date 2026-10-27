class ApiConfig {
  ApiConfig._();

  // Android emulator: http://10.0.2.2:8000
  // Physical device: http://YOUR_SERVER_IP:8000
  static const String baseUrl = 'http://10.0.2.2:8000';
  static const Duration requestTimeout = Duration(seconds: 45);
  static Uri get predictUri => Uri.parse('$baseUrl/predict');
}
