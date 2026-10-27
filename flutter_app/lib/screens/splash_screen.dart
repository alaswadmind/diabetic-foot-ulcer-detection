import 'package:flutter/material.dart';
import '../widgets/brand_mark.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget { const SplashScreen({super.key}); @override State<SplashScreen> createState() => _SplashScreenState(); }
class _SplashScreenState extends State<SplashScreen> {
  @override void initState() { super.initState(); Future.delayed(const Duration(milliseconds: 1500), () { if (mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen())); }); }
  @override Widget build(BuildContext context) => Scaffold(body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const BrandMark(size: 86), const SizedBox(height: 20), const Text('قدم أمان', style: TextStyle(fontSize: 34, fontWeight: FontWeight.w900, color: Color(0xFF0B5D5B))), const SizedBox(height: 8), Text('خطوة أوضح نحو العناية بقدميك', style: TextStyle(color: Colors.blueGrey.shade600, fontSize: 15))])));
}
