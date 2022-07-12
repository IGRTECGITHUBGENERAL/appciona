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
}
