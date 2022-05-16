import 'package:flutter/material.dart';

class RegistroPage extends StatefulWidget {
  const RegistroPage({Key? key}) : super(key: key);

  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text('Registro'),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Nombre',
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Apellidos',
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'DNI',
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Zona del municipio',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
