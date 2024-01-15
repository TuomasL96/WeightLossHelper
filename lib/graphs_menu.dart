import 'dart:ffi';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:open_weight_tracker/main.dart';
import 'package:open_weight_tracker/models.dart';

class GraphsMenu extends StatefulWidget {
  const GraphsMenu({super.key});

  @override
  State<GraphsMenu> createState() => _GraphsMenuState();
}

class _GraphsMenuState extends State<GraphsMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(2, 10, 2, 20),
      alignment: Alignment.topCenter,
      child: const ChartCard(),
    );
  }
}

class ChartCard extends Card {
  const ChartCard({super.key});
  @override
  // TODO: implement child
  Widget? get child => Container(
        padding: const EdgeInsets.all(20),
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

  SideTitles get _bottomTitles => SideTitles(
      showTitles: true,
      getTitlesWidget: (value, meta) {
        String text = '';
        final DateTime date =
            DateTime.fromMillisecondsSinceEpoch(value.toInt());
        text = DateFormat.MMMd().format(date);
        return Text(
          text,
          style: const TextStyle(
            fontSize: 10,
          ),
        );
      });

  SideTitles get _leftTitles => SideTitles(
      showTitles: true,
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
    return AspectRatio(
        aspectRatio: 1.5,
        child: LineChart(LineChartData(
          minX: weighIns.first.date.millisecondsSinceEpoch.toDouble(),
          maxX: weighIns.last.date.millisecondsSinceEpoch.toDouble(),
          borderData: FlBorderData(
              border: const Border(bottom: BorderSide(), left: BorderSide())),
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(sideTitles: _bottomTitles),
            leftTitles: AxisTitles(sideTitles: _leftTitles),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          lineBarsData: [
            LineChartBarData(
                spots: weighIns
                    .map((weighIn) => FlSpot(
                        weighIn.date.millisecondsSinceEpoch.toDouble(),
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
                tooltipMargin: 0,
                getTooltipItems: (touchedSpots) {
                  return touchedSpots.map(
                    (LineBarSpot touchedSpot) {
                      const textStyle = TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
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
                        color: Colors.grey, strokeWidth: 1, dashArray: [2, 4]);
                    return const TouchedSpotIndicatorData(
                      line,
                      FlDotData(show: false),
                    );
                  },
                ).toList();
              },
              getTouchLineEnd: (_, __) => double.infinity),
        )));
  }
}
