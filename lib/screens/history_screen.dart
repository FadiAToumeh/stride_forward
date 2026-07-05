import 'dart:developer';

import 'package:fl_chart/fl_chart.dart' as fl_chart;
import 'package:flutter/material.dart';
import 'package:stride_forward/constants/app_theme.dart';

class HistorySceen extends StatelessWidget {
  const HistorySceen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.05,
          ),
          child: SingleChildScrollView(
            child: Column(
              spacing: MediaQuery.sizeOf(context).height * 0.05,

              children: <Widget>[
                Row(
                  mainAxisAlignment: .spaceBetween,
                  //head text,
                  children: [
                    _buildHeadText(),
                    _buildIconButton(
                      onTap: () {
                        log('it works now');
                      },
                    ),
                  ],

                  //Icon button
                ),
                ChartContainer(average: 3642),
                Wrap(
                  direction: .horizontal,
                  spacing: MediaQuery.sizeOf(context).width * 0.1,
                  children: [
                    _buildContainer(
                      context: context,
                      number: '54890',
                      unit: 'steps',
                      icon: Icon(
                        Icons.directions_walk_rounded,
                        color: AppColors.primary,
                      ),
                      name: 'Total Steps',
                    ),
                    _buildContainer(
                      context: context,
                      number: '18',
                      unit: 'min/km',
                      icon: Icon(
                        Icons.speed_rounded,
                        color: AppColors.secondary,
                      ),
                      name: 'Avg. Pace',
                    ),
                  ],
                ),
                // recent activity row
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: <Widget>[
                    Text(
                      'Recent Activity',
                      style: AppTypgraphy.bodyMedium.copyWith(
                        fontSize: 21,
                        fontWeight: .w600,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        log('Show all button clicked!');
                      },
                      child: Text(
                        'Show All',
                        style: AppTypgraphy.bodyMedium.copyWith(
                          color: AppColors.secondary,
                          fontWeight: .w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  spacing: 10,
                  children: [
                    _buildWalkContainer(
                      walks: Walks.morningWalk,
                      context: context,
                    ),
                    _buildWalkContainer(
                      walks: Walks.afternoonWalk,
                      context: context,
                    ),
                    _buildWalkContainer(
                      walks: Walks.eveningWalk,
                      context: context,
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum Walks {
  morningWalk(
    'Morning Walk',
    Icon(Icons.directions_walk_rounded, color: Colors.blue),
    Color.fromARGB(255, 149, 190, 224),
  ),
  afternoonWalk(
    'Afternoon Walk',
    Icon(Icons.directions_run_rounded, color: Colors.pink),
    Color.fromARGB(255, 239, 122, 161),
  ),
  eveningWalk(
    'Evening Walk',
    Icon(Icons.self_improvement_rounded, color: Colors.orange),
    Color.fromARGB(255, 255, 211, 144),
  );

  final String walk;
  final Icon icon;
  final Color color;

  const Walks(this.walk, this.icon, this.color);
}

Widget _buildWalkContainer({
  required Walks walks,
  required BuildContext context,
}) {
  return Container(
    height: MediaQuery.sizeOf(context).height * 0.14,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey[200]!),
      color: AppColors.background,
      borderRadius: .circular(12),
    ),
    child: Row(
      mainAxisAlignment: .start,
      spacing: 20,
      children: [
        SizedBox(width: MediaQuery.sizeOf(context).width * 0.01),
        Container(
          height: MediaQuery.sizeOf(context).height * 0.08,
          width: MediaQuery.sizeOf(context).height * 0.08,
          decoration: BoxDecoration(
            color: walks.color.withOpacity(0.5),
            borderRadius: .circular(12),
          ),
          child: Center(child: walks.icon),
        ),
        Column(
          spacing: 5,
          crossAxisAlignment: .start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              walks.walk,
              style: AppTypgraphy.bodyMedium.copyWith(fontWeight: .w600),
            ),
            Text(
              '2.5 km , 30 min',
              style: AppTypgraphy.bodyMedium.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ],
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
    width: MediaQuery.sizeOf(context).width * 0.4,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey[200]!),
      color: AppColors.surface,
      borderRadius: .circular(12),
    ),
    child: Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.sizeOf(context).height * 0.05,
        left: MediaQuery.sizeOf(context).height * 0.03,
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

Widget _buildHeadText() {
  return Column(
    spacing: 3,
    crossAxisAlignment: .start,
    children: [
      Text(
        "Activity History",
        style: AppTypgraphy.headlineSmall.copyWith(fontSize: 32),
      ),
      Text(
        'Your movement over time',
        style: AppTypgraphy.bodyMedium.copyWith(
          color: Colors.grey,
          fontWeight: .w500,
        ),
      ),
    ],
  );
}

Widget _buildIconButton({required void Function()? onTap}) {
  return InkWell(
    borderRadius: BorderRadius.circular(100),
    onTap: onTap,
    child: Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(color: Colors.grey[200], shape: .circle),
      child: Icon(Icons.tune_rounded, color: Colors.black87),
    ),
  );
}

class ChartContainer extends StatelessWidget {
  final int? average;
  const ChartContainer({super.key, this.average});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: .circular(15),
        boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 0.5)],
      ),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      'Average Daily Steps',
                      style: AppTypgraphy.bodyMedium.copyWith(
                        color: Colors.grey,
                        fontWeight: .bold,
                      ),
                    ),
                    Text('$average', style: AppTypgraphy.headlineSmall),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withOpacity(0.5),
                    borderRadius: .circular(25),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Row(
                      mainAxisAlignment: .center,
                      spacing: 5,
                      children: [
                        Icon(
                          Icons.arrow_upward,
                          color: AppColors.surface,
                          size: 20,
                        ),
                        Text("12%", style: TextStyle(color: AppColors.surface)),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: MediaQuery.sizeOf(context).height * 0.08),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.25,
              child: LineChart(),
            ),
          ],
        ),
      ),
    );
  }
}

