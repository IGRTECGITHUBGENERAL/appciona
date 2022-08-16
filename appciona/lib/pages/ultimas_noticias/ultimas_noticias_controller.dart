import 'package:appciona/models/noticia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UltimasNoticiasController {
  List<Noticia> noticias = [];
  late QuerySnapshot qs;

  Future<int> getNoticiasSize() async {
    int result = 0;
    try {
      qs = await FirebaseFirestore.instance.collection("Noticias").get();
      result = qs.docs.length;
    } catch (e) {
      debugPrint("Error al obtener la cantidad de noticias $e");
    }
    return result;
  }

  Future<void> getInitNoticias() async {
    try {
      qs = await FirebaseFirestore.instance
          .collection("Noticias")
          .orderBy("Fecha")
          .limit(10)
          .get();
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
      qs = await FirebaseFirestore.instance
          .collection("Noticias")
          .startAfterDocument(lastVisible)
          .orderBy("Fecha")
          .limit(10)
          .get();
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
