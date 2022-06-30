import 'package:appciona/pages/servicios/servicios_controller.dart';
import 'package:flutter/material.dart';

class ServiciosPage extends StatefulWidget {
  const ServiciosPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ServiciosPage> createState() => _ServiciosPageState();
}

class _ServiciosPageState extends State<ServiciosPage> {
  final ServiciosController _controller = ServiciosController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text('Manda tu queja o sugerencia'),
              TextFormField(),
              TextFormField(),
              TextFormField(),
            ],
          ),
        ),
      ),
    );
  }
}
