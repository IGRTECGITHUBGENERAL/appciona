import 'package:appciona/pages/agenda/agenda_controller.dart';
import 'package:appciona/pages/agenda/crear_evento_page.dart';
import 'package:date_format/date_format.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({Key? key}) : super(key: key);

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  DateTime _selectedDate = DateTime.now();
  final AgendaController _controller = AgendaController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0XFFF3F4F6),
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        title: const Text("Agenda"),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: <Widget>[
          Center(
            child: Text(
              'Nuevo evento',
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          IconButton(
            icon: new Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CrearEventoPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _fechaHoy(),
            FutureBuilder(
              future: _controller.obtenerFechasConEventos(),
              builder: (context, data) {
                if (data.hasData) {
                  List<DateTime> fechasActivas = data.data as List<DateTime>;
                  return _barraDeDias(fechasActivas);
                } else if (data.hasError) {
                  return Text('No fue posible cargar las fechas');
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            _agendaPerDia(
              size,
              formatDate(
                DateTime.now(),
                [dd],
              ),
              'Sab',
              '',
              '',
            ),
            _agendaPerDia(
              size,
              formatDate(
                DateTime.now().add(
                  const Duration(days: 1),
                ),
                [dd],
              ),
              'Dom',
              '',
              '',
            ),
            _agendaPerDia(
              size,
              formatDate(
                DateTime.now().add(
                  const Duration(days: 2),
                ),
                [dd],
              ),
              'Lun',
              '',
              '',
            ),
            _agendaPerDia(
              size,
              formatDate(
                DateTime.now().add(
                  const Duration(days: 3),
                ),
                [dd],
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
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                color: actividad.isNotEmpty
                    ? Colors.white
                    : const Color(0XFFF3F4F6),
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
          ),
        ],
      ),
    );
  }

  Container _barraDeDias(List<DateTime> fechasConEventos) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: DatePicker(DateTime.now(),
          initialSelectedDate: DateTime.now(),
          daysCount: 50,
          dateTextStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            color: const Color(0xffFF9132),
          ),
          monthTextStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            color: const Color(0xffFF9132),
          ),
          dayTextStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            color: const Color(0xffFF9132),
          ),
          selectionColor: const Color(0XFF00BAEF), onDateChange: (date) {
        _selectedDate = date;
        setState(() {});
      },
          locale: "es_MX",
          activeDates: fechasConEventos,
          deactivatedColor: Colors.grey),
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
            formatDate(
              DateTime.now(),
              [
                _controller.dias[DateTime.now().weekday - 1],
                " ",
                dd,
                " ",
                _controller.meses[DateTime.now().month - 1],
                " ",
                yyyy
              ],
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
