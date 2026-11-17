import 'package:flutter/material.dart';

class AppColors {
  // الخلفية الرئيسية (أزرق فضائي غامق)
  static const Color background = Color(0xFF0A0E27);
  static const Color backgroundLight = Color(0xFF1A1F4E);

  // الألوان الأساسية
  static const Color primary = Color(0xFFFF4D4D);   // أحمر المريخ (للأزرار والعناوين)
  static const Color secondary = Color(0xFF4A90E2); // أزرق الأرض
  static const Color accent = Color(0xFFFFD700);    // ذهبي للنجوم والتفاصيل

  // ألوان النصوص
  static const Color text = Color(0xFFFFFFFF);          // أبيض
  static const Color textSecondary = Color(0xFF8B9DC3); // رمادي مزرق للنصوص الفرعية

  // ألوان الكواكب (هنستخدمها في تأثيرات الإضاءة Glow)
  static const Color mars = Color(0xFFFF4D4D);
  static const Color earth = Color(0xFF4A90E2);
  static const Color jupiter = Color(0xFFD4A574);
  static const Color saturn = Color(0xFFF4D03F);
}