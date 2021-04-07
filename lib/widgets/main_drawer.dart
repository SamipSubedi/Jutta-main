import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shoesfyp2/screens/News.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedDestination = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'JUTTA',
              style: textTheme.headline6,
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          ListTile(
            leading: Icon(Icons.new_releases),
            title: Text('NEWS'),
            selected: _selectedDestination == 0,
            onTap: () => News(),
          ),
        ],
      ),
    );

  }

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }
}
