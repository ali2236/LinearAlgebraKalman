import 'dart:io';

import 'package:datafusion/res.dart';
import 'package:datafusion/widgets/widget_icon_drawer.dart';
import 'package:flutter/material.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class ReportPage extends StatefulWidget {
  final int initialPage;

  const ReportPage({Key key, this.initialPage}) : super(key: key);

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  PdfController controller;
  var a = ValueNotifier(1);

  @override
  void initState() {
    super.initState();
    controller = PdfController(
      document: PdfDocument.openAsset(Res.report),
      initialPage: widget.initialPage ?? 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Scaffold.hasDrawer(context) ? DrawerIcon(context) : null,
        title: Text('گزارش'),
        titleSpacing: 4.0,
        actions: <Widget>[
          IconButton(
            tooltip: 'نمایش در نرم افزار خارجی',
            icon: Icon(Icons.open_in_browser),
            onPressed: () async{
              var dir = await getExternalStorageDirectory();
              var file = File('${dir.path}/report.pdf');
              if(!(await file.exists())){
                var asset = await DefaultAssetBundle.of(context).load(Res.report);
                await file.writeAsBytes(asset.buffer.asUint8List(asset.offsetInBytes, asset.lengthInBytes));
              }
              await OpenFile.open(file.path);
            },
          ),
          AnimatedBuilder(
              animation: a,
              builder: (context, _) {
                return FlatButton(
                  onPressed: null,
                  child: Text(
                      '${controller.page ?? a.value ?? 1}/${controller.pagesCount ?? 15}'),
                  disabledTextColor: Colors.white,
                );
              }),
        ],
      ),
      body: PdfView(
        controller: controller,
        onPageChanged: (_) => a.value++,
        scrollDirection: Axis.vertical,
      ),
    );
  }
}