class LineChart extends StatelessWidget {
  const LineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return fl_chart.LineChart(
      fl_chart.LineChartData(
        backgroundColor: AppColors.background,
        titlesData: fl_chart.FlTitlesData(
          show: true,
          leftTitles: fl_chart.AxisTitles(
            sideTitles: fl_chart.SideTitles(showTitles: false),
          ),
          rightTitles: fl_chart.AxisTitles(
            sideTitles: fl_chart.SideTitles(showTitles: false),
          ),
          topTitles: fl_chart.AxisTitles(
            sideTitles: fl_chart.SideTitles(showTitles: false),
          ),
          bottomTitles: fl_chart.AxisTitles(
            sideTitles: fl_chart.SideTitles(
              showTitles: true,
              interval: 1,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                final days = ['Sun', 'Mon', 'Tue', 'Thu', 'Fri', 'Sat'];
                final daysIndex = value.toInt() % 7;
                final dayName = days[daysIndex];
                return fl_chart.SideTitleWidget(
                  meta: meta,
                  child: Text(dayName),
                );
              },
            ),
          ),
        ),
        gridData: fl_chart.FlGridData(show: false),
        borderData: fl_chart.FlBorderData(show: false),
        lineBarsData: [
          fl_chart.LineChartBarData(
            spots: [
              fl_chart.FlSpot(0, 1),
              fl_chart.FlSpot(1, 3),
              fl_chart.FlSpot(2, 3),
              fl_chart.FlSpot(3, 4),
              fl_chart.FlSpot(5, 2),
            ],
            isCurved: true,
            barWidth: 4,
            color: AppColors.secondary,
            belowBarData: fl_chart.BarAreaData(
              color: AppColors.secondary.withOpacity(0.3),
              show: true,
            ),
            dotData: fl_chart.FlDotData(
              show: true,
              getDotPainter: (p0, p1, p2, p3) {
                return fl_chart.FlDotCirclePainter(
                  radius: 8,
                  color: AppColors.secondary,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
