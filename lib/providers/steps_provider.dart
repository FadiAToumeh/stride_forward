import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stride_forward/services/steps_service.dart';

final stepsServiceProvider = Provider<StepsService>((ref) {
  final service = StepsService();
  service.startListening();

  ref.onDispose(() {
    service.dispose();
  });

  return service;
});
