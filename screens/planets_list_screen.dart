import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/theme/app_colors.dart';
import '../data/planet_data.dart';
import '../models/planet.dart';
import '../widgets/planet_card.dart';
import 'planet_details_screen.dart';

class PlanetsListScreen extends StatelessWidget {
  const PlanetsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text(
          'Explore Planets',
          style: TextStyle(
            color: AppColors.text,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.text),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: PlanetData.planets.length,
        itemBuilder: (context, index) {
          final planet = PlanetData.planets[index];
          return PlanetCard(
            planet: planet,
            onTap: () {
              // الانتقال لصفحة التفاصيل مع Hero Animation
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlanetDetailsScreen(planet: planet),
                ),
              );
            },
          )
          // تأثير ظهور الكروت واحداً تلو الآخر
              .animate()
              .fade(duration: 400.ms, delay: (index * 100).ms)
              .slideX(begin: -0.2, end: 0, duration: 400.ms, curve: Curves.easeOut);
        },
      ),
    );
  }
}