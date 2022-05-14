import 'package:appciona/pages/agenda_page.dart';
import 'package:appciona/pages/appbarPrincipal.dart';
import 'package:appciona/pages/bottonbar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
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
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('AppCiona'),
        centerTitle: true,
        leading: Icon(Icons.menu),
        actions: [
          Image.asset(
            'assets/images/logo-green.png',
            fit: BoxFit.contain,
            height: 32,
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AgendaPage(),
                  ),
                );
              },
              child: Text('Agenda'),
            ),
            Card(
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/logo-green.png',
                    fit: BoxFit.contain,
                    height: 150,
                  ),
                  Expanded(
                    child: Container(
                        child: Text('Cortegana crea una web de turimo',
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
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
      ),
    );
  }
}
