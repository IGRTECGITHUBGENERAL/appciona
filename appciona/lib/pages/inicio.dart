import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({Key? key}) : super(key: key);

  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _newCard(
              size,
              'assets/images/logo-green.png',
              'Cortegana crea una web de tursimo',
              formatDate(
                DateTime.now(),
                [
                  dd,
                  "-",
                  mm,
                  "-",
                  yyyy,
                ],
              ),
            ),
            _newCard(
              size,
              'assets/images/logo-green.png',
              'El Ayuntamiento de Cortegana organiza una carrera San Silvestre virtual para colaborar con una buena causa',
              formatDate(
                DateTime.now(),
                [
                  dd,
                  "-",
                  mm,
                  "-",
                  yyyy,
                ],
              ),
            ),
            _newCard(
              size,
              'assets/images/logo-green.png',
              'Conciertos de Fin de Año en Cortegana',
              formatDate(
                DateTime.now(),
                [
                  dd,
                  "-",
                  mm,
                  "-",
                  yyyy,
                ],
              ),
            ),
            _newCard(
              size,
              'assets/images/logo-green.png',
              'El Ayuntamiento de Cortegana "abre el paraguas" contra la violencia hacia la mujer',
              formatDate(
                DateTime.now(),
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
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(
            img,
            fit: BoxFit.contain,
            height: 150,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    desc,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const Spacer(),
                  Text(
                    fecha,
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
