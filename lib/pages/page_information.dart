import 'package:datafusion/pages/page_report.dart';
import 'package:datafusion/widgets/widget_icon_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../res.dart';

class InformationPage extends StatefulWidget {
  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  @override
  Widget build(BuildContext context) {
    var infos = [
      Info('تلفیق داده', Res.data_fusion),
      Info('فیلتر کالمن', Res.kalman_filter),
      Info('جسم مجازی', Res.virtual_object),
      Info('سنسور مجازی', Res.virtual_sensor),
      Info('سنسور ادغام', Res.merge_sensor),
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
                    body: FutureBuilder<String>(
                      future: DefaultAssetBundle.of(context)
                          .loadString(info.mdFilePath),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Markdown(
                            data: snapshot.data,
                            imageBuilder: (uri) {
                              return Image.asset(uri.path);
                            },
                            onTapLink: (link) async {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (c) => ReportPage(
                                      initialPage: int.tryParse(link))));
                            },
                          );
                        }
                        return Container();
                      },
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
  final String mdFilePath;

  Info(this.title, this.mdFilePath);
}
