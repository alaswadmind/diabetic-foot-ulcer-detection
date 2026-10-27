import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/brand_mark.dart';
import '../widgets/image_preview.dart';
import 'analysis_screen.dart';

class HomeScreen extends StatefulWidget { const HomeScreen({super.key}); @override State<HomeScreen> createState() => _HomeScreenState(); }
class _HomeScreenState extends State<HomeScreen> {
  String? imagePath;
  final picker = ImagePicker();
  Future<void> choose(ImageSource source) async {
    try { final file = await picker.pickImage(source: source, imageQuality: 88, maxWidth: 1800); if (file != null) setState(() => imagePath = file.path); }
    catch (_) { if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تعذر فتح مصدر الصورة. تحقق من الأذونات وحاول مرة أخرى.'))); }
  }
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Row(children: [const BrandMark(size: 38), const SizedBox(width: 10), const Text('قدم أمان', style: TextStyle(fontWeight: FontWeight.w800))]), backgroundColor: Colors.transparent), body: SafeArea(child: ListView(padding: const EdgeInsets.fromLTRB(20, 12, 20, 28), children: [
    const Text('تحليل صور القدم\nبهدوء ووضوح', style: TextStyle(fontSize: 32, height: 1.15, fontWeight: FontWeight.w900, color: Color(0xFF123F3D))),
    const SizedBox(height: 12), const Text('التقط صورة واضحة لتحصل على قراءة أولية تساعدك على معرفة الخطوة التالية. النتيجة ليست تشخيصًا طبيًا.', style: TextStyle(fontSize: 16, height: 1.55, color: Color(0xFF59726E))),
    const SizedBox(height: 24), ImagePreview(path: imagePath, onChange: imagePath == null ? null : () => choose(ImageSource.gallery)), const SizedBox(height: 16),
    Row(children: [Expanded(child: FilledButton.icon(onPressed: () => choose(ImageSource.camera), icon: const Icon(Icons.camera_alt_rounded), label: const Text('التقاط صورة'))), const SizedBox(width: 10), Expanded(child: OutlinedButton.icon(onPressed: () => choose(ImageSource.gallery), icon: const Icon(Icons.photo_library_outlined), label: const Text('من المعرض')))]),
    const SizedBox(height: 22), Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: const Color(0xFFEAF4F0), borderRadius: BorderRadius.circular(22)), child: const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(Icons.wb_sunny_outlined, color: Color(0xFF0B7A70)), SizedBox(width: 12), Expanded(child: Text('نصيحة للصورة: إضاءة جيدة، قدم كاملة داخل الإطار، والجلد أو المنطقة المراد تحليلها واضحة دون ظلال قوية.', style: TextStyle(height: 1.55, color: Color(0xFF315E58))))])),
    const SizedBox(height: 22), FilledButton(onPressed: imagePath == null ? null : () => Navigator.push(context, MaterialPageRoute(builder: (_) => AnalysisScreen(imagePath: imagePath!))), child: const Text('بدء التحليل')),
  ])));
}
