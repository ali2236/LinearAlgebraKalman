import 'package:datafusion/widgets/widget_icon_drawer.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: DrawerIcon(context),
        title: Text('درباره'),
        titleSpacing: 4.0,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        children: <Widget>[
          SizedBox(height: 8.0),
          Text('موضوع پروژه: ' + 'کاربرد جبر خطی در نرم افزار اندرویدی که دمای n نقطه را با استفاده از دیتا فیوژن به دست آورد.'),
          Text('استاد: ' + 'دکتر وحید میگلی'),
          Text('حل تمرین: ' + 'غلامرضا قاسمی'),
          Text('برنامه نویس و سازنده: '+ 'علی قنبری'),
        ],
      ),
    );
  }
}
