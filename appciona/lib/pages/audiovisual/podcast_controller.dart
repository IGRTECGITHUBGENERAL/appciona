import 'package:cloud_firestore/cloud_firestore.dart';

class PodcastController {
  Future<dynamic> getSinglePodcast(String id) async {
    DocumentSnapshot qs =
        await FirebaseFirestore.instance.collection('Podcast').doc(id).get();
    return qs;
  }
}
