import 'dart:io';
import 'package:appciona/config/notification_helper.dart';
import 'package:appciona/config/palette.dart';
import 'package:appciona/pages/account/delete/delete_page.dart';
import 'package:appciona/pages/mensajeria/mensajeria_page.dart';
import 'package:appciona/pages/servicios/servicios.dart';
import 'package:appciona/pages/widgets/alerts.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../firebaseServices/google_sign_in.dart';
import '../../main.dart';
import '../../models/Funcionarios.dart';
import '../../models/ciudades.dart';
import '../Citas/Citas_page.dart';

import '../agenda/agenda_page.dart';
import '../encuestas/encuestas_page.dart';
import '../account/login/login_page.dart';
import 'drawer_controller.dart';
import 'package:appciona/config/shared_preferences_helper.dart';

List<Ciudades> ciudades = [];
List<String> ciudadesNombres = [];

List<Funcionarios> funcionarios = [];
List<String> funcionariosNombres = [];
List<String> funcionariosCargos = [];
var currentSelectedValue;
String logo = "";
final box = GetStorage();

class DrawerWidget extends StatefulWidget {
  final int userState;

  const DrawerWidget({Key? key, required this.userState}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final DrawerWidgetController _controller = DrawerWidgetController();

  String numberMensajeria = "";
  String idciudad = "null";
  Future<void> getWhatsappNumber() async {
    QuerySnapshot ds =
        await FirebaseFirestore.instance.collection("WhatSapp").get();
    numberMensajeria = ds.docs.first["Telefono"];
    setState(() {});
  }

  Future<void> loadUserData() async {
    await _controller.getUserData();
    logo = await SharedPreferencesHelper.getUidlogo().toString();
    setState(() {});
  }

  Future<void> logodata() async {
    await _controller.getlogodata();

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    //   logo =box.read('logo');
    GetStorage.init();
    if (logo == "") {
      box.write('logo', "");
    }
    getListCitysUID();
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
    var posicion = "hola";
    logo = box.read('logo');
    if (logo == "")
      [
        logo =
            "https://firebasestorage.googleapis.com/v0/b/appciona-d1353.appspot.com/o/asd?alt=media&token=584440ff-f336-4414-b7e4-10184694f409"
      ];
    else
      [];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(50.0),
          child: Image.asset('assets/images/logo-green.png'),
        ),
        Container(
          child: new Image.network(
            logo,
            height: 60.0,
            fit: BoxFit.cover,
          ),
        ),

        ListTile(
          leading: const Icon(
            Icons.login,
            color: Palette.appcionaSecondaryColor,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Iniciar sesión"),
              const Text("Login", style: TextStyle(fontSize: 12)),
            ],
          ),
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
        ListTile(
          leading: const Icon(
            Icons.question_answer_outlined,
            color: Palette.appcionaSecondaryColor,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Encuestas"),
              const Text("surveys", style: TextStyle(fontSize: 12)),
            ],
          ),
          onTap: () => Navigator.of(context, rootNavigator: true)
              .push(
                CupertinoPageRoute(
                  builder: (context) => const EncuestasPage(),
                ),
              )
              .then(
                (value) => setState(() {
                  SharedPreferencesHelper.addEncuestaData("Global");
                }),
              ),
        ),
        typeFieldWidget(),
        // InkWell(
        //   onTap: () => Navigator.of(context, rootNavigator: true)
        // .push(CupertinoPageRoute(builder: (context) => politica())),
        //   child: Text(
        //     'Politica de Privacidad',
        //     style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue),
        //   ),
        // )

