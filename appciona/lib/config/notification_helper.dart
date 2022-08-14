import 'dart:async';
import 'package:appciona/config/shared_preferences_helper.dart';
import 'package:appciona/models/mensajeria.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationHelper {
  static late StreamSubscription messagignSubscription;

  static Future addMessagingListener() async {
    String userUid = await SharedPreferencesHelper.getUidUser() ?? "";
    if (userUid.isNotEmpty) {
      Mensajeria mensajeria = Mensajeria();
      messagignSubscription = FirebaseFirestore.instance
          .collection("Mensajeria")
          .doc(userUid)
          .snapshots()
          .listen((DocumentSnapshot event) {
        mensajeria.ultimoMensaje = event["UltimoMensaje"];
        mensajeria.ultimoRemitente = event["UltimoRemitente"];
        mensajeria.ts = DateTime.parse(event["ts"].toDate.toString());
        print(mensajeria.ultimoRemitente);
      });
    }
  }

  static Future cancelListener() async {
    messagignSubscription.cancel();
  }
}
