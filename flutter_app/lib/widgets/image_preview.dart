import 'dart:io';
import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {
  final String? path;
  final VoidCallback? onChange;
  const ImagePreview({super.key, required this.path, this.onChange});

  @override
  Widget build(BuildContext context) {
    if (path == null) {
      return Container(
        height: 220,
        decoration: BoxDecoration(color: const Color(0xFFEAF4F0), borderRadius: BorderRadius.circular(28), border: Border.all(color: const Color(0xFFD3E8E0))),
        child: const Center(child: Icon(Icons.add_a_photo_outlined, size: 44, color: Color(0xFF4B8580))),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: Stack(children: [
        SizedBox(width: double.infinity, height: 280, child: Image.file(File(path!), fit: BoxFit.cover)),
        if (onChange != null) Positioned(bottom: 14, left: 14, child: FilledButton.tonalIcon(onPressed: onChange, icon: const Icon(Icons.swap_horiz_rounded), label: const Text('تغيير الصورة'))),
      ]),
    );
  }
}
