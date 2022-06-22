import 'package:appciona/models/servicio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServiciosController {
  Future<List<Servicio>> getServices() async {
    QuerySnapshot qs =
        await FirebaseFirestore.instance.collection('Servicios').get();
    List<DocumentSnapshot> documents = qs.docs;
    return documents
        .map(
          (e) => Servicio(
            correo: e['Correo'],
            direccion: e['Direccion'],
            imagen: e['Imagen'],
            telefono: e['Telefono'],
            tipo: e['Tipo'],
            titulo: e['Titulo'],
          ),
        )
        .toList();
  }
}
