import 'package:cloud_firestore/cloud_firestore.dart';

class UsersModel {
  final String uid;
  final String nombre;
  final String apellidos;
  final String correo;
  final String dni;
  final String pass;

  UsersModel(
    this.uid,
    this.nombre,
    this.apellidos,
    this.correo,
    this.dni,
    this.pass,
  );

  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  Future<bool> agregarUsuarioFirestoreDocRandom() async {
    bool result = false;
    try {
      users
          .add({
            'uid': uid,
            'nombre': nombre,
            'apellidos': apellidos,
            'correo': correo,
            'dni': dni,
            'pass': pass,
          })
          .then((value) => result = true)
          .catchError((error) => result = false);
      return result;
    } catch (e) {
      return result;
    }
  }

  Future<bool> agregarUsuarioFirestore() async {
    bool result = false;
    try {
      users
          .doc(uid.toString())
          .set({
            'uid': uid,
            'nombre': nombre,
            'apellidos': apellidos,
            'correo': correo,
            'dni': dni,
            'pass': pass,
          })
          .then((value) => result = true)
          .catchError((error) => result = false);
      return result;
    } catch (e) {
      return result;
    }
  }
}
