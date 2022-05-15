import 'package:flutter/material.dart';

class MensajeriaPage extends StatefulWidget {
  const MensajeriaPage({Key? key}) : super(key: key);

  @override
  _MensajeriaPageState createState() => _MensajeriaPageState();
}

class _MensajeriaPageState extends State<MensajeriaPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          Text('Mensajeria'),
        ],
      ),
    );
  }
}
