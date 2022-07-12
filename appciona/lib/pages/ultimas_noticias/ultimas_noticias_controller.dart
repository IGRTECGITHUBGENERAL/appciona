import 'package:appciona/models/noticia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UltimasNoticiasController {
  Future<dynamic> getNoticias() async {
    QuerySnapshot qs = await FirebaseFirestore.instance
        .collection('Noticias')
        .orderBy("Fecha")
        .get();
    List<DocumentSnapshot> documents = qs.docs;
    print(documents.first.data());
    return documents;
  }

  List<Noticia> noticias = [];
  late QuerySnapshot qsGlobal;

  Future<int> getNoticiasSize() async {
    int result = 0;
    try {
      qsGlobal = await FirebaseFirestore.instance.collection("Noticias").get();
      result = qsGlobal.docs.length;
    } catch (e) {
      print(e);
    }
    return result;
  }

  Future<void> getInitNoticias() async {
    try {
      qsGlobal = await FirebaseFirestore.instance
          .collection("Noticias")
          .orderBy("Fecha")
          .limit(10)
          .get();
      noticias = qsGlobal.docs
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
      print(e);
    }
  }

  Future<void> getNextNoticias() async {
    try {
      var lastVisible = qsGlobal.docs[qsGlobal.docs.length - 1];
      qsGlobal = await FirebaseFirestore.instance
          .collection("Noticias")
          .startAfterDocument(lastVisible)
          .orderBy("Fecha")
          .limit(10)
          .get();
      List<Noticia> noticiasNext = qsGlobal.docs
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
      print(e);
    }
  }
}
