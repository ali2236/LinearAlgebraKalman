import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:datafusion/main.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AccuracyChart extends StatefulWidget {
  final ValueNotifier<double> accuracy;

  const AccuracyChart({Key key, this.accuracy}) : super(key: key);

  @override
  _AccuracyChartState createState() => _AccuracyChartState();
}

class _ChartData {
  final double accuracy;
  final double timeStamp;

  _ChartData(this.accuracy, this.timeStamp);
}

class _AccuracyChartState extends State<AccuracyChart> {
  List<_ChartData> data = [];
  var start = 0.0;

  @override
  void initState() {
    super.initState();
    widget.accuracy.addListener(_update);
  }

  void _update(){
    data.add(_ChartData(widget.accuracy.value, start++));
    if(mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: NumericAxis(majorGridLines: MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
          axisLine: AxisLine(width: 0),
          majorTickLines: MajorTickLines(size: 0)),
      series: <LineSeries<_ChartData, double>>[
        LineSeries<_ChartData, double>(
          dataSource: data,
          xValueMapper: (d, i) => d.timeStamp,
          yValueMapper: (d, i) => d.accuracy,
          color: Theme.of(context).accentColor,
          animationDuration: simulation.emitRate.toDouble(),
          dataLabelSettings: DataLabelSettings(
              isVisible: false, labelAlignment: ChartDataLabelAlignment.top),
        ),
      ],
    );
  }
}
