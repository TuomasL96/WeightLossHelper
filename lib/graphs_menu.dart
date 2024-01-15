import 'dart:ffi';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:open_weight_tracker/main.dart';
import 'package:open_weight_tracker/models.dart';
import 'package:path/path.dart';

class GraphsMenu extends StatefulWidget {
  const GraphsMenu({super.key});

  @override
  State<GraphsMenu> createState() => _GraphsMenuState();
}

class _GraphsMenuState extends State<GraphsMenu> {
  @override
  Widget build(BuildContext context) {
    return const ChartCard();
  }
}

class ChartCard extends Card {
  const ChartCard({super.key});
  @override
  // TODO: implement child
  Widget? get child => Container(
        padding: const EdgeInsets.all(2),
        child: Row(
          children: [
            WeightChart(userRepository
                .getWeighInsSortedByDate(userRepository.currentUser))
          ],
        ),
      );
}

class WeightChart extends StatelessWidget {
  final List<WeighIn> weighIns;
  const WeightChart(this.weighIns, {super.key});

  DateTime getDateOnly(DateTime dateTime) => DateUtils.dateOnly(dateTime);

  SideTitles get _bottomTitles => SideTitles(
      showTitles: true,
      interval: Duration.millisecondsPerDay.toDouble(),
      getTitlesWidget: (value, meta) {
        String text = '';
        if (value != meta.min) {
          // Workaround for showing the min value twice
          final DateTime date =
              DateTime.fromMillisecondsSinceEpoch(value.toInt());
          text = DateFormat.MMMd().format(date);
        }
        return Text(
          text,
          style: const TextStyle(
            fontSize: 10,
          ),
        );
      });

  SideTitles get _leftTitles => SideTitles(
      showTitles: true,
      interval: 0.5,
      getTitlesWidget: (value, meta) {
        String text = '';
        text = value.toString();
        return Text(
          text,
          style: const TextStyle(
            fontSize: 8,
          ),
        );
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: AspectRatio(
            aspectRatio: 1.5,
            child: LineChart(LineChartData(
              // minY: userRepository
              //         .getWeighInsSortedByWeight(userRepository.currentUser)
              //         .first
              //         .weight -
              //     1.0,
              // maxY: userRepository
              //         .getWeighInsSortedByWeight(userRepository.currentUser)
              //         .last
              //         .weight +
              //     1.0,
              minX: (getDateOnly(weighIns.first.date).millisecondsSinceEpoch -
                      Duration.millisecondsPerDay)
                  .toDouble(),
              maxX: (getDateOnly(weighIns.last.date).millisecondsSinceEpoch +
                      Duration.millisecondsPerDay)
                  .toDouble(),
              borderData: FlBorderData(
                  border:
                      const Border(bottom: BorderSide(), left: BorderSide())),
              gridData: const FlGridData(show: false),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  axisNameSize: 32,
                  drawBelowEverything: false,
                  sideTitles: _bottomTitles,
                  axisNameWidget: const Text(
                      style: TextStyle(fontWeight: FontWeight.bold), 'Date'),
                ),
                leftTitles: AxisTitles(
                  axisNameSize: 32,
                  drawBelowEverything: false,
                  sideTitles: _leftTitles,
                  axisNameWidget: const Text(
                      style: TextStyle(fontWeight: FontWeight.bold), 'Weight'),
                ),
                topTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              lineBarsData: [
                LineChartBarData(
                    spots: weighIns
                        .map((weighIn) => FlSpot(
                            getDateOnly(weighIn.date)
                                .millisecondsSinceEpoch
                                .toDouble(),
                            weighIn.weight))
                        .toList(),
                    isCurved: false,
                    dotData: const FlDotData(
                      show: true,
                    ),
                    color: Colors.blue),
              ],
              lineTouchData: LineTouchData(
                  enabled: true,
                  touchCallback:
                      (FlTouchEvent event, LineTouchResponse? touchResponse) {
                    // TODO : Utilize touch event here to perform any operation
                  },
                  touchTooltipData: LineTouchTooltipData(
                    tooltipBgColor: Colors.blue,
                    tooltipRoundedRadius: 20.0,
                    showOnTopOfTheChartBoxArea: false,
                    fitInsideHorizontally: false,
                    fitInsideVertically: false,
                    tooltipMargin: 16,
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map(
                        (LineBarSpot touchedSpot) {
                          const textStyle = TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          );
                          return LineTooltipItem(
                            '${DateFormat.MMMd().format(weighIns[touchedSpot.spotIndex].date)} \n${weighIns[touchedSpot.spotIndex].weight.toStringAsFixed(2)} Kg',
                            textStyle,
                          );
                        },
                      ).toList();
                    },
                  ),
                  getTouchedSpotIndicator:
                      (LineChartBarData barData, List<int> indicators) {
                    return indicators.map(
                      (int index) {
                        const line = FlLine(
                            color: Colors.grey,
                            strokeWidth: 1,
                            dashArray: [2, 4]);
                        return const TouchedSpotIndicatorData(
                          line,
                          FlDotData(show: false),
                        );
                      },
                    ).toList();
                  },
                  getTouchLineEnd: (_, __) => double.infinity),
            ))),
      ),
    );
  }
}
