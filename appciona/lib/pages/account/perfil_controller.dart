import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PerfilController {
  final User? user = FirebaseAuth.instance.currentUser;

  Future<dynamic> userInfo() async {
    DocumentSnapshot qs = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .get();
    return qs;
  }
}
