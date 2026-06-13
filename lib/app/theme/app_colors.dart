import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF7C4DFF);

  static const Color secondary = Color(0xFF4F46E5);

  static const Color background = Color(0xFF070B1A);

  static const Color card = Color(0xFF0E1730);

  static const Color text = Colors.white;

  static const LinearGradient mainGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF1A237E),
      Color(0xFF7C4DFF),
    ],
  );
}