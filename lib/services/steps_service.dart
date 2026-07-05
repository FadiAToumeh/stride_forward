import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class StepsService {
  int calculateDistance(int steps) {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // int steps = prefs.getInt('steps') ?? 0;
    double distance = steps.toDouble() * 0.0007;
    return distance.toInt();
  }

  Future<int> getSteps() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('steps') ?? 0;
  }

  void saveSteps(int steps) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('steps', steps);
  }

  int calculateCalories(int steps) {
    double caloriesBurned = steps * 0.05;
    return caloriesBurned.toInt();
  }
}
