import 'package:appciona/models/audiovisual.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MediaController {
  Future<dynamic> getMedia(String category) async {
    QuerySnapshot qs = await FirebaseFirestore.instance
        .collection("Audiovisual")
        .orderBy("FechaPublicacion")
        .get();
    List<DocumentSnapshot> documents = qs.docs;
    documents =
        documents.where((element) => element["Tipo"] == category).toList();
    return documents;
  }
}
