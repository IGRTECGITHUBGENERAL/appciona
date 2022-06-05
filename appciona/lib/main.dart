import 'package:appciona/pages/mensajeria/Mensajeria.dart';
import 'package:appciona/pages/audiovisual/audiovisual.dart';
import 'package:appciona/pages/inicio/inicio.dart';
import 'package:appciona/pages/perfil/perfil.dart';
import 'package:appciona/pages/servicios/servicios.dart';
import 'package:appciona/pages/turismo/turismo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppCiona',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        activeColor: const Color(0XFF00BAEF),
        inactiveColor: Colors.black,
        //onTap: (index) => setState(() => {_currentIndex = index}),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.play_circle_outline,
            ),
            label: 'Audiovisual',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list,
            ),
            label: 'Servicios',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.map,
            ),
            label: 'Turismo',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (context) => const InicioPage(),
            );
          case 1:
            return CupertinoTabView(
              builder: (context) => const AudiovisualPage(),
            );
          case 2:
            return CupertinoTabView(
              builder: (context) => const ServiciosPage(),
            );
          case 3:
            return CupertinoTabView(
              builder: (context) => const TurismoPage(),
            );
          default:
            return CupertinoTabView(
              builder: (context) => const InicioPage(),
            );
        }
      },
    );
  }
}
