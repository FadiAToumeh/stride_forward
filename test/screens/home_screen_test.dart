import 'package:flutter_test/flutter_test.dart';
import 'package:stride_forward/screens/home_screen.dart';

void main() {
  group('formattedStepNumber', () {
    test('returns plain string for numbers under 1000', () {
      expect(formattedStepNumber(0), '0');
      expect(formattedStepNumber(999), '999');
    });

    test('formats 4-digit numbers with comma', () {
      expect(formattedStepNumber(1000), '1,000');
      expect(formattedStepNumber(8220), '8,220');
      expect(formattedStepNumber(9999), '9,999');
    });

    test('formats 5-digit numbers with comma', () {
      expect(formattedStepNumber(10000), '10,000');
      expect(formattedStepNumber(12000), '12,000');
      expect(formattedStepNumber(54890), '54,890');
    });

    test('formats single digit numbers', () {
      expect(formattedStepNumber(1), '1');
      expect(formattedStepNumber(9), '9');
    });

    test('formats two digit numbers', () {
      expect(formattedStepNumber(10), '10');
      expect(formattedStepNumber(99), '99');
    });

    test('formats three digit numbers', () {
      expect(formattedStepNumber(100), '100');
      expect(formattedStepNumber(999), '999');
    });
  });

  group('dateTimeString', () {
    test('returns a non-empty string', () {
      final result = dateTimeString();
      expect(result, isNotEmpty);
    });

    test('contains a comma separator', () {
      final result = dateTimeString();
      expect(result, contains(','));
    });

    test('contains the current year', () {
      final result = dateTimeString();
      final year = DateTime.now().year.toString();
      expect(result, contains(year));
    });
  });
}
