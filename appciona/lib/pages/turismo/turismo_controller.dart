import 'package:cloud_firestore/cloud_firestore.dart';

class TurismoController {
  Future<dynamic> getNoticias() async {
    QuerySnapshot qs =
        await FirebaseFirestore.instance.collection('Noticias').get();
    List<DocumentSnapshot> documents = qs.docs;
    return documents;
  }
}
