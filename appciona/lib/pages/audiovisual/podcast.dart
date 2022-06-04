import 'package:appciona/pages/audiovisual/podcast_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PodcastPage extends StatefulWidget {
  final String documentID;
  const PodcastPage({
    Key? key,
    required this.documentID,
  }) : super(key: key);

  @override
  State<PodcastPage> createState() => _PodcastPageState();
}

class _PodcastPageState extends State<PodcastPage> {
  final PodcastController _controller = PodcastController();

  void _launchPodcast(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      print('Could not launch ');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FutureBuilder(
              future: _controller.getSinglePodcast(widget.documentID),
              builder: (context, data) {
                if (data.hasData) {
                  DocumentSnapshot doc = data.data as DocumentSnapshot;
                  Timestamp t = doc["FechaPublicacion"];
                  DateTime d = t.toDate();
                  return Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              child: Image.network(
                                '${doc["Imagen"]}',
                                width: size.width * 0.40,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                '${doc["Titulo"]}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(color: Colors.black),
                            children: [
                              const TextSpan(
                                text: 'Fecha de publicación: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: formatDate(
                                  d,
                                  [
                                    dd,
                                    "-",
                                    mm,
                                    "-",
                                    yyyy,
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0XFF007474),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            const Text(
                              'Descripción',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                              ),
                            ),
                            const Divider(
                              color: Colors.white,
                            ),
                            Text(
                              '${doc["Descripcion"]}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      FloatingActionButton(
                        backgroundColor: Colors.white,
                        tooltip: 'Reproducir podcast',
                        onPressed: () => _launchPodcast(doc["Link"]),
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  );
                } else if (data.hasError) {
                  return Center(
                    child: Text('${data.error}'),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
