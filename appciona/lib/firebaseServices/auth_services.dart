//import 'dart:developer';
//import 'dart:html';

//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'dart:html';

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final _auth = FirebaseAuth.instance;

  Future<UserCredential?> singIn(String mail, String password) async {
    UserCredential? userCredential;
    try {
      userCredential = await _auth.signInWithEmailAndPassword(
          email: mail, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return null;
      } else if (e.code == 'wrong-password') {
        return null;
      }
    }
    return null;
  }

  Future<UserCredential?> authSignUp(String mail, String password) async {
    UserCredential usuario;
    try {
      usuario = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: mail, password: password);
      return usuario;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return null;
      } else if (e.code == 'email-already-in-use') {
        return null;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }





  Future<UserCredential?> deleteUser(String mail, String password) async {
    UserCredential? userCredential;


    userCredential = await _auth.signInWithEmailAndPassword(
        email: mail, password: password);
      final user = userCredential.user;
      //print(user?.uid);
    await user?.delete();



    }

  }


