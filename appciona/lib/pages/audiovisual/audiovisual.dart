import 'package:flutter/material.dart';

class AudiovisualPage extends StatefulWidget {
  const AudiovisualPage({Key? key}) : super(key: key);

  @override
  _AudiovisualPageState createState() => _AudiovisualPageState();
}

class _AudiovisualPageState extends State<AudiovisualPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              Text('Audiovisual'),
            ],
          ),
        ),
      ),
    );
  }
}
