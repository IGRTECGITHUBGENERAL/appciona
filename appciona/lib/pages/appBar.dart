import 'package:flutter/material.dart';

class appBarCiona extends StatefulWidget {
  final String name;
  const appBarCiona({Key? key, required this.name}) : super(key: key);
  @override
  _appBarCionaState createState() => _appBarCionaState();
}

class _appBarCionaState extends State<appBarCiona> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.name),
      leading: Icon(Icons.menu),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {},
        ),
      ],
    );
  }
}
