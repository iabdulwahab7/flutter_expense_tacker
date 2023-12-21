import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:personal_expense/bar%20graph/bar_data.dart';

class MyBarGraph extends StatelessWidget {
  final double? maxY;
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thuAmount;
  final double friAmount;
  final double satAmount;
  const MyBarGraph({
    super.key,
    required this.maxY,
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thuAmount,
    required this.friAmount,
    required this.satAmount,
  });

  @override
  Widget build(BuildContext context) {
    // initialize bar data
    BarData myBarData = BarData(
      sunAmount: sunAmount,
      monAmount: monAmount,
      tueAmount: tueAmount,
      wedAmount: wedAmount,
      thurAmount: thuAmount,
      friAmount: friAmount,
      satAmount: satAmount,
    );
    myBarData.initializeBarData();
    return BarChart(BarChartData(
      titlesData: const FlTitlesData(
        show: true,
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
            sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: bottomTitle,
        )),
      ),
      gridData: const FlGridData(show: false),
      borderData: FlBorderData(show: false),
      maxY: maxY,
      minY: 0,
      barGroups: myBarData.barData
          .map((data) => BarChartGroupData(x: data.x, barRods: [
                BarChartRodData(
                  toY: data.y.toDouble(),
                  color: Colors.grey.shade800,
                  width: 20,
                  borderRadius: BorderRadius.circular(5),
                  backDrawRodData: BackgroundBarChartRodData(
                      show: true, color: Colors.white, toY: maxY),
                ),
              ]))
          .toList(),
    ));
  }
}

Widget bottomTitle(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.deepOrange,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text(
        'S',
        style: style,
      );
      break;
    case 1:
      text = const Text(
        'M',
        style: style,
      );
      break;
    case 2:
      text = const Text(
        'T',
        style: style,
      );
      break;
    case 3:
      text = const Text(
        'W',
        style: style,
      );
      break;
    case 4:
      text = const Text(
        'T',
        style: style,
      );
      break;
    case 5:
      text = const Text(
        'F',
        style: style,
      );
      break;
    case 6:
      text = const Text(
        'S',
        style: style,
      );
      break;
    default:
      text = const Text('', style: style);
  }
  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}
