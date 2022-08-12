import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ImagenesController {
  List<Album> albums = [];
  late QuerySnapshot qs;

  Future<int> getAlbumsSize() async {
    int result = 0;
    try {
      qs = await FirebaseFirestore.instance.collection("Imagenes").get();
      result = qs.docs.length;
    } catch (e) {
      print(e);
    }
    return result;
  }

  Future getFirstAlbums() async {
    qs = await FirebaseFirestore.instance
        .collection("Imagenes")
        .orderBy("Nombre")
        .limit(10)
        .get();
    albums = qs.docs
        .map((e) => Album(
              id: e.id,
              nombre: e["Nombre"],
              portada: e["Portada"],
            ))
        .toList();
  }

  Future getNextAlbums() async {
    try {
      var lastVisible = qs.docs[qs.docs.length - 1];
      qs = await FirebaseFirestore.instance
          .collection("Imagenes")
          .startAfterDocument(lastVisible)
          .orderBy("Nombre")
          .limit(10)
          .get();
      List<Album> noticiasNext = qs.docs
          .map((e) => Album(
                id: e.id,
                nombre: e["Nombre"],
                portada: e["Portada"],
              ))
          .toList();
      albums.addAll(noticiasNext);
    } catch (e) {
      debugPrint('Error en la obtención de los albums $e');
    }
  }
}

class Album {
  String id;
  String nombre;
  String portada;

  Album({
    required this.id,
    required this.nombre,
    required this.portada,
  });
}
