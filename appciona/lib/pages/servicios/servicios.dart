import 'package:appciona/pages/widgets/drawer.dart';
import 'package:flutter/material.dart';

class ServiciosPage extends StatefulWidget {
  final Widget drawer;
  const ServiciosPage({
    Key? key,
    required this.drawer,
  }) : super(key: key);

  @override
  _ServiciosPageState createState() => _ServiciosPageState();
}

class _ServiciosPageState extends State<ServiciosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        title: const Text("Servicios"),
        centerTitle: true,
        actions: [
          Image.asset(
            'assets/images/logo-green.png',
            fit: BoxFit.contain,
          )
        ],
      ),
      drawer: Drawer(
        child: widget.drawer,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              Text('Servicios'),
            ],
          ),
        ),
      ),
    );
  }
}
