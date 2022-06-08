import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class TurismoController {
  late List<Marker>? markers;
  Future<bool> addMarkers() async {
    try {
      QuerySnapshot qs =
          await FirebaseFirestore.instance.collection("LugaresDeInteres").get();
      List<DocumentSnapshot> documents = qs.docs;
      for (var document in documents) {
        try {
          markers!.add(
            Marker(
              markerId: MarkerId(document.id),
              position: LatLng(
                double.parse(document["Latitud"]),
                double.parse(document["Longitud"]),
              ),
              infoWindow: InfoWindow(
                title: document["Titulo"],
              ),
              onTap: () async {
                if (!await launchUrl(Uri.parse(document["Link"]))) {
                  debugPrint('No se pudo abrir el enlace');
                }
              },
            ),
          );
        } on FormatException catch (e) {
          debugPrint('Error al convertir la latitud y longitud: \n->$e');
        }
      }
      await Future.delayed(
        const Duration(
          seconds: 3,
        ),
      );
      return true;
    } catch (e) {
      await Future.delayed(
        const Duration(
          seconds: 3,
        ),
      );
      return false;
    }
  }

  Future<dynamic> getNoticias() async {
    QuerySnapshot qs =
        await FirebaseFirestore.instance.collection('LugaresDeInteres').get();
    List<DocumentSnapshot> documents = qs.docs;
    return documents;
  }
}
