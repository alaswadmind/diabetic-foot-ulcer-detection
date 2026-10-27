import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'result_screen.dart';

class AnalysisScreen extends StatefulWidget { final String imagePath; const AnalysisScreen({super.key, required this.imagePath}); @override State<AnalysisScreen> createState() => _AnalysisScreenState(); }
class _AnalysisScreenState extends State<AnalysisScreen> {
  bool loading = true; String? error;
  @override void initState() { super.initState(); _run(); }
  Future<void> _run() async { setState(() { loading = true; error = null; }); try { final result = await ApiService().predict(widget.imagePath); if (mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ResultScreen(imagePath: widget.imagePath, result: result))); } on ApiException catch (e) { if (mounted) setState(() { loading = false; error = e.message; }); } }
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('تحليل الصورة')), body: Center(child: Padding(padding: const EdgeInsets.all(28), child: loading ? Column(mainAxisSize: MainAxisSize.min, children: [const SizedBox(width: 54, height: 54, child: CircularProgressIndicator(strokeWidth: 5)), const SizedBox(height: 24), const Text('جارٍ تحليل الصورة', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800)), const SizedBox(height: 8), Text('يرجى الانتظار لحظات', style: TextStyle(color: Colors.blueGrey.shade600))]) : Column(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.cloud_off_rounded, size: 58, color: Color(0xFFC65B49)), const SizedBox(height: 14), Text(error ?? 'تعذر إتمام التحليل', textAlign: TextAlign.center, style: const TextStyle(fontSize: 18, height: 1.5)), const SizedBox(height: 20), FilledButton.icon(onPressed: _run, icon: const Icon(Icons.refresh_rounded), label: const Text('إعادة المحاولة'))]))));
}
