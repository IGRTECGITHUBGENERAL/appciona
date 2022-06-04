import 'package:appciona/pages/inicio/encuestas_page.dart';
import 'package:appciona/pages/inicio/inicio_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'agenda_page.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({Key? key}) : super(key: key);

  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  final InicioController _controller = InicioController();

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
        title: const Text('Últimas noticias'),
        centerTitle: true,
        actions: [
          Image.asset(
            'assets/images/logo-green.png',
            fit: BoxFit.contain,
          )
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.book),
                title: const Text("Agenda"),
                onTap: () => {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const AgendaPage(),
                    ),
                  )
                },
              ),
              ListTile(
                leading: const Icon(Icons.question_answer_outlined),
                title: const Text("Encuestas"),
                onTap: () => {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const EncuestasPage(),
                    ),
                  )
                },
              ),
            ],
          ),
        ),
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

  Container _newCard(Size size, String img, String desc, String fecha) {
    return Container(
      width: size.width * 0.90,
      height: 160,
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
