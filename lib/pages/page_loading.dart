import 'package:after_layout/after_layout.dart';
import 'package:datafusion/main.dart';
import 'package:datafusion/pages/page_main.dart';
import 'package:datafusion/services/service_simulation.dart';
import 'package:datafusion/widgets/widget_lak.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with AfterLayoutMixin<LoadingPage> {
  @override
  void afterFirstLayout(BuildContext context) async {
    simulation = SimulationService();
    await simulation.run();
    Future.delayed(Duration(seconds: 2)).then((_) async {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (c) => MainPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var accent = Theme.of(context).accentColor;
    var style = TextStyle(fontWeight: FontWeight.bold, fontSize: 40);
    return Scaffold(
      body: Center(
        child: Shimmer.fromColors(
          highlightColor: Color.lerp(accent, Colors.white, 0.8),
          baseColor: accent,
          child: LAK(),
        ),
      ),
    );
  }
}
