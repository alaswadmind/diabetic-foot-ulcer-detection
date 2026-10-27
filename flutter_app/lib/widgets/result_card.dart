import 'package:flutter/material.dart';
import '../models/prediction_result.dart';

class ResultCard extends StatelessWidget {
  final PredictionResult result;
  const ResultCard({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final abnormal = result.isAbnormal;
    final color = abnormal ? const Color(0xFFC65B49) : const Color(0xFF0B7A70);
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(color: color.withValues(alpha: .10), borderRadius: BorderRadius.circular(28), border: Border.all(color: color.withValues(alpha: .22))),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CircleAvatar(backgroundColor: color, foregroundColor: Colors.white, radius: 24, child: Icon(abnormal ? Icons.priority_high_rounded : Icons.check_rounded)),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(abnormal ? 'تحتاج إلى تقييم مختص' : 'تبدو الصورة طبيعية', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: color)),
          const SizedBox(height: 8),
          Text(abnormal ? 'النموذج يشير إلى احتمال وجود قرحة أو حالة غير طبيعية.' : 'النموذج صنّف الصورة على أنها جلد طبيعي.', style: const TextStyle(fontSize: 15, height: 1.6, color: Color(0xFF284644))),
        ])),
      ]),
    );
  }
}
