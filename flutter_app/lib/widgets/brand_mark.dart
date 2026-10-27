import 'package:flutter/material.dart';

class BrandMark extends StatelessWidget {
  final double size;
  const BrandMark({super.key, this.size = 64});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size * .3),
      child: SizedBox(width: size, height: size, child: Image.asset('assets/qadam_aman_logo.png', fit: BoxFit.cover)),
    );
  }
}
