import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../config/shared_preferences_helper.dart';

class MediaController {


  Future<dynamic> getMedia(String category) async {
    String idciudad="null";
    idciudad = await SharedPreferencesHelper.getUidCity() ?? "null";
    late QuerySnapshot qs;
    if(idciudad==null||idciudad=="null")
    {
       qs = await FirebaseFirestore.instance
          .collection("Audiovisual")
          .orderBy("FechaPublicacion")
          .get();
    }
    else{
      qs = await FirebaseFirestore.instance
          .collection("Audiovisual")
          .where("Ciudad",isEqualTo: "$idciudad")
          .orderBy("FechaPublicacion")
          .get();
    }

    List<DocumentSnapshot> documents = qs.docs;
    documents =
        documents.where((element) => element["Tipo"] == category).toList();
    return documents;
  }
}
