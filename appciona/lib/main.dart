import 'package:appciona/pages/audiovisual/audiovisual_page.dart';
import 'package:appciona/pages/turismo/turismo_main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'pages/ultimas_noticias/ultimas_noticias_page.dart';
import 'pages/widgets/drawer.dart';

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
      debugShowCheckedModeBanner: false,
      title: 'AppCiona',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, data) {
          if (data.connectionState == ConnectionState.waiting) {
            return const MyHomePage(
              userState: 2,
            );
          } else if (data.hasData) {
            return const MyHomePage(
              userState: 1,
            );
          } else if (data.hasError) {
            return const MyHomePage(
              userState: 0,
            );
          } else {
            return const MyHomePage(
              userState: 0,
            );
          }
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final int userState;
  const MyHomePage({
    Key? key,
    required this.userState,
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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.newspaper,
            ),
            label: 'Últimas noticias',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.play_circle_outline,
            ),
            label: 'Audiovisual',
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
              builder: (context) => UltimasNoticias(
                drawer: DrawerWidget(
                  userState: widget.userState,
                ),
              ),
            );
          case 1:
            return CupertinoTabView(
              builder: (context) => AudiovisualPage(
                drawer: DrawerWidget(
                  userState: widget.userState,
                ),
              ),
            );
          case 2:
            return CupertinoTabView(
              builder: (context) => TurismoMainPage(
                drawer: DrawerWidget(
                  userState: widget.userState,
                ),
              ),
            );
          default:
            return CupertinoTabView(
              builder: (context) => UltimasNoticias(
                drawer: DrawerWidget(
                  userState: widget.userState,
                ),
              ),
            );
        }
      },
    );
  }
}
