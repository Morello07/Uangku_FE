import 'package:flutter/material.dart';
import 'colors.dart';

class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    fontFamily: 'Inter',
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 16,
    color: AppColors.textPrimary,
    fontFamily: 'Inter',
  );

  static const TextStyle button = TextStyle(
    fontSize: 16,
    color: AppColors.textLight,
    fontFamily: 'Inter',
    fontWeight: FontWeight.bold,
  );

  static const TextStyle inputLabel = TextStyle(
    fontSize: 14,
    color: AppColors.textLight,
    fontFamily: 'Inter',
  );

  static const TextStyle body = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.normal,
    fontSize: 14,
    color: Colors.black54,
  );

  static const TextStyle bodyBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    fontFamily: 'Inter',
  );
}

