class PredictionResult {
  final String className;
  final double confidence;
  final Map<String, double> probabilities;

  const PredictionResult({
    required this.className,
    required this.confidence,
    required this.probabilities,
  });

  factory PredictionResult.fromJson(Map<String, dynamic> json) {
    final raw = json['probabilities'];
    final probabilities = <String, double>{};
    if (raw is Map) {
      raw.forEach((key, value) {
        final number = value is num ? value.toDouble() : double.tryParse('$value');
        if (number != null) probabilities['$key'] = number;
      });
    }
    return PredictionResult(
      className: '${json['class_name'] ?? ''}',
      confidence: (json['confidence'] as num?)?.toDouble() ?? 0,
      probabilities: probabilities,
    );
  }

  bool get isAbnormal => className.toLowerCase().contains('abnormal') || className.contains('قرحة');
}
