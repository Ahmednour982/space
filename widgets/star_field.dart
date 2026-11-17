import 'dart:math';
import 'package:flutter/material.dart';

class StarField extends StatefulWidget {
  const StarField({super.key});

  @override
  State<StarField> createState() => _StarFieldState();
}

class _StarFieldState extends State<StarField> with TickerProviderStateMixin {
  late AnimationController _controller;
  final List<Star> _stars = [];

  @override
  void initState() {
    super.initState();
    // التحكم في حركة النجوم
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat();

    // إنشاء 150 نجمة بأماكن وأحجام عشوائية
    final random = Random();
    for (int i = 0; i < 150; i++) {
      _stars.add(Star(
        x: random.nextDouble(),
        y: random.nextDouble(),
        size: random.nextDouble() * 2 + 0.5,
        opacity: random.nextDouble() * 0.8 + 0.2,
        speed: random.nextDouble() * 0.5 + 0.1,
      ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size.infinite,
          painter: StarPainter(
            stars: _stars,
            progress: _controller.value,
          ),
        );
      },
    );
  }
}

// كلاس بسيط بيحمل بيانات كل نجمة
class Star {
  final double x;
  final double y;
  final double size;
  final double opacity;
  final double speed;

  Star({
    required this.x,
    required this.y,
    required this.size,
    required this.opacity,
    required this.speed,
  });
}

// الـ Painter اللي بيرسم النجوم على الشاشة
class StarPainter extends CustomPainter {
  final List<Star> stars;
  final double progress;

  StarPainter({required this.stars, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    for (var star in stars) {
      // حساب موقع النجمة الجديد بناءً على الحركة
      double y = (star.y + progress * star.speed) % 1.0;
      double x = star.x;

      final paint = Paint()
        ..color = Colors.white.withOpacity(star.opacity)
        ..style = PaintingStyle.fill;

      // رسم النجمة
      canvas.drawCircle(
        Offset(x * size.width, y * size.height),
        star.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(StarPainter oldDelegate) => true;
}