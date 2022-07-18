import 'dart:io';
import 'package:appciona/config/palette.dart';
import 'package:appciona/pages/servicios/servicios.dart';
import 'package:appciona/pages/widgets/alerts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../firebaseServices/google_sign_in.dart';
import '../agenda/agenda_page.dart';
import '../encuestas/encuestas_page.dart';
import '../account/login/login_page.dart';
import 'drawer_controller.dart';

class DrawerWidget extends StatefulWidget {
  final int userState;
  const DrawerWidget({Key? key, required this.userState}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final DrawerWidgetController _controller = DrawerWidgetController();
  String numberMensajeria = "";

  Future<void> getWhatsappNumber() async {
    QuerySnapshot ds =
        await FirebaseFirestore.instance.collection("WhatSapp").get();
    numberMensajeria = ds.docs.first["Telefono"];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getWhatsappNumber();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: widget.userState == 1
            ? _columnLogued()
            : widget.userState == 2
                ? _columnWaiting()
                : _columnNotLogued(),
      ),
    );
  }

  Column _columnWaiting() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(50.0),
          child: Image.asset('assets/images/logo-green.png'),
        ),
        const ListTile(
          leading: CircularProgressIndicator(),
          title: LinearProgressIndicator(),
          onTap: null,
        ),
        const ListTile(
          leading: CircularProgressIndicator(),
          title: LinearProgressIndicator(),
          onTap: null,
        ),
        const ListTile(
          leading: CircularProgressIndicator(),
          title: LinearProgressIndicator(),
          onTap: null,
        ),
      ],
    );
  }

  Column _columnNotLogued() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(50.0),
          child: Image.asset('assets/images/logo-green.png'),
        ),
        ListTile(
          leading: const Icon(
            Icons.login,
            color: Palette.appcionaSecondaryColor,
          ),
          title: const Text("Iniciar sesión"),
          onTap: () => Navigator.of(context, rootNavigator: true)
              .push(
                CupertinoPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              )
              .then(
                (value) => setState(() {}),
              ),
        ),
      ],
    );
  }

  Column _columnLogued() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(50.0),
          child: Image.asset('assets/images/logo-green.png'),
        ),
        FutureBuilder(
          future: _controller.getUserInfo(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              InfoUser info = snapshot.data as InfoUser;
              return ListTile(
                title: Text(
                  "¡Bienvenido ${info.nombre}!",
                  textAlign: TextAlign.center,
                ),
                subtitle: Text(
                  "${info.email}",
                  textAlign: TextAlign.center,
                ),
              );
            } else if (snapshot.hasData) {
              return const ListTile(
                title: Text(
                  "¡Bienvenido!",
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return const ListTile(
                title: LinearProgressIndicator(),
              );
            }
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.whatsapp,
            color: Palette.appcionaPrimaryColor,
          ),
          title: const Text("Mensajería"),
          onTap: () {
            openwhatsapp();
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.book,
            color: Palette.appcionaPrimaryColor,
          ),
          title: const Text("Agenda"),
          onTap: () => {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const AgendaPage(),
              ),
            )
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.question_answer_outlined,
            color: Palette.appcionaPrimaryColor,
          ),
          title: const Text("Encuestas"),
          onTap: () => {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const EncuestasPage(),
              ),
            )
          },
        ),
        ListTile(
          leading: const ImageIcon(
            AssetImage('assets/icons/servicios_mono.png'),
            color: Palette.appcionaPrimaryColor,
          ),
          title: const Text("Servicios"),
          onTap: () => {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const ServiciosPage(),
              ),
            )
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.logout,
            color: Palette.appcionaSecondaryColor,
          ),
          title: const Text("Cerrar sesión"),
          onTap: () async {
            try {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              bool result = await provider.googleLogout();
              if (!result) {
                await FirebaseAuth.instance.signOut();
              }
            } on ProviderNotFoundException catch (e) {
              await FirebaseAuth.instance.signOut();
            } catch (e) {
              Alerts.messageBoxMessage(context, '¡UPS!',
                  'Parece que hubo un error al cerrar sesión.');
            }
            setState(() {});
          },
        ),
      ],
    );
  }

  void openwhatsapp() async {
    if (numberMensajeria.isNotEmpty) {
      var whatsapp = "https://wa.me/+$numberMensajeria";
      var whatsappURlAndroid = "whatsapp://send?phone=$whatsapp";
      var whatappURLIos = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
      if (Platform.isIOS) {
        if (!await launchUrl(Uri.parse(whatappURLIos))) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Necesitas instalar WhatsApp."),
            ),
          );
        }
        /*
      if (await canLaunch(whatappURLIos)) {
        await launch(whatappURLIos, forceSafariVC: false);
      } else {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Necesitas instalar WhatsApp."),
          ),
        );
      }*/
      } else {
        if (!await launchUrl(Uri.parse(whatsappURlAndroid))) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Necesitas instalar WhatsApp."),
            ),
          );
        }
      }
    }
  }
}
