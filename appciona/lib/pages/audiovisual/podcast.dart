import 'package:appciona/pages/audiovisual/podcast_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
                  return Column(
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            child: Image.network('${doc["Imagen"]}'),
                          ),
                          Text('${doc["Titulo"]}'),
                        ],
                      ),
                      Text('Fecha de publicación: ${doc["FechaPublicacion"]}'),
                      Text('Descripción\n${doc["Descripcion"]}'),
                      Text('${doc["Link"]}'),
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
