import 'package:flutter/material.dart';

class appBarCionaPrincipal extends StatefulWidget {
  const appBarCionaPrincipal({Key? key}) : super(key: key);
  @override
  _appBarCionaPrincipalState createState() => _appBarCionaPrincipalState();
}

class _appBarCionaPrincipalState extends State<appBarCionaPrincipal> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('AppCiona'),
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
