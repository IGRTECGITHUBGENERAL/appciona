import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//https://www.youtube.com/watch?v=2d1fslyxBjQ
class MensajeriaController {
  late Stream messageStream;
  late String roomID, messageId = "", myUid = "";
  User? userInfo = FirebaseAuth.instance.currentUser;

  Future<void> initChatRoom() async {
    if (userInfo != null) {
      myUid = userInfo!.uid;
      roomID = "${myUid}_admin";
    }
    messageStream = FirebaseFirestore.instance
        .collection("Mensajeria")
        .doc(roomID)
        .collection("Chats")
        .orderBy("ts", descending: true)
        .snapshots();
  }

  Future<void> getMessages() async {}

  Future<void> sendMessage(String mensaje) async {
    if (messageId.isEmpty) {
      messageId = getRandomString(20);
    }
    DocumentReference docRef = FirebaseFirestore.instance
        .collection("Mensajeria")
        .doc(roomID)
        .collection("Chats")
        .doc(messageId);
    DateTime ts = DateTime.now();
    await docRef.set(
      {
        "Mensaje": mensaje,
        "Remitente": myUid,
        "ts": ts,
      },
    ).then(
      (value) async {
        await updateLastMessageSend(
          {
            "UltimoMensaje": mensaje,
            "UltimoRemitente": myUid,
            "ts": ts,
          },
        ).then((value) => messageId = "");
      },
    );
  }

  Future updateLastMessageSend(Map<String, dynamic> data) async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection("Mensajeria").doc(roomID);
    await docRef.update(data);
  }

  String getRandomString(int length) {
    const characters = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    Random random = Random();
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => characters.codeUnitAt(
          random.nextInt(characters.length),
        ),
      ),
    );
  }
}
