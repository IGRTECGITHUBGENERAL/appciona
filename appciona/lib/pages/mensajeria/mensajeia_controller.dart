import 'package:firebase_auth/firebase_auth.dart';

//https://www.youtube.com/watch?v=2d1fslyxBjQ
class MensajeriaController {
  List<dynamic> mensajes = [];
  late String roomID, messageId = "";
  User? userInfo = FirebaseAuth.instance.currentUser;

  Future<void> setChatRoomId() async {
    if (userInfo != null) {
      roomID = "${userInfo!.uid}admin";
    }
  }

  Future<void> getAndSetMessages() async {}

  Future<void> getMessages() async {}
  Future<void> sendMessage() async {}
}
