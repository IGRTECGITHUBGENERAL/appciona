import 'package:appciona/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String _nameKey = "nameUser";
  static const String _emailKey = "emailUser";
  static const String _uidUser = "uidUser";
  static Future<SharedPreferences> _prefs() async =>
      await SharedPreferences.getInstance();

  static Future<String?> getNameUser() async =>
      await _prefs().then((value) => value.getString(_nameKey));

  static Future<String?> getEmailUser() async =>
      await _prefs().then((value) => value.getString(_emailKey));

  static Future<String?> getUidUser() async =>
      await _prefs().then((value) => value.getString(_uidUser));

  static Future<bool> createUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      DocumentSnapshot ds = await FirebaseFirestore.instance
          .collection("Users")
          .doc(user!.uid)
          .get();
      UsersModel userData = UsersModel(
        user.uid,
        ds["nombre"],
        ds["apellidos"],
        ds["correo"],
        ds["dni"],
        "",
        ds["ciudad"],
        ds["rol"],
        ds["telefono"],
      );
      SharedPreferences pref = await _prefs();
      pref.setString(_nameKey, userData.nombre.toString());
      pref.setString(_emailKey, userData.correo.toString());
      pref.setString(_uidUser, userData.uid.toString());
    } catch (e) {
      debugPrint("Error al crear datos del usuario: $e");
    }
    return true;
  }

  static Future deleteUserData() async {
    SharedPreferences pref = await _prefs();
    pref.remove(_nameKey);
    pref.remove(_emailKey);
    pref.remove(_uidUser);
    pref.clear();
  }
}
