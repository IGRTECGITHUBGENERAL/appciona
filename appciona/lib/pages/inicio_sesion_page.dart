import 'package:appciona/pages/registro_page.dart';
import 'package:flutter/material.dart';

class InicioSesionPage extends StatefulWidget {
  const InicioSesionPage({Key? key}) : super(key: key);

  @override
  _InicioSesionPageState createState() => _InicioSesionPageState();
}

class _InicioSesionPageState extends State<InicioSesionPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'DNI',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Contraseña',
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Iniciar sesión'),
          ),
          TextButton(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RegistroPage(),
                ),
              ),
            },
            child: const Text('Registrarme'),
          ),
        ],
      ),
    );
  }
}
