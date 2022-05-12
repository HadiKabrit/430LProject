import 'package:flutter/material.dart';
import 'package:mobile430lproject/models/points.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChart extends StatefulWidget {
  List<Point> pointsList;
  LineChart({Key? key, required this.pointsList}) : super(key: key);

  @override
  _LineChartState createState() => _LineChartState();
}

class _LineChartState extends State<LineChart> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      height: 300,
      margin: const EdgeInsets.all(8.0),
      child: SfCartesianChart(
        plotAreaBackgroundColor: Colors.grey[200],
        plotAreaBorderWidth: 10,
        // title: ChartTitle(text: "My Blood Sugar Data"),

        series: [
          StackedLineSeries(
            name: 'Blood Sugar Level',
            dataSource: widget.pointsList,
            xValueMapper: (Point p, _) => p.X,
            yValueMapper: (Point p, _) => p.Y,
            width: 4,
            color: Colors.red,
            isVisible: true,
            markerSettings: const MarkerSettings(
              isVisible: true,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
