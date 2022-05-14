import 'package:flutter/material.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({Key? key}) : super(key: key);

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: const Text(
          'Agenda',
        ),
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              DateTime.now().toString(),
            ),
            Row(
              children: [
                Column(
                  children: const [
                    Text('Dom'),
                    Text('27'),
                  ],
                ),
                Column(
                  children: const [
                    Text('Lun'),
                    Text('28'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
