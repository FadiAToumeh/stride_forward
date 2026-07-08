import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stride_forward/constants/app_theme.dart';

void main() {
  group('AppColors', () {
    test('primary color is correct', () {
      expect(AppColors.primary, const Color(0xFF4F46E5));
    });

    test('secondary color is correct', () {
      expect(AppColors.secondary, const Color(0xFFEC4899));
    });

    test('accent color is correct', () {
      expect(AppColors.accent, const Color(0xFFF59E0B));
    });

    test('background color is white', () {
      expect(AppColors.background, const Color(0xFFFFFFFF));
    });

    test('surface color is correct', () {
      expect(AppColors.surface, const Color(0xFFF8FAFC));
    });

    test('error color is red', () {
      expect(AppColors.error, const Color(0xFFEF4444));
    });

    test('success color is green', () {
      expect(AppColors.success, const Color(0xFF10B981));
    });

    test('warning color matches accent', () {
      expect(AppColors.warning, AppColors.accent);
    });
  });

  group('AppTypgraphy', () {
    test('displayMedium has correct properties', () {
      expect(AppTypgraphy.displayMedium.fontSize, 46);
      expect(AppTypgraphy.displayMedium.fontWeight, FontWeight.w700);
    });

    test('headlineSmall has correct properties', () {
      expect(AppTypgraphy.headlineSmall.fontSize, 24);
      expect(AppTypgraphy.headlineSmall.fontWeight, FontWeight.w600);
    });

    test('titleMedium has correct properties', () {
      expect(AppTypgraphy.titleMedium.fontSize, 16);
      expect(AppTypgraphy.titleMedium.fontWeight, FontWeight.w600);
    });

    test('bodyMedium has correct properties', () {
      expect(AppTypgraphy.bodyMedium.fontSize, 14);
      expect(AppTypgraphy.bodyMedium.fontWeight, FontWeight.w400);
    });

    test('labelSmall has correct properties', () {
      expect(AppTypgraphy.labelSmall.fontSize, 10);
      expect(AppTypgraphy.labelSmall.fontWeight, FontWeight.w600);
    });
  });
}
