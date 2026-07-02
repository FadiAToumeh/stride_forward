import 'package:flutter/material.dart';
import 'package:stride_forward/constants/app_theme.dart';

class HistorySceen extends StatelessWidget {
  const HistorySceen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: .start,
          children: <Widget>[
            Row(
              mainAxisAlignment: .spaceBetween,
              //head text,
              children: [buileHeadText(), buildIconButton()],

              //Icon button
            ),
          ],
        ),
      ),
    );
  }
}

Widget buileHeadText() {
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

Widget buildIconButton() {
  return Container(
    height: 50,
    width: 50,
    decoration: BoxDecoration(color: Colors.grey[200], shape: .circle),
    child: Icon(Icons.tune_rounded, color: Colors.black87),
  );
}

class ChartContainer extends StatelessWidget {
  final int? average;
  const ChartContainer({super.key, this.average});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
