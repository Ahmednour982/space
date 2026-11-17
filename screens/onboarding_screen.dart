import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/theme/app_colors.dart';
import '../data/planet_data.dart';
import '../models/planet.dart';
import '../widgets/planet_widget.dart';
import '../widgets/star_field.dart';
import 'home_screen.dart'; // <-- الـ Import المهم للشاشة الجديدة

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // الدالة المعدلة: بتنقل للشاشة الرئيسية بدل الرسالة
  void _nextPage() {
    if (_currentPage < PlanetData.planets.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      // الانتقال للشاشة الرئيسية
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final currentPlanet = PlanetData.planets[_currentPage];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // 1. خلفية النجوم
          const StarField(),

          // 2. زر التخطي (Skip)
          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              child: const Text(
                'Skip',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 16,
                ),
              ),
            ),
          ),

          // 3. محتوى الصفحات (PageView)
          PageView.builder(
            controller: _pageController,
            itemCount: PlanetData.planets.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final planet = PlanetData.planets[index];
              return _buildPlanetPage(planet, size);
            },
          ),

          // 4. الجزء السفلي (النقاط + الزر)
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // نقاط التنقل (Dots)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    PlanetData.planets.length,
                        (index) => _buildDot(index),
                  ),
                ),

                const SizedBox(height: 40),

                // زر Next / Start مع Animation
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: currentPlanet.color,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        elevation: 10,
                        shadowColor: currentPlanet.color.withOpacity(0.5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _currentPage == PlanetData.planets.length - 1
                                ? 'Start Exploring'
                                : 'Next',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            _currentPage == PlanetData.planets.length - 1
                                ? Icons.rocket_launch
                                : Icons.arrow_forward,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                    .animate()
                    .scale(delay: 600.ms, duration: 400.ms, curve: Curves.easeOutBack),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // بناء صفحة الكوكب مع Animations
  Widget _buildPlanetPage(Planet planet, Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // الكوكب مع تأثير الظهور
          SizedBox(
            height: size.height * 0.4,
            child: Center(
              child: PlanetWidget(
                planet: planet,
                isActive: _currentPage == PlanetData.planets.indexOf(planet),
              ),
            ),
          )
              .animate()
              .scale(duration: 600.ms, curve: Curves.easeOutBack)
              .then()
              .shimmer(duration: 1200.ms, color: planet.color.withOpacity(0.3)),

          const SizedBox(height: 40),

          // العنوان مع تأثير الانزلاق
          Text(
            planet.title,
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.center,
          )
              .animate(delay: 200.ms)
              .fade(duration: 600.ms)
              .slideY(begin: 0.3, end: 0, curve: Curves.easeOut),

          const SizedBox(height: 16),

          // الوصف مع تأثير الانزلاق
          Text(
            planet.description,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          )
              .animate(delay: 400.ms)
              .fade(duration: 600.ms)
              .slideY(begin: 0.3, end: 0, curve: Curves.easeOut),
        ],
      ),
    );
  }

  // بناء نقطة التنقل (Dot)
  Widget _buildDot(int index) {
    final isActive = index == _currentPage;
    final planet = PlanetData.planets[index];

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 30 : 10,
      height: 10,
      decoration: BoxDecoration(
        color: isActive ? planet.color : AppColors.textSecondary.withOpacity(0.3),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}