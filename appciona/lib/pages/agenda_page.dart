import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
            _fechaHoy(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: DatePicker(
                DateTime.now(),
                selectionColor: const Color(0XFF027373),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _fechaHoy() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Row(
        children: [
          Text(
            DateFormat.d().format(
              DateTime.now(),
            ),
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Text(' '),
          Text(
            DateFormat.MMMM().format(
              DateTime.now(),
            ),
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Text(' '),
          Text(
            DateFormat.y().format(
              DateTime.now(),
            ),
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
