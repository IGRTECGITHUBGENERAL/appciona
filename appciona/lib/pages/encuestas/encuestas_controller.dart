import 'package:appciona/models/encuestas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/pregunta.dart';

class EncuestasController {
  final User? user = FirebaseAuth.instance.currentUser;

  List<Pregunta> getPreguntas(Map<String, dynamic>? formulario) {
    List<Pregunta> preguntas = [];
    formulario!.forEach((key, value) {
      preguntas.add(Pregunta(
        pregunta: value["Pregunta"],
        respuestas: value["Respuestas"],
        tipoPregunta: value["TipoPregunta"],
      ));
    });
    return preguntas;
  }

  Future<Encuestas?> getSingleForm(String uid) async {
    try {
      DocumentSnapshot qs = await FirebaseFirestore.instance
          .collection('Encuestas')
          .doc(uid)
          .get();
      Encuestas encuesta = Encuestas(
        uid: qs.id,
        titulo: qs["Titulo"],
        descripcion: qs["Descripcion"],
        imagen: qs["Imagen"],
        formulario: qs["Formulario"],
      );
      return encuesta;
    } catch (e) {
      return null;
    }
  }

  Future<dynamic> getForms() async {
    try {
      QuerySnapshot qs =
          await FirebaseFirestore.instance.collection('Encuestas').get();
      List<Encuestas> encuestas = qs.docs
          .map(
            (e) => Encuestas(
              uid: e.id,
              titulo: e["Titulo"],
              descripcion: e["Descripcion"],
              imagen: e["Imagen"],
            ),
          )
          .toList();
      DocumentSnapshot qsUser = await FirebaseFirestore.instance
          .collection('RespuestasEncuestas')
          .doc(user!.uid)
          .get();
      if (!qsUser.exists) {
        return encuestas;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getFormsNotAnswered() async {}
}
