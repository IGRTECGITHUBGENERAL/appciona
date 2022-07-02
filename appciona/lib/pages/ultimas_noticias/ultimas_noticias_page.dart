import 'package:appciona/config/palette.dart';
import 'package:appciona/pages/ultimas_noticias/ultimas_noticias_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

class UltimasNoticias extends StatefulWidget {
  final Widget drawer;
  const UltimasNoticias({
    Key? key,
    required this.drawer,
  }) : super(key: key);

  @override
  State<UltimasNoticias> createState() => _UltimasNoticiasState();
}

class _UltimasNoticiasState extends State<UltimasNoticias> {
  final UltimasNoticiasController _controller = UltimasNoticiasController();

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
        title: const Text(
          'Últimas noticias',
          style: TextStyle(
            color: Palette.appcionaPrimaryColor,
          ),
        ),
        centerTitle: true,
        actions: [
          Image.asset(
            'assets/images/logo-green.png',
            fit: BoxFit.contain,
          )
        ],
        iconTheme: const IconThemeData(
          color: Palette.appcionaPrimaryColor,
        ),
      ),
      drawer: Drawer(
        child: widget.drawer,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
                          documents[index]["Subtitulo"],
                          documents[index]["Texto"],
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
      ),
    );
  }

  Container _newCard(Size size, String img, String title, String subtitle,
      String text, String fecha) {
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
                child: CachedNetworkImage(
                  imageUrl: img,
                  placeholder: (context, url) =>
                      Image.asset('assets/images/logo-green.png'),
                  errorWidget: (context, url, error) =>
                      Image.asset('assets/images/logo-green.png'),
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
                      title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      text,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
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
