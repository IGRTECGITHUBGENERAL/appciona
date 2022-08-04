import 'package:appciona/config/palette.dart';
import 'package:appciona/models/pushnotification_model.dart';
import 'package:appciona/notification_badge.dart';
import 'package:appciona/pages/audiovisual/audiovisual_page.dart';
import 'package:appciona/pages/turismo/turismo_main_page.dart';
import 'package:appciona/pages/ultimas_noticias/ultimas_noticias_page.dart';
import 'package:appciona/pages/widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  bool loaded = false;

  late final FirebaseMessaging _messaging;
  PushNotification? _notificationInfo;

  //Notificación normal. Cuando se está dentro de la App
  void registerNotification() async {
    await Firebase.initializeApp();
    _messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User granted the permission");

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        PushNotification notification = PushNotification(
            title: message.notification!.title,
            body: message.notification!.body,
            dataTitle: message.data['title'],
            dataBody: message.data['body']);

        setState(() {
          _notificationInfo = notification;
        });

        if (notification != null) {
          showSimpleNotification(
            Text(_notificationInfo!.title!),
            leading: const NotificationBadge(totalNotification: 1),
            subtitle: Text(_notificationInfo!.body!),
            background: Colors.cyan.shade700,
            duration: const Duration(seconds: 2),
          );
        }
      });
    } else {
      print("permission declined by user");
    }
  }

  //Cuando la App está terminada
  checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      PushNotification notification = PushNotification(
          title: initialMessage.notification!.title,
          body: initialMessage.notification!.body,
          dataTitle: initialMessage.data['title'],
          dataBody: initialMessage.data['body']);

      setState(() {
        _notificationInfo = notification;
      });
    }
    setState(() {
      loaded = true;
    });
  }

  @override
  void initState() {
    //cuando la App está en segundo plano (aún no se ha terminado)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotification notification = PushNotification(
          title: message.notification!.title,
          body: message.notification!.body,
          dataTitle: message.data['title'],
          dataBody: message.data['body']);

      setState(() {
        _notificationInfo = notification;
      });
    });
    //notificación normal
    registerNotification();
    //cuando la App está terminada
    checkForInitialMessage();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loaded
        ? StreamBuilder(
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
          )
        : loadingView();
  }

  Widget loadingView() {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Image.asset('assets/images/logo-green.png'),
            const SizedBox(
              height: 20,
            ),
            const CircularProgressIndicator(),
          ],
        ),
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
