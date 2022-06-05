import 'package:appciona/pages/turismo/qr_page.dart';
import 'package:appciona/pages/turismo/turismo_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TurismoPage extends StatefulWidget {
  const TurismoPage({Key? key}) : super(key: key);

  @override
  _TurismoPageState createState() => _TurismoPageState();
}

class _TurismoPageState extends State<TurismoPage> {
  String qrValue = "Codigo Qr";
  bool isMapSelected = false;

  final _initialCameraPosition = const CameraPosition(
    target: LatLng(40.9776352, -0.4492164),
    zoom: 15,
  );
  final TurismoController _controller = TurismoController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          backgroundColor: Colors.white,
          title: const Text("Turismo"),
          centerTitle: true,
          actions: [
            Image.asset(
              'assets/images/logo-green.png',
              fit: BoxFit.contain,
            )
          ],
        ),
        body: isMapSelected
            ? GoogleMap(
                initialCameraPosition: _initialCameraPosition,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
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
                          return ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: documents.isEmpty ? 0 : documents.length,
                            itemBuilder: (context, index) {
                              Timestamp t = documents[index]["Fecha"];
                              DateTime d = t.toDate();
                              return _newCard(
                                size,
                                documents[index]["Imagen"],
                                documents[index]["Titulo"],
                                formatDate(
                                  d,
                                  [
                                    dd,
                                    "-",
                                    mm,
                                    "-",
                                    yyyy,
                                  ],
                                ),
                              );
                            },
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
        floatingActionButton: Stack(
          children: [
            Align(
              alignment:
                  isMapSelected ? Alignment.bottomLeft : Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: SpeedDial(
                  backgroundColor: const Color(0XFF007474),
                  animatedIcon: AnimatedIcons.menu_close,
                  foregroundColor: Colors.white,
                  children: [
                    SpeedDialChild(
                      onTap: () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const QRPage(),
                        ),
                      ),
                      child: Icon(
                        Icons.qr_code,
                        color: Colors.orange.shade600,
                      ),
                      label: 'QR',
                    ),
                    SpeedDialChild(
                      onTap: () => setState(() {
                        isMapSelected = !isMapSelected;
                      }),
                      child: isMapSelected
                          ? Icon(
                              Icons.newspaper,
                              color: Colors.orange.shade600,
                            )
                          : Icon(
                              Icons.map_rounded,
                              color: Colors.orange.shade600,
                            ),
                      label: 'Mapa',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Container _newCard(Size size, String img, String desc, String fecha) {
    return Container(
      width: size.width * 0.90,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 6,
          ),
        ],
      ),
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.50,
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  img,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      desc,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      fecha,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
