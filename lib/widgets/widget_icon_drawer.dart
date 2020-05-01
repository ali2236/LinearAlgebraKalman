import 'package:flutter/material.dart';

class DrawerIcon extends StatelessWidget {

  final BuildContext context;

  const DrawerIcon(this.context);
  @override
  Widget build(BuildContext _context) {
    return IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        });
  }
}
