import 'package:datafusion/widgets/widget_icon_drawer.dart';
import 'package:flutter/material.dart';

class InformationPage extends StatefulWidget {
  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  var infos = [
    Info('فیلتر کالمن', 'TODO'),
    Info('تلفیق داده', 'TODO'),
    Info('جسم مجازی', 'TODO'),
    Info('سنسور مجازی', 'TODO'),
    Info('سنسور ادغام', 'TODO'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: DrawerIcon(context),
        title: Text('دانشنامه'),
        titleSpacing: 4.0,
      ),
      body: ListView.builder(
        itemCount: infos.length,
        itemBuilder: (context, i) {
          var info = infos[i];
          return ListTile(
            title: Text(info.title),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                    appBar: AppBar(
                      title: Text(info.title),
                      titleSpacing: 4.0,
                    ),
                    body: ListView(
                      children: <Widget>[
                        Text(info.pdfPath),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class Info {
  final String title;
  final String pdfPath;

  Info(this.title, this.pdfPath);
}
