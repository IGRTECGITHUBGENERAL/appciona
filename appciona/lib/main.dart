import 'package:appciona/config/palette.dart';
import 'package:appciona/pages/loading/loading_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flip = FlutterLocalNotificationsPlugin();

/*void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) {
    var android = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = const IOSInitializationSettings();
    var settings = InitializationSettings(android: android, iOS: iOS);
    flip.initialize(settings);
    runApp(const MyApp());
  });
}*/
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 /* await Firebase.initializeApp(
    // Replace with actual values

    options: FirebaseOptions(
      apiKey: "AIzaSyDid9CtMj5CCXfxxTGpL974GvFETJqvTog",
      appId: "27940180392",
      messagingSenderId: "27940180392",
      projectId: "appciona-d1353",
    ),
  );
  runApp(MyApp());*/

  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) {
    var android = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = const IOSInitializationSettings();
    var settings = InitializationSettings(android: android, iOS: iOS);
    flip.initialize(settings);
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
        primarySwatch: Palette.appcionaPrimaryColor,
      ),
      home: const LoadingPage(),
    );
  }
}
