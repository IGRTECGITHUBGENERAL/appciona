import 'package:appciona/models/turismo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../config/shared_preferences_helper.dart';

class RestaurantesHotelesController {

  Future<List<Turismo>> getServices(String tipoSelected) async {
    String idciudad="null";
    late QuerySnapshot qs;
    idciudad = await SharedPreferencesHelper.getUidCity() ?? "null";

    if(idciudad==null||idciudad=="null")
    {
      qs =  await FirebaseFirestore.instance.collection('Turismo').get();
    }
    else{
      qs =  await FirebaseFirestore.instance.collection('Turismo')
          .where("Ciudad",isEqualTo: "$idciudad")
          .get();
    }

    List<DocumentSnapshot> documents = qs.docs;
    return documents
        .map(
          (e) => Turismo(
            correo: e['Correo'],
            direccion: e['Direccion'],
            imagen: e['Imagen'],
            telefono: e['Telefono'],
            tipo: e['Tipo'],
            titulo: e['Titulo'],
          ),
        )
        .where((element) => element.tipo == tipoSelected)
        .toList();
  }
}
