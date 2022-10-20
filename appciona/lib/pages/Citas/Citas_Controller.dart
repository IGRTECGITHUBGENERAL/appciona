
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


import '../../config/shared_preferences_helper.dart';
import '../../models/citas.dart';
String tipo="";
String idciudad="null";
class CitasController {

  late List<DateTime>? fechasConEventos = [];
  User? user = FirebaseAuth.instance.currentUser;
  List<String> meses = [
    "Enero",
    "Febrero",
    "Marzo",
    "Abril",
    "Mayo",
    "Junio",
    "Julio",
    "Agosto",
    "Septiembre",
    "Octubre",
    "Noviembre",
    "Diciembre"
  ];
  List<String> dias = [
    "Lunes",
    "Martes",
    "Miercoles",
    "Jueves",
    "Viernes",
    "Sábado",
    "Domingo"
  ];

  Future<List<DateTime>?> obtenerFechasConEventos() async {
    idciudad = await SharedPreferencesHelper.getUidCity() ?? "null";
    QuerySnapshot qs = await FirebaseFirestore.instance
        .collection("Citas")
        .where('usuarioUID', isEqualTo: user!.uid)

        .get();
    List<Cita> citas = qs.docs
        .map((e) => Cita(
      uid: e.id,
      UsuarioId: e["usuarioUID"],
      Titulo: e["Titulo"],
      Descripcion: e["Descripcion"],
      Estado: e["Estado"],
      Fecha: DateTime.parse(e['Fecha'].toDate().toString()),
    ))
        .toList();
    citas = citas
        .where((element) => element.Fecha.isAfter(DateTime.now()))
        .toList();
    for (var cita in citas) {
      fechasConEventos!.add(cita.Fecha);
    }
    return fechasConEventos;
  }

  Future<List<Cita>?> ObtenerCitas(DateTime fecha) async {
    QuerySnapshot qs = await FirebaseFirestore.instance
        .collection("Citas")
        .where('usuarioUID', isEqualTo: user!.uid)
        .get();
    List<Cita> citas = [];
    citas = qs.docs
        .map((i) => Cita(
      uid: i.id,
      UsuarioId: i["usuarioUID"],
      Titulo: i["Titulo"],
      Descripcion: i["Descripcion"],
      Estado: i["Estado"],
      Tipo: i["Tipo"],
      Gobernante: i["Gobernante"],
      Fecha: DateTime.parse(i['Fecha'].toDate().toString()),
    ))
        .toList();
    citas = citas
        .where((element) =>
    element.Fecha.isAfter(fecha) &&
        element.Fecha.isBefore(fecha.add(const Duration(days: 1))))
        .toList();
    return citas;
  }



  Future<List<Cita>?> ObtenerCitasAdministrador(DateTime fecha) async {
    QuerySnapshot qs = await FirebaseFirestore.instance
        .collection("Citas")
        .where('Tipo', isEqualTo: "Administrador")
        .where('Estado', isEqualTo: "Libre")
        .where('usuarioUID', isEqualTo: "")
        .where("Ciudad",isEqualTo: idciudad)
        .get();
    List<Cita> citas = [];
    citas = qs.docs
        .map((i) => Cita(
      uid: i.id,
      UsuarioId: i["usuarioUID"],
      Titulo: i["Titulo"],
      Descripcion: i["Descripcion"],
      Estado: i["Estado"],
      Gobernante: i["Gobernante"],
      Fecha: DateTime.parse(i['Fecha'].toDate().toString()),
    ))
        .toList();
    citas = citas
        .where((element) =>
    element.Fecha.isAfter(fecha) &&
        element.Fecha.isBefore(fecha.add(const Duration(days: 1))))
        .toList();
    return citas;
  }
  Future<bool> eliminarEvento(String? uidUser,String? uiddoc,String? tipo) async {
    bool result = false;

    if(tipo=="Usuario"){
      try {
        final db = FirebaseFirestore.instance.collection('Citas').doc(uiddoc);
        db
            .delete()
            .then((value) => result = true)
            .catchError((error) => result = false);
        return result;
      } catch (error) {

      }
    }
    else{

      bool result = false;
      final db = FirebaseFirestore.instance.collection('Citas').doc(uiddoc);
      try {
        await db
            .update({


          'Estado': "Libre",
          'usuarioUID': "",
        })
            .then((value) => result = true)
            .catchError((error) => result = false);
        return result;
      } catch (e) {
        return result;
      }
    }

    return result;
  }

  Future<bool> Quitarcitausuario(String? uid) async {


    bool result = false;
    final db = FirebaseFirestore.instance.collection('Citas').doc(uid);
    try {
      await db
          .update({


        'Estado': "En espera",
        'usuarioUID': "",
      })
          .then((value) => result = true)
          .catchError((error) => result = false);
      return result;
    } catch (e) {
      return result;
    }
  }
  Future<bool> solicitacitausuariosistema(String? uid) async {


    bool result = false;
    final db = FirebaseFirestore.instance.collection('Citas').doc(uid);
    try {
      await db
          .update({


        'Estado': "En espera",
        'usuarioUID': user!.uid,
      })
          .then((value) => result = true)
          .catchError((error) => result = false);
      return result;
    } catch (e) {
      return result;
    }
  }

}
