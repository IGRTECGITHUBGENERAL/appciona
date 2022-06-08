import 'dart:io';
import 'package:appciona/pages/widgets/alerts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../firebaseServices/google_sign_in.dart';
import '../inicio/agenda_page.dart';
import '../inicio/encuestas_page.dart';
import '../perfil/inicio_sesion_page.dart';
import '../perfil/perfil_page.dart';

class DrawerWidget extends StatefulWidget {
  final int userState;
  const DrawerWidget({Key? key, required this.userState}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
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
          leading: const Icon(Icons.login),
          title: const Text("Iniciar sesión"),
          onTap: () => {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const InicioSesionPage(),
              ),
            )
          },
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
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text("Perfil"),
          onTap: () => {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const PerfilPage(),
              ),
            )
          },
        ),
        ListTile(
          leading: const Icon(Icons.whatsapp),
          title: const Text("Mensajería"),
          onTap: () {
            openwhatsapp();
          },
        ),
        ListTile(
          leading: const Icon(Icons.book),
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
          leading: const Icon(Icons.question_answer_outlined),
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
          leading: const Icon(Icons.logout),
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

  openwhatsapp() async {
    var whatsapp = "https://wa.me/+34605183884";
    var whatsappURl_android = "whatsapp://send?phone=" + whatsapp;
    var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappURL_ios)) {
        await launch(whatappURL_ios, forceSafariVC: false);
      } else {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Necesitas instalar WhatsApp."),
          ),
        );
      }
    } else {
      // android , web
      if (await canLaunch(whatsappURl_android)) {
        await launch(whatsappURl_android);
      } else {
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
