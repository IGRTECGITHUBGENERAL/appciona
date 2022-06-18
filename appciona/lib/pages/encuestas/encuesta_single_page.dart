import 'package:appciona/models/pregunta.dart';
import 'package:appciona/pages/encuestas/encuestas_controller.dart';
import 'package:flutter/material.dart';

import '../../models/encuestas.dart';

class EncuestaSinglePage extends StatefulWidget {
  final String uidEncuesta;

  const EncuestaSinglePage({Key? key, required this.uidEncuesta})
      : super(key: key);

  @override
  State<EncuestaSinglePage> createState() => _EncuestaSinglePageState();
}

class _EncuestaSinglePageState extends State<EncuestaSinglePage> {
  final EncuestasController _controller = EncuestasController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: _controller.getSingleForm(widget.uidEncuesta),
          builder: (context, data) {
            if (data.hasData) {
              Encuestas encuesta = data.data as Encuestas;
              List<Pregunta> preguntas =
                  _controller.getPreguntas(encuesta.formulario);
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        '${encuesta.titulo}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network('${encuesta.imagen}'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 5.0,
                        ),
                        child: Text('${encuesta.descripcion}'),
                      ),
                      ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: preguntas.length,
                        itemBuilder: (context, index) {
                          switch (preguntas[index].tipoPregunta) {
                            case 'Cerrada':
                              return _questionCerrada(preguntas, index);
                            case 'OpcionMultiple':
                              return _questionOpcionMultiple(preguntas, index);
                            case 'Abierta':
                              return _questionAbierta(preguntas, index);
                            default:
                              return const SizedBox.shrink();
                          }
                        },
                      ),
                    ],
                  ),
                ),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        tooltip: 'Enviar repuesta(s)',
        onPressed: () {},
        child: Icon(
          Icons.check,
          color: Colors.green.shade100,
        ),
      ),
    );
  }

  Widget _questionCerrada(List<Pregunta> preguntas, int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.orange.shade200,
      ),
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      child: Column(
        children: [
          Text(
            '${preguntas[index].pregunta}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.brown.shade800,
              fontSize: 18,
            ),
          ),
          Divider(
            color: Colors.brown.shade900,
            thickness: 1,
          ),
          ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: preguntas[index].respuestas!.length,
            itemBuilder: (context, indexAnswers) {
              return Container(
                margin: const EdgeInsets.all(2),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0XFFFFEFD5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${preguntas[index].respuestas![indexAnswers]}',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _questionOpcionMultiple(List<Pregunta> preguntas, int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.orange.shade200,
      ),
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      child: Column(
        children: [
          Text(
            '${preguntas[index].pregunta}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.brown.shade800,
              fontSize: 18,
            ),
          ),
          Divider(
            color: Colors.brown.shade900,
            thickness: 1,
          ),
          ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: preguntas[index].respuestas!.length,
            itemBuilder: (context, indexAnswers) {
              return Container(
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: const Color(0XFFFFEFD5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: const Icon(Icons.check_box_outline_blank),
                  title: Text(
                    '${preguntas[index].respuestas![indexAnswers]}',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _questionAbierta(List<Pregunta> preguntas, int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.orange.shade200,
      ),
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      child: Column(
        children: [
          Text(
            '${preguntas[index].pregunta}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.brown.shade800,
              fontSize: 18,
            ),
          ),
          Divider(
            color: Colors.brown.shade900,
            thickness: 1,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color(0XFFFFF4E1),
            ),
            child: TextFormField(
              maxLines: null,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
