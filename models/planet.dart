import 'package:flutter/material.dart';

class Planet {
  final int id;
  final String name;
  final String title;
  final String description;
  final String imagePath;
  final String model3DPath; // للموديل ثلاثي الأبعاد (للمستقبل)
  final Color color;
  final double size;

  // الإحصائيات الجديدة
  final String distanceFromSun; // كم
  final String dayLength; // ساعات
  final String orbitalPeriod; // سنوات أرضية
  final String radius; // كم
  final String mass; // كجم
  final String gravity; // م/ث²
  final String surfaceArea; // كم²

  const Planet({
    required this.id,
    required this.name,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.model3DPath,
    required this.color,
    this.size = 250,
    required this.distanceFromSun,
    required this.dayLength,
    required this.orbitalPeriod,
    required this.radius,
    required this.mass,
    required this.gravity,
    required this.surfaceArea,
  });
}