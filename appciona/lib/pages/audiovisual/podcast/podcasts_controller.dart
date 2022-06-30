import 'package:cloud_firestore/cloud_firestore.dart';

class PodcastsController {
  Future<dynamic> getPodcast() async {
    QuerySnapshot qs = await FirebaseFirestore.instance
        .collection('Podcast')
        .orderBy("FechaPublicacion")
        .get();
    List<DocumentSnapshot> documents = qs.docs;
    return documents;
  }
}
