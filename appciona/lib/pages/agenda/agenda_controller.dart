import 'package:appciona/models/agendas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AgendaController {
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
    QuerySnapshot qs = await FirebaseFirestore.instance
        .collection("Agendas")
        .where('usuarioUID', isEqualTo: user!.uid)
        .get();
    List<Agenda> agendas = qs.docs
        .map((e) => Agenda(
              UsuarioId: e["usuarioUID"],
              Titulo: e["Titulo"],
              Descripcion: e["Descripcion"],
              Fecha: DateTime.parse(e['Fecha'].toDate().toString()),
            ))
        .toList();
    agendas = agendas
        .where((element) => element.Fecha.isAfter(DateTime.now()))
        .toList();
    for (var agenda in agendas) {
      fechasConEventos!.add(agenda.Fecha);
    }
    return fechasConEventos;
  }

  Future<List<Agenda>?> obtenerAgendas(DateTime fecha) async {
    QuerySnapshot qs = await FirebaseFirestore.instance
        .collection("Agendas")
        .where('usuarioUID', isEqualTo: user!.uid)
        .get();
    List<Agenda> agendas = [];
    agendas = qs.docs
        .map((e) => Agenda(
              UsuarioId: e["usuarioUID"],
              Titulo: e["Titulo"],
              Descripcion: e["Descripcion"],
              Fecha: DateTime.parse(e['Fecha'].toDate().toString()),
            ))
        .toList();
    agendas = agendas
        .where((element) =>
            element.Fecha.isAfter(fecha) &&
            element.Fecha.isBefore(fecha.add(Duration(days: 1))))
        .toList();
    return agendas;
  }
}