        /*ListTile(
          leading: const Icon(
            Icons.logout,
            color: Palette.appcionaSecondaryColor,
          ),
          title: const Text("añadir bartolome"),
          onTap: () async {
            try {
              final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
              bool result = await provider.googleLogout();
              if (!result) {
                await FirebaseAuth.instance.signOut();

                SharedPreferencesHelper.addCityData("vkS40AndXTPEJ2p3MFlt");
                //   SharedPreferencesHelper.deleteUserData();
              }
            } on ProviderNotFoundException catch (e) {
              await FirebaseAuth.instance.signOut();
              // SharedPreferencesHelper.deleteUserData();
              SharedPreferencesHelper.addCityData("vkS40AndXTPEJ2p3MFlt");
            } catch (e) {
              Alerts.messageBoxMessage(context, '¡UPS!',
                  'Parece que hubo un error al cerrar sesión.');
            }
            setState(() {});
          },
        ),*/
      ],
    );
  }

  Column _columnLogued() {
    logo = box.read('logo');
    if (logo == "")
      [
        logo =
            "https://firebasestorage.googleapis.com/v0/b/appciona-d1353.appspot.com/o/asd?alt=media&token=584440ff-f336-4414-b7e4-10184694f409"
      ];
    else
      [];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(50.0),
          child: Image.asset('assets/images/logo-green.png'),
        ),
        Container(
          child: new Image.network(
            logo,
            height: 55.0,
            fit: BoxFit.cover,
          ),
        ),
        FutureBuilder(
          future: loadUserData(),
          builder: (context, data) {
            return ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("¡Bienvenido ${_controller.userName}!"),
                  Text("Welcome!", style: TextStyle(fontSize: 12)),
                ],
              ),
              subtitle: Text(
                _controller.userEmail,
                textAlign: TextAlign.center,
              ),
            );
          },
        ),
        ListTile(
          leading: const Icon(
            CupertinoIcons.mail,
            color: Palette.appcionaPrimaryColor,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Mensajería"),
              Text("Messenger service", style: TextStyle(fontSize: 12)),
            ],
          ),
          trailing: ValueListenableBuilder(
            valueListenable: NotificationHelper.notification,
            builder: (context, value, widget) {
              if (value as bool) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 3.0, horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: Palette.appcionaPrimaryColor.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    CupertinoIcons.bell,
                    color: Palette.appcionaPrimaryColor.shade500,
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          onTap: () => {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const MensajeriaPage(),
              ),
            )
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.book,
            color: Palette.appcionaPrimaryColor,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Agenda"),
              Text("Diary", style: TextStyle(fontSize: 12)),
            ],
          ),
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
            Icons.book,
            color: Palette.appcionaPrimaryColor,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Citas"),
              Text("Date", style: TextStyle(fontSize: 12)),
            ],
          ),
          onTap: () => {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const CitaPage(),
              ),
            )
          },
        ),

        ListTile(
            leading: const Icon(
              Icons.question_answer_outlined,
              color: Palette.appcionaPrimaryColor,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Encuestas"),
                const Text("surveys", style: TextStyle(fontSize: 12)),
              ],
            ),
            onTap: () => {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const EncuestasPage(),
                    ),
                  ).then(
                    (value) => setState(() {
                      SharedPreferencesHelper.addEncuestaData("");
                    }),
                  ),
                }),
        ListTile(
          leading: const ImageIcon(
            AssetImage('assets/icons/servicios_mono.png'),
            color: Palette.appcionaPrimaryColor,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Incidencias"),
              const Text("Incidents", style: TextStyle(fontSize: 12)),
            ],
          ),
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
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Cerrar sesión"),
              const Text("Sign off", style: TextStyle(fontSize: 12)),
            ],
          ),
          onTap: () async {
            try {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              bool result = await provider.googleLogout();
              if (!result) {
                await FirebaseAuth.instance.signOut();

                SharedPreferencesHelper.deleteUserData();
              }
            } on ProviderNotFoundException catch (e) {
              await FirebaseAuth.instance.signOut();
              SharedPreferencesHelper.deleteUserData();
            } catch (e) {
              Alerts.messageBoxMessage(context, '¡UPS!',
                  'Parece que hubo un error al cerrar sesión., Sorry an error has appear');
            }
            setState(() {});
          },
        ),
        // InkWell(
        //   onTap: () => Navigator.of(context, rootNavigator: true)
        //       .push(CupertinoPageRoute(builder: (context) => politica())),
        //   child: Text(
        //     'Politica de Privacidad',
        //     style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue),
        //   ),
        // )
      ],
    );
  }

  Future<void> getListCitysUID() async {
    late QuerySnapshot qs;
    qs = await FirebaseFirestore.instance.collection("Ciudades").get();
    ciudades = qs.docs
        .map((e) => Ciudades(
              UID: e.id,
              Nombre: e["Nombre"],
              logo: e["logo"],
            ))
        .toList();
    print("ciudades");
    print(ciudades.length);
    print(ciudades[0].Nombre);
    ciudadesNombres = [];
    ciudades.forEach((data) => ciudadesNombres.add(data.Nombre.toString()));
    setState(() {
      ciudades;
      ciudadesNombres;
    });

    late QuerySnapshot qs3;

    idciudad = await SharedPreferencesHelper.getUidCity() ?? "null";

    qs3 = await FirebaseFirestore.instance
        .collection("Funcionarios")
        .where("Ciudad", isEqualTo: "$idciudad")
        .get();

    funcionarios = qs3.docs
        .map((e) => Funcionarios(
              UID: e.id,
              Nombre: e["Nombre"],
              Cargo: e["Puesto"],
            ))
        .toList();

    print(funcionarios.length);

    funcionariosNombres = [];

    funcionarios
        .forEach((data) => funcionariosNombres.add(data.Nombre.toString()));

    setState(() {
      funcionarios;
      funcionariosNombres;
    });
  }

  Future<void> getlogo() async {}

  Widget typeFieldWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0))),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                hint: Text("Selecciona una ciudad"),
                value: currentSelectedValue,
                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    try {
                      print(currentSelectedValue);
                      // currentSelectedValue = newValue;
                      int select = ciudadesNombres.indexOf(newValue!);

                      print(ciudades[select].UID);

                      SharedPreferencesHelper.addCityData(
                          ciudades[select].UID.toString());

                      ciudadesNombres = [];
                      box.write('logo', ciudades[select].logo.toString());
                      //SharedPreferencesHelper.addLogo(ciudades[select].logo.toString());

                      Navigator.pop(context);
                    } catch (excep) {
                      ciudadesNombres = [];
                    }
                  });
                  ciudadesNombres = [];
                },
                items: ciudadesNombres.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
