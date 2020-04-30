import 'package:after_layout/after_layout.dart';
import 'package:datafusion/pages/page_main.dart';
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
    Future.delayed(Duration(seconds: 3)).then((_) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) {
          return MainPage();
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var accent = Theme.of(context).accentColor;
    return Scaffold(
      body: Center(
        child: Shimmer.fromColors(
          highlightColor: Color.lerp(accent, Colors.white, 0.8),
          baseColor: accent,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Text(
              'LINEAR\nALGEBRA\nKALMAN',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
