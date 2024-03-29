import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/shared_preferences_helper.dart';

import '../../widgets/alerts.dart';

class LugaresInteresController {
  late List<Marker>? markers;

  Future<bool> addMarkers(BuildContext context) async {
    late QuerySnapshot qs;

    try {
      qs =
          await FirebaseFirestore.instance.collection("LugaresDeInteres").get();
      List<DocumentSnapshot> documents = qs.docs;
      for (var document in documents) {
        print("debuggin two");
        try {
          markers!.add(
            Marker(
              markerId: MarkerId(document.id),
              position: LatLng(
                double.parse(document["Latitud"]),
                double.parse(document["Longitud"]),
              ),
              onTap: () {
                Alerts.messageBoxCustom(
                  context,
                  Text(document["Titulo"]),
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: CachedNetworkImage(
                      imageUrl: document["Imagen"],
                      placeholder: (context, url) =>
                          Image.asset('assets/images/logo-green.png'),
                      errorWidget: (context, url, error) =>
                          Image.asset('assets/images/logo-green.png'),
                    ),
                  ),
                  [
                    TextButton(
                      onPressed: () =>
                          Navigator.of(context, rootNavigator: true).pop(),
                      child: const Text('Cerrar'),
                    ),
                    TextButton(
                      onPressed: () async {
                        if (!await launchUrl(Uri.parse(document["Link"]))) {
                          debugPrint('No se pudo abrir el enlace');
                        }
                      },
                      child: const Text(
                        'Ver más...',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0XFF007474),
                        ),
                      ),
                    ),
                  ],
                );
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
    String idciudad = "null";
    late QuerySnapshot qs;
    idciudad = await SharedPreferencesHelper.getUidCity() ?? "null";

    if (idciudad == null || idciudad == "null") {
      qs = await FirebaseFirestore.instance
          .collection("LugaresDeInteres")
          .where("Ciudad", isEqualTo: "$idciudad")
          .get();
    } else {
      qs = await FirebaseFirestore.instance
          .collection("LugaresDeInteres")
          .where("Ciudad", isEqualTo: "$idciudad")
          .get();
    }
    List<DocumentSnapshot> documents = qs.docs;
    return documents;
  }
}
