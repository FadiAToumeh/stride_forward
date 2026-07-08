class StepsModel {
  final int steps;
  final int goal;

  const StepsModel({this.steps = 0, this.goal = 0});

  StepsModel copywith({int? steps, int? goal}) =>
      StepsModel(steps: steps ?? this.steps, goal: goal ?? this.goal);
}
