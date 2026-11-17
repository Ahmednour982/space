import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'screens/onboarding_screen.dart';

void main() {
  runApp(const ExploreUniverseApp());
}

class ExploreUniverseApp extends StatelessWidget {
  const ExploreUniverseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Explore the Universe',
      debugShowCheckedModeBanner: false, // لإخفاء شريط DEBUG في الزاوية
      theme: AppTheme.darkTheme, // تطبيق الثيم والألوان اللي عملناها
      home: const OnboardingScreen(), // تشغيل شاشة الـ Onboarding كبداية
    );
  }
}