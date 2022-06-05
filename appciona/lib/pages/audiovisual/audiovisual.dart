import 'package:appciona/pages/audiovisual/audiovisual_controller.dart';
import 'package:appciona/pages/audiovisual/podcast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AudiovisualPage extends StatefulWidget {
  const AudiovisualPage({Key? key}) : super(key: key);

  @override
  _AudiovisualPageState createState() => _AudiovisualPageState();
}

class _AudiovisualPageState extends State<AudiovisualPage> {
  final AudiovisualController _controller = AudiovisualController();

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
        title: const Text('Audiovisual'),
        centerTitle: true,
        actions: [
          Image.asset(
            'assets/images/logo-green.png',
            fit: BoxFit.contain,
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              FutureBuilder(
                future: _controller.getPodcast(),
                builder: (context, data) {
                  if (data.hasData) {
                    List<DocumentSnapshot> documents =
                        data.data as List<DocumentSnapshot>;
                    return ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: documents.isEmpty
                          ? 0
                          : documents.length > 20
                              ? 20
                              : documents.length,
                      itemBuilder: (context, index) {
                        Timestamp t = documents[index]["FechaPublicacion"];
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
                          documents[index].id,
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
      ),
    );
  }

  Container _newCard(
      Size size, String img, String desc, String fecha, String documentID) {
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
            spreadRadius: 0,
            blurRadius: 3,
          ),
        ],
      ),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => PodcastPage(
              documentID: documentID,
            ),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.30,
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
                    SizedBox(
                      width: size.width,
                      child: Text(
                        'Fecha de publlicación: $fecha',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.left,
                      ),
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
