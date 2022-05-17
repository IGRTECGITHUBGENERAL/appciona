import 'package:flutter/material.dart';

class TurismoPage extends StatefulWidget {
  const TurismoPage({Key? key}) : super(key: key);

  @override
  _TurismoPageState createState() => _TurismoPageState();
}

class _TurismoPageState extends State<TurismoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              Text('Turismo'),
            ],
          ),
        ),
      ),
    );
  }
}
