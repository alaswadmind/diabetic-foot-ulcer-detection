import 'dart:io';
import 'package:flutter/material.dart';
import '../models/prediction_result.dart';
import '../widgets/result_card.dart';
import 'home_screen.dart';

class ResultScreen extends StatelessWidget { final String imagePath; final PredictionResult result; const ResultScreen({super.key, required this.imagePath, required this.result});
  @override Widget build(BuildContext context) { final abnormal = result.isAbnormal; return Scaffold(appBar: AppBar(title: const Text('نتيجة التحليل')), body: ListView(padding: const EdgeInsets.fromLTRB(20, 8, 20, 28), children: [
    ClipRRect(borderRadius: BorderRadius.circular(28), child: SizedBox(height: 230, child: Image.file(File(imagePath), fit: BoxFit.cover))), const SizedBox(height: 20),
    const Text('الخلاصة', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: Color(0xFF123F3D))), const SizedBox(height: 12), ResultCard(result: result), const SizedBox(height: 16),
    Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: const Color(0xFFFFF5E7), borderRadius: BorderRadius.circular(22)), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [const Icon(Icons.info_outline_rounded, color: Color(0xFFAA6B22)), const SizedBox(width: 12), Expanded(child: Text(abnormal ? 'ننصح بحجز تقييم لدى مختص صحي، خصوصًا إذا كان هناك ألم أو احمرار أو إفرازات.' : 'النتيجة طبيعية وفق الصورة، لكنها لا تستبعد وجود مشكلة طبية. راجع مختصًا عند ظهور أي أعراض أو استمرار القلق.', style: const TextStyle(height: 1.6, color: Color(0xFF6F572D))))])), const SizedBox(height: 20),
    OutlinedButton.icon(onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const HomeScreen()), (_) => false), icon: const Icon(Icons.add_photo_alternate_outlined), label: const Text('تحليل صورة أخرى')), const SizedBox(height: 10), TextButton(onPressed: () => Navigator.popUntil(context, (route) => route.isFirst), child: const Text('العودة إلى الصفحة الرئيسية')),
  ])); }
}
