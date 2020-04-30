import 'package:flutter/material.dart';

import 'page_home.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  var selectedIndex = 0;

  var pages = [
    HomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(child: Container()),
            ListTile(
              selected: selectedIndex == 0,
              title: Text('صفحه اصلی'),
              leading: Icon(Icons.home),
            ),
          ],
        ),
      ),
      body: pages[selectedIndex],
    );
  }
}
