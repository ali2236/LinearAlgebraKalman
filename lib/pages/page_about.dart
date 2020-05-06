import 'package:datafusion/widgets/widget_icon_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get_version/get_version.dart';

import '../res.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    var style = TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
    return Scaffold(
      appBar: AppBar(
        leading: DrawerIcon(context),
        title: Text('درباره'),
        titleSpacing: 4.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(Res.icon, height: 128, width: 128),
              ),
              FutureBuilder<String>(
                future: GetVersion.projectVersion,
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return Text(snapshot?.data ?? '???');
                  }
                  return Text('???');
                },
              ),
              SizedBox(height: 24.0),
              Text('پروژه جبر خطی', textAlign: TextAlign.center),
              Text(
                'کاربرد جبر خطی در نرم افزار اندرویدی که دمای n نقطه را با استفاده از دیتا فیوژن به دست آورد',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text('استاد'),
                        Text('دکتر میگلی', style: style),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text('حل تمرین'),
                        Text('غلامرضا قاسمی', style: style),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text('تهیه کننده و برنامه نویس'),
                        Text('علی قنبری', style: style),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
