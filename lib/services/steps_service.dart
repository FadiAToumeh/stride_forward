import 'dart:async';

import 'package:pedometer/pedometer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepsService {
  Stream<StepCount> get _stepCountStream => Pedometer.stepCountStream;

  StreamSubscription<StepCount>? _subscription;

  
  int _currentSteps = 0;

  void Function(int steps)? onStepsUpdated;

  
  void startListening() {
    _subscription = _stepCountStream.listen(
      _onStepCount,
      onError: _onStepCountError,
    );
  }

  void _onStepCount(StepCount event) {
    int streamSteps = event.steps;

    if (streamSteps < _currentSteps) {
      _currentSteps = 0;
      saveTodaySteps(streamSteps);
    } else {
      _currentSteps = streamSteps;
      saveTodaySteps(streamSteps);
    }

  
    onStepsUpdated?.call(_currentSteps);
  }

  void _onStepCountError(dynamic error) {
    print('Pedometer error: $error');
  }

  
  void dispose() {
    _subscription?.cancel();
    _subscription = null;
  }

  String _todayKey() {
    DateTime now = DateTime.now();
    return 'steps_${now.year}_${now.month}_${now.day}';
  }

  Future<void> saveTodaySteps(int steps) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_todayKey(), steps);

    await prefs.setInt('steps', steps);
  }

  Future<int> getTodaySteps() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_todayKey()) ?? 0;
  }

  Future<void> saveSteps(int steps) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('steps', steps);
  }

  Future<int> getSteps() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('steps') ?? 0;
  }

  
  int calculateDistance(int steps) {
    double distance = steps * 0.0007;
    return distance.toInt();
  }


  int calculateCalories(int steps) {
    double calories = steps * 0.05;
    return calories.toInt();
  }
}