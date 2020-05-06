import 'package:datafusion/widgets/widget_icon_drawer.dart';
import 'package:flutter/material.dart';

class InformationPage extends StatefulWidget {
  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  @override
  Widget build(BuildContext context) {
    var infos = [
      Info('فیلتر کالمن', (c) {
        return ListView(
          children: <Widget>[

          ],
        );
      }),
      Info('تلفیق داده', null),
      Info('جسم مجازی', null),
      Info('سنسور مجازی', null),
      Info('سنسور ادغام', null),
    ];

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
                    body: info.builder(context),
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
  final WidgetBuilder builder;

  Info(this.title, this.builder);
}
