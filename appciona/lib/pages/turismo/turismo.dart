import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class TurismoPage extends StatefulWidget {
  const TurismoPage({Key? key}) : super(key: key);

  @override
  _TurismoPageState createState() => _TurismoPageState();
}

class _TurismoPageState extends State<TurismoPage> {
  String qrValue = "Codigo Qr";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          elevation: 2,
          backgroundColor: Colors.white,
          title: const Text("Turismo"),
          actions: [
            Image.asset(
              'assets/images/logo-green.png',
              fit: BoxFit.contain,
            )
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: scanQr,
          label: Text("Qr"),
          icon: Icon(Icons.camera_alt),
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }

  void scanQr() async {
    String? cameraScanResult = await scanner.scan();
    setState(() {
      qrValue = cameraScanResult ?? "Codigo Qr";
      if (qrValue != "Codigo Qr") {
        //REdireccionar
      }
    });
  }
}
