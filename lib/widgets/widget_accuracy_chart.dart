import 'package:flutter/material.dart';
import 'package:start_chart/chart/line_chart.dart';
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
  List<double> percents = [];
  var start = 0.0;
  var startTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    widget.accuracy.addListener(_update);
  }

  void _update() {
    chartdata.add(_ChartData(widget.accuracy.value, start++));
    percents.add(
        double.tryParse((widget.accuracy.value * 100).toStringAsPrecision(4)));
    if (percents.length > 50) {
      percents.removeAt(0);
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
    return SfCartesianChart(
        plotAreaBorderWidth: 0,
        primaryXAxis: NumericAxis(majorGridLines: MajorGridLines(width: 0)),
        primaryYAxis: NumericAxis(
            axisLine: AxisLine(width: 0),
            majorTickLines: MajorTickLines(size: 0)),
        series: <LineSeries<_ChartData, double>>[
          LineSeries<_ChartData, double>(
            dataSource: [
              _ChartData(0.8, 1.0),
              _ChartData(0.81, 2.0),
              _ChartData(0.85, 3.0),
              _ChartData(0.9, 4.0),
              _ChartData(0.84, 5.0),
            ],
            color: const Color.fromRGBO(192, 108, 132, 1),
            xValueMapper: (_ChartData data, _) => data.timeStamp,
            yValueMapper: (_ChartData data, _) => data.accuracy,
            animationDuration: 0,
            dataLabelSettings: DataLabelSettings(
                isVisible: false, labelAlignment: ChartDataLabelAlignment.top),
          )
        ]);
    return Container(
      key: UniqueKey(),
      child: LineChart(
        data: percents,
        lineColor: Color.lerp(accent, Colors.white, 0.4),
        pointColor: accent,
        lineWidth: 1.0,
        textfontSize: 14.0,
      ),
    );
  }
}
