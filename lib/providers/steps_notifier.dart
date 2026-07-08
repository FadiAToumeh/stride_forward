import 'package:flutter_riverpod/legacy.dart';
import 'package:stride_forward/providers/steps_provider.dart';

class StepsNotifier extends StateNotifier<int> {
  StepsNotifier() : super(0);

  void updateSteps(int steps) {
    state = steps;
  }
}

final stepsNotifierProvider = StateNotifierProvider<StepsNotifier, int>((ref) {
  final stepsService = ref.watch(stepsServiceProvider);

  final notifier = StepsNotifier();

  stepsService.onStepsUpdated = (steps) {
    notifier.updateSteps(steps);
  };

  stepsService.getTodaySteps().then((savedSteps) {
    if (savedSteps > 0) {
      notifier.updateSteps(savedSteps);
    }
  });

  return notifier;
});
