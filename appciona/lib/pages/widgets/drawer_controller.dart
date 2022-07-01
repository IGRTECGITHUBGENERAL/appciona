import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DrawerWidgetController {
  final User? _user = FirebaseAuth.instance.currentUser;

  Future<InfoUser> getUserInfo() async {
    try {
      DocumentSnapshot qs = await FirebaseFirestore.instance
          .collection('Users')
          .doc(_user!.uid)
          .get();
      InfoUser info = InfoUser(
        nombre: '${qs["nombre"]} ${qs["apellidos"]}',
        email: qs["correo"],
      );
      return info;
    } catch (e) {
      return InfoUser(nombre: '', email: '');
    }
  }
}

class InfoUser {
  String? nombre;
  String? email;

  InfoUser({
    this.nombre,
    this.email,
  });
}
