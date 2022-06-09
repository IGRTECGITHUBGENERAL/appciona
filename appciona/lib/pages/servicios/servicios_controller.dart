import 'package:cloud_firestore/cloud_firestore.dart';

class ServiciosController {
  Future<dynamic> getServices() async {
    QuerySnapshot qs =
        await FirebaseFirestore.instance.collection('Servicios').get();
    List<DocumentSnapshot> documents = qs.docs;
    return documents;
  }
}
