import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Analytics extends StatelessWidget {
  const Analytics({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('Followers', 100),
      ChartData('Followings', 120),
      ChartData('Likes', 225),
      ChartData('Comments', 86),
      ChartData('Views', 129),
      ChartData('Videos', 52),
      ChartData('Posts', 52),
    ];
    return Container(
      child: Center(
        child: Container(
          child: SfCircularChart(
            legend: Legend(
                isVisible: true,
                overflowMode: LegendItemOverflowMode.wrap,
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                )),
            series: <CircularSeries>[
              // Renders radial bar chart
              RadialBarSeries<ChartData, String>(
                dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  textStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.blueGrey,
                  ),
                ),
                gap: '2%',
                dataSource: chartData,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                cornerStyle: CornerStyle.bothFlat,
                radius: '100%',
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}
