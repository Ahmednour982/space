import 'package:flutter/material.dart';
import '../models/planet.dart';
import '../core/theme/app_colors.dart';
import '../widgets/planet_widget.dart';
import '../widgets/star_field.dart';

class PlanetDetailsScreen extends StatelessWidget {
  final Planet planet;

  const PlanetDetailsScreen({super.key, required this.planet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // 1. خلفية النجوم
          const StarField(),

          // 2. زر الرجوع (Back Button)
          Positioned(
            top: 50,
            left: 20,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.backgroundLight.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: AppColors.text, size: 20),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),

          // 3. محتوى الصفحة (قابل للتمرير)
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 120),

                // الكوكب الكبير مع Hero Animation
                Hero(
                  tag: 'planet_${planet.id}',
                  child: PlanetWidget(planet: planet, isActive: true),
                ),

                const SizedBox(height: 40),

                // اسم الكوكب
                Text(
                  planet.name,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: planet.color,
                    shadows: [
                      Shadow(
                        color: planet.color.withOpacity(0.5),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // العنوان الفرعي
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    planet.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      color: planet.color.withOpacity(0.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 24),

                // وصف الكوكب
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    planet.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 40),

                // قسم الإحصائيات (Stats)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundLight.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: planet.color.withOpacity(0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info_outline, color: planet.color, size: 24),
                          const SizedBox(width: 8),
                          const Text(
                            'Planet Statistics',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.text,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // الشبكة الأولى
                      _buildStatsGrid([
                        _StatItem('Distance', '${planet.distanceFromSun} km', Icons.wb_sunny_outlined),
                        _StatItem('Radius', '${planet.radius} km', Icons.circle_outlined),
                        _StatItem('Day Length', '${planet.dayLength} hrs', Icons.access_time),
                      ], planet.color),

                      const SizedBox(height: 20),

                      // الشبكة الثانية
                      _buildStatsGrid([
                        _StatItem('Orbital Period', '${planet.orbitalPeriod} yrs', Icons.loop),
                        _StatItem('Mass', '${planet.mass} kg', Icons.scale),
                        _StatItem('Gravity', '${planet.gravity} m/s²', Icons.arrow_downward),
                      ], planet.color),

                      const SizedBox(height: 20),

                      // الشبكة الثالثة
                      _buildStatsGrid([
                        _StatItem('Surface Area', '${planet.surfaceArea} km²', Icons.public),
                      ], planet.color),
                    ],
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget لبناء شبكة من الإحصائيات
  Widget _buildStatsGrid(List<_StatItem> items, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: items.map((item) => _buildStatItem(item, color)).toList(),
    );
  }

  // Widget لعرض إحصائية واحدة
  Widget _buildStatItem(_StatItem item, Color color) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(item.icon, color: color, size: 24),
          ),
          const SizedBox(height: 10),
          Text(
            item.value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Text(
            item.label,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// كلاس صغير لتمثيل كل إحصائية
class _StatItem {
  final String label;
  final String value;
  final IconData icon;

  _StatItem(this.label, this.value, this.icon);
}