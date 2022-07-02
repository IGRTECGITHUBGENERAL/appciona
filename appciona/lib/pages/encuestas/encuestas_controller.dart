import 'dart:math';

import 'package:appciona/models/encuestas.dart';
import 'package:appciona/models/respuestas_encuestas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/pregunta.dart';

class EncuestasController {
  final User? user = FirebaseAuth.instance.currentUser;

  Future<bool> sendAnswers(RespuestasEncuestas respuestas) async {
    try {
      CollectionReference respuestasEncuestasReference =
          FirebaseFirestore.instance.collection('RespuestasEncuestas');
      //String uidGen = getRandomString(20);
      await respuestasEncuestasReference.doc().set({
        'uidUsuario': respuestas.uidUsuario,
        'uidEncuesta': respuestas.uidEncuesta,
        'Revisado': respuestas.revisado,
        'Respuestas': respuestas.respuestas,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

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

  String getRandomString(int length) {
    const characters = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    Random random = Random();
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => characters.codeUnitAt(
          random.nextInt(characters.length),
        ),
      ),
    );
  }
}
