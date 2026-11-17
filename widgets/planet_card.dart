import 'package:flutter/material.dart';
import '../models/planet.dart';
import '../core/theme/app_colors.dart';

class PlanetCard extends StatelessWidget {
  final Planet planet;
  final VoidCallback onTap;

  const PlanetCard({
    super.key,
    required this.planet,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.backgroundLight.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: planet.color.withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: planet.color.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            // صورة الكوكب مع Hero Animation (اللي بتخليها تطير)
            Hero(
              tag: 'planet_${planet.id}', // لازم يكون نفس الـ tag في صفحة التفاصيل
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: planet.color.withOpacity(0.5),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Image.asset(
                  planet.imagePath,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            const SizedBox(width: 20),

            // معلومات الكوكب
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    planet.name,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: planet.color,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    planet.title,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // أيقونة السهم
            Icon(
              Icons.arrow_forward_ios,
              color: planet.color,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}