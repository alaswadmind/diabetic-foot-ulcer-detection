import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() => runApp(const QadamAmanApp());

class QadamAmanApp extends StatelessWidget {
  const QadamAmanApp({super.key});
  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.fromSeed(seedColor: const Color(0xFF0B5D5B), brightness: Brightness.light);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'قدم أمان',
      locale: const Locale('ar'),
      theme: ThemeData(useMaterial3: true, colorScheme: scheme, scaffoldBackgroundColor: const Color(0xFFF8FBF8), fontFamily: 'sans', filledButtonTheme: FilledButtonThemeData(style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)))), cardTheme: const CardThemeData(color: Colors.white, elevation: 0)),
      home: const SplashScreen(),
    );
  }
}
