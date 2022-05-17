import 'package:flutter/material.dart';

class EncuestasPage extends StatefulWidget {
  const EncuestasPage({Key? key}) : super(key: key);

  @override
  State<EncuestasPage> createState() => _EncuestasPageState();
}

class _EncuestasPageState extends State<EncuestasPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0XFFF3F4F6),
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        title: const Text("Encuestas"),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          Image.asset(
            'assets/images/logo-green.png',
            fit: BoxFit.contain,
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                _encuesta(
                  size,
                  '¿Te gusta más las calles empedradas o adoquinadas?',
                  'https://cdn.pixabay.com/photo/2019/12/10/10/53/architecture-4685608_960_720.jpg',
                  'Un resumen',
                  'Un texto descriptivo a fondo',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _encuesta(
      Size size, String titulo, String urlImg, String resumen, String cuerpo) {
    return Container(
      width: size.width * 0.95,
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              titulo,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Image.network(urlImg),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(resumen),
          ),
          Text(cuerpo),
        ],
      ),
    );
  }
}
