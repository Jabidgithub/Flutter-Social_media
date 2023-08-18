import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Analytics extends StatelessWidget {
  final double followers;
  final double followings;
  final double likes;
  final double comments;
  final double videos;
  final double posts;
  const Analytics(
      {super.key,
      required this.followers,
      required this.followings,
      required this.likes,
      required this.comments,
      required this.videos,
      required this.posts});

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('Followers', followers),
      ChartData('Followings', followings),
      ChartData('Likes', likes),
      ChartData('Comments', comments),
      ChartData('Views', 5),
      ChartData('Videos', videos),
      ChartData('Posts', posts),
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
