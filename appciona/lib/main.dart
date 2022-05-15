import 'package:appciona/pages/Mensajeria.dart';
import 'package:appciona/pages/agenda_page.dart';
import 'package:appciona/pages/audiovisual.dart';
import 'package:appciona/pages/inicio.dart';
import 'package:appciona/pages/perfil.dart';
import 'package:appciona/pages/servicios.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
  /*
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();*/
  int _currentIndex = 0;
  final pages = [
    const InicioPage(),
    const AudiovisualPage(),
    const ServiciosPage(),
    const AgendaPage(),
    const MensajeriaPage(),
    const PerfilPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('AppCiona'),
        centerTitle: true,
        leading: const Icon(Icons.menu),
        actions: [
          Image.asset(
            'assets/images/logo-green.png',
            fit: BoxFit.contain,
            height: 32,
          )
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => {_currentIndex = index}),
        unselectedItemColor: Colors.black,
        selectedItemColor: const Color(0XFF00BAEF),
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedFontSize: 10,
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
              Icons.list_outlined,
            ),
            label: 'Servicios',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.map_outlined,
            ),
            label: 'Turismo',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.mail_outline,
            ),
            label: 'Mensajería',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
            ),
            label: 'Perfil',
          ),
        ],
      ),
      /*
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 60.0,
        items: <Widget>[
          Icon(Icons.home, size: 20),
          Icon(Icons.play_arrow, size: 20),
          Icon(Icons.list, size: 20),
          Icon(Icons.message, size: 20),
          Icon(Icons.perm_identity, size: 20),
        ],
      ),*/
    );
  }
}
