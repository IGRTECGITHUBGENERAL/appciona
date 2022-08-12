// ignore_for_file: prefer_const_constructors

import 'package:appciona/models/pushnotification_model.dart';
import 'package:appciona/notification_badge.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
//import 'package:overlay_support/overlay_support.dart';

class PushNotificationHomePage extends StatefulWidget {
  const PushNotificationHomePage({Key? key}) : super(key: key);

  @override
  State<PushNotificationHomePage> createState() =>
      _PushNotificationHomePageState();
}

class _PushNotificationHomePageState extends State<PushNotificationHomePage> {
  late final FirebaseMessaging _messaging;
  late int _totalNotificationCounter;

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
          _totalNotificationCounter++;
          _notificationInfo = notification;
        });

        if (notification != null) {
          /*showSimpleNotification(Text(_notificationInfo!.title!),
              leading: NotificationBadge(
                  totalNotification: _totalNotificationCounter),
              subtitle: Text(_notificationInfo!.body!),
              background: Colors.cyan.shade700,
              duration: Duration(seconds: 2));
              */
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
        _totalNotificationCounter++;
        _notificationInfo = notification;
      });
    }
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
        _totalNotificationCounter++;
        _notificationInfo = notification;
      });
    });
    //notificación normal
    registerNotification();
    //cuando la App está terminada
    checkForInitialMessage();

    _totalNotificationCounter = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prueba PushNotifications')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "FlutterPushNotification",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 12),
            NotificationBadge(totalNotification: _totalNotificationCounter),
            SizedBox(height: 30),
            _notificationInfo != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                          "TITLE: ${_notificationInfo!.dataTitle ?? _notificationInfo!.title}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 9),
                      Text(
                          "BODY: ${_notificationInfo!.dataBody ?? _notificationInfo!.body}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16))
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
