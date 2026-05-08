import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF6C63FF);
  static const Color primaryDark = Color(0xFF4B45B2);
  static const Color background = Color(0xFFF8F9FE);

  static const Color userBubble = Color(0xFF6C63FF);
  static const Color botBubble = Colors.white;
  static const Color userText = Colors.white;
  static const Color botText = Color(0xFF2D3142);

  static const Color inputBackground = Color(0xFFEFF1F8);
  static const Color timestamp = Color(0xFF9E9E9E);
  static const Color error = Color(0xFFE53935);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

