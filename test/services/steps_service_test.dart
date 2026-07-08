import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stride_forward/services/steps_service.dart';

void main() {
  late StepsService service;

  setUp(() {
    service = StepsService();
  });

  group('calculateDistance', () {
    test('returns 0 for 0 steps', () {
      expect(service.calculateDistance(0), 0);
    });

    test('converts steps to kilometers correctly', () {
      // 10000 steps * 0.0007 = 7.0 km
      expect(service.calculateDistance(10000), 7);
    });

    test('truncates decimal result', () {
      // 100 steps * 0.0007 = 0.07 -> 0
      expect(service.calculateDistance(100), 0);
    });

    test('handles large step counts', () {
      // 100000 steps * 0.0007 = 70.0 km
      expect(service.calculateDistance(100000), 70);
    });
  });

  group('calculateCalories', () {
    test('returns 0 for 0 steps', () {
      expect(service.calculateCalories(0), 0);
    });

    test('converts steps to calories correctly', () {
      // 1000 steps * 0.05 = 50 kcal
      expect(service.calculateCalories(1000), 50);
    });

    test('truncates decimal result', () {
      // 10 steps * 0.05 = 0.5 -> 0
      expect(service.calculateCalories(10), 0);
    });

    test('handles large step counts', () {
      // 50000 steps * 0.05 = 2500 kcal
      expect(service.calculateCalories(50000), 2500);
    });
  });

  group('getSteps', () {
    test('returns 0 when no steps saved', () async {
      SharedPreferences.setMockInitialValues({});

      final result = await service.getSteps();
      expect(result, 0);
    });

    test('returns stored steps value', () async {
      SharedPreferences.setMockInitialValues({'steps': 8220});

      final result = await service.getSteps();
      expect(result, 8220);
    });
  });

  group('saveSteps', () {
    test('saves steps to SharedPreferences', () async {
      SharedPreferences.setMockInitialValues({});

      service.saveSteps(5000);

      await Future.delayed(Duration.zero);

      final result = await service.getSteps();
      expect(result, 5000);
    });

    test('overwrites previous steps value', () async {
      SharedPreferences.setMockInitialValues({'steps': 1000});

      service.saveSteps(9999);

      await Future.delayed(Duration.zero);

      final result = await service.getSteps();
      expect(result, 9999);
    });
  });
}
