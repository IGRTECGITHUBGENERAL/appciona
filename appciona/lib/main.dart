import 'package:appciona/config/palette.dart';
import 'package:appciona/pages/loading/loading_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

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
    return OverlaySupport(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AppCiona',
        theme: ThemeData(
          primarySwatch: Palette.appcionaPrimaryColor,
        ),
        home: const LoadingPage(),
      ),
    );
  }
}
