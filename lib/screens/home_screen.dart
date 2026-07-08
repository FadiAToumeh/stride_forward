import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:stride_forward/constants/app_theme.dart';
import 'package:stride_forward/providers/steps_provider.dart';
import 'package:stride_forward/providers/steps_notifier.dart';
import 'package:stride_forward/services/steps_service.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int currentSteps = ref.watch(stepsNotifierProvider);
    final StepsService stepsService = ref.read(stepsServiceProvider);

    const String name = 'Fadi';
    const int goal = 12000;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.05,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.025),
                Text('Keep it up, $name!', style: AppTypgraphy.headlineSmall),
                Text(
                  dateTimeString(),
                  style: AppTypgraphy.bodyMedium.copyWith(color: Colors.grey),
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
                ProgressWidget(goalNumber: goal, numberOfSteps: currentSteps),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text('Weekly Activity', style: AppTypgraphy.headlineSmall),
                    Text(
                      'Last 7 days',
                      style: AppTypgraphy.bodyMedium.copyWith(
                        color: Colors.grey,
                        fontWeight: .w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
                Align(
                  alignment: .center,
                  child: Container(
                    padding: .all(15),
                    decoration: BoxDecoration(
                      borderRadius: .circular(12.5),
                      color: AppColors.surface,
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    height: 200,
                    width: double.infinity,
                    child: WeeklyChart(),
                  ),
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
                Row(
                  mainAxisAlignment: .spaceEvenly,
                  spacing: 10,
                  children: [
                    _buildContainer(
                      context: context,
                      icon: Icon(
                        size: 30,
                        Icons.local_fire_department,
                        color: AppColors.primary,
                      ),
                      name: 'Calories',
                      number: stepsService
                          .calculateCalories(currentSteps)
                          .toString(),
                      unit: 'kcal',
                    ),
                    _buildContainer(
                      context: context,
                      icon: Icon(
                        size: 30,
                        Icons.route_rounded,
                        color: AppColors.secondary,
                      ),
                      name: 'Distance',
                      number: stepsService
                          .calculateDistance(currentSteps)
                          .toString(),
                      unit: 'km',
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                Row(
                  mainAxisAlignment: .spaceEvenly,
                  spacing: 10,
                  children: [
                    _buildContainer(
                      context: context,
                      icon: Icon(
                        size: 30,
                        Icons.timer_rounded,
                        color: AppColors.primary,
                      ),
                      name: 'Active Time',
                      number: '42',
                      unit: 'min',
                    ),
                    _buildContainer(
                      context: context,
                      icon: Icon(
                        size: 30,
                        Icons.terrain_rounded,
                        color: AppColors.secondary,
                      ),
                      name: 'Elevation',
                      number: '12',
                      unit: 'flrs',
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _buildContainer({
    required BuildContext context,
    required String number,
    required String unit,
    required Icon icon,
    required String name,
  }) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.2,
      width: MediaQuery.sizeOf(context).height * 0.195,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        color: AppColors.surface,
        borderRadius: .circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.sizeOf(context).height * 0.05,
          left: MediaQuery.sizeOf(context).height * 0.05,
        ),
        child: Column(
          spacing: 5,
          crossAxisAlignment: .start,
          children: [
            icon,
            Row(
              spacing: 5,
              children: [
                Text(number, style: AppTypgraphy.headlineSmall),
                Text(
                  unit,
                  style: AppTypgraphy.labelSmall.copyWith(color: Colors.grey),
                ),
              ],
            ),
            Text(
              name,
              style: AppTypgraphy.bodyMedium.copyWith(
                color: Colors.grey,
                fontWeight: .w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WeeklyChart extends StatelessWidget {
  const WeeklyChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: BarChart(
        BarChartData(
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                reservedSize: 23,
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  const labels = [
                    'Sun',
                    'Mon',
                    'Tue',
                    'Wed',
                    'Thu',
                    'Fri',
                    'Sat',
                  ];

                  int index = value.toInt();

                  if (index >= 0 && index < labels.length) {
                    return SideTitleWidget(
                      meta: meta,
                      child: Text(
                        labels[index],
                        style: AppTypgraphy.labelSmall.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: false),
          alignment: .spaceAround,

          barGroups: [
            BarChartGroupData(
              x: 0,
              barRods: [
                BarChartRodData(toY: 20, color: AppColors.secondary, width: 18),
              ],
            ),
            BarChartGroupData(
              x: 1,
              barRods: [
                BarChartRodData(toY: 25, color: AppColors.secondary, width: 18),
              ],
            ),
            BarChartGroupData(
              x: 2,
              barRods: [
                BarChartRodData(toY: 10, color: AppColors.secondary, width: 18),
              ],
            ),
            BarChartGroupData(
              x: 3,
              barRods: [
                BarChartRodData(toY: 12, color: AppColors.secondary, width: 18),
              ],
            ),
            BarChartGroupData(
              x: 4,
              barRods: [
                BarChartRodData(toY: 7, color: AppColors.secondary, width: 18),
              ],
            ),
            BarChartGroupData(
              x: 5,
              barRods: [
                BarChartRodData(toY: 30, color: AppColors.secondary, width: 18),
              ],
            ),
            BarChartGroupData(
              x: 6,
              barRods: [
                BarChartRodData(toY: 25, color: AppColors.secondary, width: 18),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProgressWidget extends StatelessWidget {
  final int numberOfSteps;
  final int goalNumber;
  const ProgressWidget({
    super.key,
    required this.numberOfSteps,
    required this.goalNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: .center,
      children: [
        Align(
          alignment: .center,
          child: SizedBox(
            height: 300,
            width: 300,
            child: CircularProgressIndicator(
              value: numberOfSteps / goalNumber,
              strokeWidth: 15,
              color: AppColors.primary,
              backgroundColor: Colors.grey[200],
            ),
          ),
        ),
        Column(
          spacing: 5,
          children: [
            Text(
              formattedStepNumber(numberOfSteps),
              style: AppTypgraphy.displayMedium,
            ),
            Text(
              'Steps today',
              style: AppTypgraphy.bodyMedium.copyWith(
                color: Colors.grey,
                fontWeight: .w800,
              ),
            ),
            Container(
              height: 30,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: .circular(25),
                color: AppColors.primary.withOpacity(0.3),
              ),
              child: Center(
                child: Text(
                  'Goal: ${formattedStepNumber(goalNumber)}',
                  style: AppTypgraphy.labelSmall.copyWith(fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

String formattedStepNumber(int number) {
  String str = number.toString();

  if (number >= 1000 && number <= 9999) {
    return '${str[0]},${str.substring(1)}';
  }

  if (number >= 10000) {
    return '${str.substring(0, 2)},${str.substring(2)}';
  }

  return str;
}

String dateTimeString() {
  DateTime now = DateTime.now();
  String day = DateFormat('EEEE').format(now);
  String month = DateFormat('MMMM').format(now);
  String year = DateFormat('yyyy').format(now);
  return '$day, $month $year';
}
