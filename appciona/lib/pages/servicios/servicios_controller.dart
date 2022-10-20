import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:appciona/models/servicio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path/path.dart' as p;

import '../../config/shared_preferences_helper.dart';

class ServiciosController {
  final String fileUploadFailed = "File_Upload_Failed";
  final String getPositionFailed = "Get_Position_Failed";
  final String docServiceCreationFailed = "Doc_Service_Creation_Failed";
  final String docCreationSuccessful = "Doc_Creation_Successful";
  late Stream messageStream = const Stream.empty();
  String idciudad="null";
  late String roomID = "", messageId = "", myUid = "", myName = "",myciudad="";
  User? userInfo = FirebaseAuth.instance.currentUser;

  Servicio sugg = Servicio();
  late File? file;
  bool enviarCoord = false;

  Future<String> createDoc() async {
    try {
      if (file != null) {
        sugg.archivo = await uploadFile(file, sugg.titulo!);
        if (sugg.archivo!.startsWith(fileUploadFailed)) return fileUploadFailed;
      } else {
        sugg.archivo = "";
      }
      if (enviarCoord) {
        try {
          Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);
          sugg.ubicacion = {
            'Latitud': position.latitude.toString(),
            'Longitud': position.longitude.toString(),
          };
        } catch (e) {
          return getPositionFailed;
        }
      } else {
        sugg.ubicacion = {
          'Latitud': '',
          'Longitud': '',
        };
      }
      CollectionReference alimentoReference =
          FirebaseFirestore.instance.collection('Servicios');
      String uidGen = getRandomString(20);
      idciudad = await SharedPreferencesHelper.getUidCity() ?? "null";
      await alimentoReference.doc(uidGen).set({
        'Titulo': sugg.titulo,
        'Descripcion': sugg.descripcion,
        'Archivo': sugg.archivo,
        'Revisado': sugg.revisado,
        'Ubicacion': jsonDecode(jsonEncode(sugg.ubicacion)),
        'uid': uidGen,
        'Ciudad': idciudad,
      });
      return docCreationSuccessful;
    } catch (e) {
      return docServiceCreationFailed;
    }
  }

  Future<String> uploadFile(File? archivo, String nombre) async {
    try {
      var file = File(archivo!.path);
      final Reference storageReference =
          FirebaseStorage.instance.ref().child("Servicios");
      TaskSnapshot taskSnapshot = await storageReference
          .child("$nombre${getRandomString(10)}.${p.extension(archivo.path)}")
          .putFile(file);

      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (ex) {
      debugPrint('Error al subir archivo: $ex');
      return fileUploadFailed;
    }
  }
  Future<void> initChatRoom() async {
    idciudad = await SharedPreferencesHelper.getUidCity() ?? "null";
    if (userInfo != null) {
      myUid = userInfo!.uid;
      DocumentSnapshot qs = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userInfo!.uid)
          .get();
      myName = '${qs["nombre"]} ${qs["apellidos"]}';
      roomID = myUid;
      myciudad=idciudad;
    }
    try {
      messageStream = FirebaseFirestore.instance
          .collection("Mensajeria")
          .doc(roomID)
          .collection("Chats")
          .orderBy("ts", descending: true)
          .snapshots();
    } catch (e) {
      debugPrint('Error en la obtención de mensajes:\n$e');
    }
  }


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
    try {
      await docRef.set(
        {
          "Mensaje": mensaje,
          "Remitente": myName,
          "ts": ts,
        },
      );
      await updateLastMessageSend(
        {
          "UltimoMensaje": mensaje,
          "UltimoRemitente": myName,
          "ts": ts,
          "ChatDe": myName,
          "Ciudad": idciudad,
        },
      );
    } catch (e) {
      debugPrint('Error en la creacion de un mensaje nuevo:\n$e');
    }
    messageId = "";
  }
  Future updateLastMessageSend(Map<String, dynamic> data) async {
    try {
      DocumentReference docRef =
      FirebaseFirestore.instance.collection("Mensajeria").doc(roomID);
      await docRef.set(data);
    } catch (e) {
      debugPrint("Error al actualizar el último mensaje");
    }
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
