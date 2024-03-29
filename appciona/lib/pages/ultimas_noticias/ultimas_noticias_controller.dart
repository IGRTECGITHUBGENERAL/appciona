import 'package:appciona/models/noticia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../config/shared_preferences_helper.dart';

class UltimasNoticiasController {
  List<Noticia> noticias = [];
  late QuerySnapshot qs;
  String idciudad="null";
  final f = new DateFormat('yyyy-MM-dd hh:mm');

  Future<int> getNoticiasSize() async {

    int result = 0;
    try {

      idciudad = await SharedPreferencesHelper.getUidCity() ?? "null";
      print("qsawait:$idciudad");
      if(idciudad==null||idciudad=="null")
      {
        qs = await FirebaseFirestore.instance.collection("Noticias")
            .orderBy("Fecha",descending: true)
            .get();

      }
      else{
        qs = await FirebaseFirestore.instance.collection("Noticias").where("Ciudad",isEqualTo: "$idciudad")
            .orderBy("Fecha",descending: true)

            .get();
      }

      result = qs.docs.length;
      print("  tamaño $result");
    } catch (e) {
      debugPrint("Error al obtener la cantidad de noticias $e");
    }
    return result;
  }

  Future<void> getInitNoticias() async {
    try {
      idciudad = await SharedPreferencesHelper.getUidCity() ?? "null";
      print("qsawait GETINITNOTICIAS:$idciudad");
      if(idciudad==null||idciudad=="null")
      {
        qs = await FirebaseFirestore.instance
            .collection("Noticias")
            .orderBy("Fecha",descending: true)
            .limit(10)
            .get();
      }
      else{
        qs = await FirebaseFirestore.instance
            .collection("Noticias")
            .where("Ciudad",isEqualTo: "$idciudad")


            .orderBy("Fecha",descending: true)
            .limit(10)
            .get();
      }
      noticias = qs.docs
          .map((e) => Noticia(
                categoria: e["Categoria"],
                titulo: e["Titulo"],
                fecha: DateTime.parse(e["Fecha"].toDate().toString()),
                subtitulo: e["Subtitulo"],
                imagen: e["Imagen"],
                texto: e["Texto"],
                link: e["Link"],
              ))
          .toList();
    } catch (e) {
      debugPrint("Error al obtener las primeras noticias: $e");
    }
  }

  Future<void> getNextNoticias() async {
    try {
      var lastVisible = qs.docs[qs.docs.length - 1];
      idciudad = await SharedPreferencesHelper.getUidCity() ?? "null";
      print("qsawait GETINEXTNOTICIAS:$idciudad");

      if(idciudad==null||idciudad=="null")
      {
        qs = await FirebaseFirestore.instance
            .collection("Noticias")
            .orderBy("Fecha",descending: true)
            .startAfterDocument(lastVisible)
            .limit(10)
            .get();
      }
      else{
        qs = await FirebaseFirestore.instance
            .collection("Noticias")
            .where("Ciudad",isEqualTo: "$idciudad")
            .orderBy("Fecha",descending: true)
            .startAfterDocument(lastVisible)
            .limit(10)
            .get();
      }



      List<Noticia> noticiasNext = qs.docs
          .map((e) => Noticia(
                categoria: e["Categoria"],
                titulo: e["Titulo"],
                fecha: DateTime.parse(e["Fecha"].toDate().toString()),
                subtitulo: e["Subtitulo"],
                imagen: e["Imagen"],
                texto: e["Texto"],
                link: e["Link"],
              ))
          .toList();
      noticias.addAll(noticiasNext);
    } catch (e) {
      debugPrint("Error al obtener las siguientes noticias: $e");
    }
  }
}
