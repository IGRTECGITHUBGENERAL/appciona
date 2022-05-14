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
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0XFFF3F4F6),
      appBar: AppBar(
        elevation: 2,
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
            _barraDeDias(),
            const SizedBox(
              height: 20,
            ),
            _agendaPerDia(
              size,
              DateFormat.d().format(
                DateTime.now(),
              ),
              'Sab',
              '',
              '',
            ),
            _agendaPerDia(
              size,
              DateFormat.d().format(
                DateTime.now().add(
                  const Duration(
                    days: 1,
                  ),
                ),
              ),
              'Dom',
              '',
              '',
            ),
            _agendaPerDia(
              size,
              DateFormat.d().format(
                DateTime.now().add(
                  const Duration(
                    days: 2,
                  ),
                ),
              ),
              'Lun',
              '',
              '',
            ),
            _agendaPerDia(
              size,
              DateFormat.d().format(
                DateTime.now().add(
                  const Duration(
                    days: 3,
                  ),
                ),
              ),
              'Mar',
              'San Silvestre virtual',
              '12:00 PM.',
            ),
          ],
        ),
      ),
    );
  }

  Container _agendaPerDia(
      Size size, String noDia, String dia, String actividad, String hora) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      width: size.width * 0.9,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      noDia,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: noDia.contains(_selectedDate.day.toString())
                              ? const Color(0XFF00BAEF)
                              : const Color(0XFF7B91A3),
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      dia,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: noDia.contains(_selectedDate.day.toString())
                              ? const Color(0XFF00BAEF)
                              : const Color(0XFF7B91A3),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            width: size.width * 0.75,
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              color:
                  actividad.isNotEmpty ? Colors.white : const Color(0XFFF3F4F6),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: actividad.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(actividad),
                      Text(hora),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Container _barraDeDias() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: DatePicker(
        DateTime.now(),
        dateTextStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.grey,
        ),
        monthTextStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.grey,
        ),
        dayTextStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.grey,
        ),
        selectionColor: const Color(0XFF00BAEF),
        onDateChange: (date) {
          _selectedDate = date;
          setState(() {});
        },
      ),
    );
  }

  Container _fechaHoy() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Row(
        children: [
          Text(
            'Hoy: ',
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ),
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
