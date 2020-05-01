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
  List<_ChartData> chartdata = [];
  var start = 0.0;
  var startTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    widget.accuracy.addListener(_update);
  }

  void _update() {
    chartdata.add(_ChartData(widget.accuracy.value, start++));
    if (chartdata.length > 50) {
      chartdata.removeAt(0);
    }
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    widget.accuracy.removeListener(_update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var accent = Theme.of(context).accentColor;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: SfCartesianChart(
          plotAreaBorderWidth: 0,
          primaryXAxis: NumericAxis(majorGridLines: MajorGridLines(width: 0)),
          primaryYAxis: NumericAxis(
              axisLine: AxisLine(width: 0),
              majorTickLines: MajorTickLines(size: 0)),
          series: <LineSeries<_ChartData, double>>[
            LineSeries<_ChartData, double>(
              dataSource: chartdata,
              color: accent,
              xValueMapper: (_ChartData data, _) => data.timeStamp,
              yValueMapper: (_ChartData data, _) => data.accuracy,
              animationDuration: 0.0,
              dataLabelSettings: DataLabelSettings(
                isVisible: false,
                labelAlignment: ChartDataLabelAlignment.top,
              ),
            )
          ]),
    );
  }
}
