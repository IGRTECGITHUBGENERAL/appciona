import 'package:appciona/config/palette.dart';
import 'package:appciona/pages/turismo/lugares_interes/lugares_interes_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/shared_preferences_helper.dart';
import '../../Web/page_web.dart';

class LugaresInteresPage extends StatefulWidget {
  const LugaresInteresPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LugaresInteresPage> createState() => _LugaresInteresPageState();
}

class _LugaresInteresPageState extends State<LugaresInteresPage> {
  bool isMapSelected = false;
  String link="null";
  final box = GetStorage();
  final _initialCameraPosition = const CameraPosition(
    target: LatLng(37.9101298, -6.8306072),
    zoom: 15,
  );
  final LugaresInteresController _controller = LugaresInteresController();

  void changeView() async {
    if (await Permission.location.status.isDenied) {
      await Permission.location.request();
    } else {
      setState(() {
        isMapSelected = !isMapSelected;
      });
    }
  }

  @override
  void initState() {
    _controller.markers = [];
    super.initState();
     GetStorage.init();

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Lugares de interés",
              style: TextStyle(
                color: Palette.appcionaPrimaryColor,
              ),
            ),
            Text("-Places of interest-",
                style: TextStyle(
                    fontSize: 12, color: Palette.appcionaPrimaryColor)),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Palette.appcionaPrimaryColor,
          ),
        ),
        actions: [
          Image.asset(
            'assets/images/logo-green.png',
            fit: BoxFit.contain,
          )
        ],
      ),
      body: isMapSelected
          ? FutureBuilder(
              future: _controller.addMarkers(context),
              builder: (context, data) {
                if (data.hasData) {
                  return GoogleMap(
                    initialCameraPosition: _initialCameraPosition,
                    markers: Set.from(_controller.markers!),
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  FutureBuilder(
                    future: _controller.getNoticias(),
                    builder: (context, data) {
                      if (data.hasData) {
                        List<DocumentSnapshot> documents =
                            data.data as List<DocumentSnapshot>;
                        return documents.isEmpty
                            ? const Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                    'Parece que aún no hay puntos de interés.'),
                              )
                            : SizedBox(
                                width: size.width,
                                child: Wrap(
                                  alignment: WrapAlignment.spaceEvenly,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 5,
                                  runSpacing: 5,
                                  children: List.generate(
                                    documents.length,
                                    (index) => _cardPoint(
                                      documents[index]["Imagen"],
                                      documents[index]["Titulo"],
                                      documents[index]["Link"],
                                    ),
                                  ),
                                ),
                              );
                      } else if (data.hasError) {
                        return Text('${data.error}');
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
      /*  floatingActionButton: Stack(
        children: [
          Align(
            alignment:
                isMapSelected ? Alignment.bottomLeft : Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: FloatingActionButton.extended(
                backgroundColor: Palette.appcionaSecondaryColor,
                icon: isMapSelected
                    ? const Icon(Icons.newspaper_outlined)
                    : const Icon(Icons.map),
                onPressed: changeView,
                label: isMapSelected
                    ? const Text("Cambiar a cards")
                    : const Text("Cambiar a mapa"),
              ),
            ),
          ),
        ],
      ),*/
    );
  }

  Card _cardPoint(String imagen, String titulo, String link) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () async {

         // _nameSaver(link);
          if (!await launchUrl(Uri.parse(link))) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("No se pudo acceder al punto de interés."),
              ),
            );
          }
         /* box.write('link', link);
          SharedPreferencesHelper.addlink(link);
          print(box.read('link'));
          print("entrada   "+link);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WebViewXPage()),
          )
            ;
*/

        },
        child: SizedBox(
          width: 150,
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: CachedNetworkImage(
                  imageUrl: imagen,
                  placeholder: (context, url) =>
                      Image.asset('assets/images/logo-green.png'),
                  errorWidget: (context, url, error) =>
                      Image.asset('assets/images/logo-green.png'),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  color: Color(0XFF007474),
                ),
                width: 150,
                padding: const EdgeInsets.all(8),
                child: Text(
                  titulo,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Future<String> _nameSaver(String dato) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name2', dato);
    prefs.setString('school2', 'asdasdas');
    return 'saved';
  }

}

