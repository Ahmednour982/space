import 'package:shared_preferences/shared_preferences.dart';

class OnboardingService {
  // مفتاح التخزين
  static const String _key = 'is_onboarding_completed';

  // دالة عشان نتأكد هل المستخدم شاف الـ Onboarding قبل كده ولا لأ
  static Future<bool> isOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key) ?? false; // لو مفيش بيانات، نرجع false
  }

  // دالة عشان نحفظ إن المستخدم خلص الـ Onboarding
  static Future<void> markOnboardingAsCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, true);
  }
}