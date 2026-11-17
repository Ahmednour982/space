import 'package:flutter/material.dart';
import '../models/planet.dart';

class PlanetWidget extends StatefulWidget {
  final Planet planet;
  final bool isActive;

  const PlanetWidget({
    super.key,
    required this.planet,
    this.isActive = true,
  });

  @override
  State<PlanetWidget> createState() => _PlanetWidgetState();
}

class _PlanetWidgetState extends State<PlanetWidget> with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );

    if (widget.isActive) {
      _rotationController.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant PlanetWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !_rotationController.isAnimating) {
      _rotationController.repeat();
    } else if (!widget.isActive && _rotationController.isAnimating) {
      _rotationController.stop();
    }
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.planet.size,
      height: widget.planet.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // تأثير الإضاءة (Glow)
          Container(
            width: widget.planet.size * 0.8,
            height: widget.planet.size * 0.8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: widget.planet.color.withOpacity(0.6),
                  blurRadius: 80,
                  spreadRadius: 20,
                ),
              ],
            ),
          ),

          // دوران الكوكب باستخدام RotationTransition (الطريقة الأسهل والأضمن)
          RotationTransition(
            turns: _rotationController,
            child: Image.asset(
              widget.planet.imagePath,
              width: widget.planet.size,
              height: widget.planet.size,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}