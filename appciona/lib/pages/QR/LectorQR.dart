import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  String qrValue = "Codigo Qr";
  void scanQr() async {
    String? cameraScanResult = await scanner.scan();
    setState(() {
      qrValue = cameraScanResult ?? "Codigo Qr";
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
