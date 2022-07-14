import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:appciona/models/servicio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ServiciosController {
  Future<bool> createSuggestion(Servicio sugerencia) async {
    try {
      CollectionReference alimentoReference =
          FirebaseFirestore.instance.collection('Servicios');
      String uidGen = getRandomString(20);
      await alimentoReference.doc(uidGen).set({
        'Titulo': sugerencia.titulo,
        'Descripcion': sugerencia.descripcion,
        'Archivo': sugerencia.archivo,
        'Revisado': sugerencia.revisado,
        'Ubicacion': jsonDecode(jsonEncode(sugerencia.ubicacion)),
        'uid': uidGen,
      });
      return true;
    } catch (ex) {
      print('Error al crear: $ex');
      return false;
    }
  }

  Future<String?> uploadFile(File? imagen, String nombre) async {
    try {
      var file = File(imagen!.path);
      final Reference storageReference =
          FirebaseStorage.instance.ref().child("Servicios");

      TaskSnapshot taskSnapshot = await storageReference
          .child("$nombre${getRandomString(10)}.jpg")
          .putFile(file);

      var downloadUrl = await taskSnapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (ex) {
      print('Error al subir imagen: $ex');
      return null;
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
