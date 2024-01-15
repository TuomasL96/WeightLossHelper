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
          children: [WeightChart(userRepository.currentUser.weighIns)],
        ),
      );
}

class WeightChart extends StatelessWidget {
  final List<WeighIn> weighIns;
  const WeightChart(this.weighIns, {super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: LineChart(
        LineChartData(
          borderData: FlBorderData(
              border: const Border(bottom: BorderSide(), left: BorderSide())),
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(
            bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          lineBarsData: [
            LineChartBarData(
                spots: weighIns
                    .map((weighIn) => FlSpot(
                        weighIns.indexOf(weighIn).toDouble(), weighIn.weight))
                    .toList(),
                isCurved: false,
                dotData: const FlDotData(
                  show: true,
                ),
                color: Colors.blue),
          ],
        ),
        duration: const Duration(milliseconds: 250),
      ),
    );
  }
}
