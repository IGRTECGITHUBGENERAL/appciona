import 'package:appciona/config/palette.dart';

import 'package:appciona/models/citas.dart';
import 'package:appciona/pages/Citas/solicita_actualizacion_citas_page.dart';



import 'package:appciona/pages/widgets/alerts.dart';
import 'package:date_format/date_format.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Citas_Controller.dart';
import 'crear_editar_citas_page.dart';

class CitaPage extends StatefulWidget {
  const CitaPage({Key? key}) : super(key: key);

  @override
  State<CitaPage> createState() => _CitaPageState();
}

class _CitaPageState extends State<CitaPage> {

  DateTime now = new DateTime.now();

  DateTime _selectedDate = DateTime.now();

  final CitasController _controller = CitasController();


  @override
  Widget build(BuildContext context) {
    DateTime date = new DateTime(now.year, now.month, now.day);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0XFFF3F4F6),
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        title: const Text(
          "Citas",
          style: TextStyle(
            color: Palette.appcionaPrimaryColor,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Palette.appcionaPrimaryColor,
          ),
        ),
        actions: <Widget>[
          Center(
            child: Text(
              'Solicitar Cita',
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Palette.appcionaSecondaryColor,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Palette.appcionaSecondaryColor,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                  const CrearEditarCitasPage(isEditing: false),
                ),
              ).then(
                    (value) => setState(() {}),
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
                  return const Text('No fue posible cargar las fechas');
                } else {
                  return const LinearProgressIndicator();
                }
              },
            ),


            const SizedBox(
              height: 20,
            ),


            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(

              child: Column(
                children: <Widget>[
                  Text('Mis citas'),
                  FutureBuilder(
                    future: _controller.ObtenerCitas(_selectedDate),
                    builder: (context, data2) {
                      if (data2.hasData) {
                        List<Cita> citas = data2.data as List<Cita>;

                        if (citas.isEmpty) {
                          return const Text('No hay citas disponibles para este día');
                        } else {
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: citas.length,
                            itemBuilder: (context, index1) {
                              String hora =
                                  '${citas[index1].Fecha.hour} : ${citas[index1].Fecha.minute}';
                              String dia =
                              _controller.dias[citas[index1].Fecha.weekday - 1];
                              return _agendaPerDia(
                                  size,
                                  hora,
                                  dia,
                                  '${citas[index1].Titulo}',
                                  '${citas[index1].Estado}',
                                  '${citas[index1].Descripcion}',

                                  citas[index1]);
                            },
                          );
                        }
                      } else if (data2.hasError) {
                        return const Text('No fue posible cargar las fechas');
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },


                  ),
                ],
              ),
            ),
            SingleChildScrollView(

              child: Column(
                children: <Widget>[
                  Text('Citas previas disponibles'),
                  FutureBuilder(
                    future: _controller.ObtenerCitasAdministrador(_selectedDate),
                    builder: (context, data2) {
                      if (data2.hasData) {
                        List<Cita> citas = data2.data as List<Cita>;

                        if (citas.isEmpty) {
                          return const Text('No hay citas disponibles para este día');
                        } else {
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: citas.length,
                            itemBuilder: (context, index1) {
                              String hora =
                                  '${citas[index1].Fecha.hour} : ${citas[index1].Fecha.minute}';
                              String dia =
                              _controller.dias[citas[index1].Fecha.weekday - 1];
                              return _agendaPerDiaadmin(
                                  size,
                                  hora,
                                  dia,
                                  '${citas[index1].Titulo}',
                                  '${citas[index1].Estado}',
                                  '${citas[index1].Descripcion}',

                                  citas[index1]);
                            },
                          );
                        }
                      } else if (data2.hasError) {
                        return const Text('No fue posible cargar las fechas');
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },


                  ),
                ],
              ),
            ),

          ],





        ),

      ),

    );
  }

  Container _agendaPerDia(Size size, String noDia, String dia, String actividad,String estado,
      String hora, Cita citas) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 8.0,
      ),
      width: size.width * 0.9,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 5.0),
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
                  Text(
                    actividad,
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff7B91A3),
                      ),
                    ),
                  ),
                  Text(
                    hora,
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff7B91A3),
                      ),
                    ),
                  ),
                  Text(
                    estado,
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff7B91A3),
                      ),
                    ),
                  ),
                ],
              )
                  : const SizedBox.shrink(),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    color: const Color(0xff7B91A3),
                    icon: const Icon(Icons.create_outlined),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CrearEditarCitasPage(
                                isEditing: true, citasInfo: citas)),
                      ).then((value) => setState(() {}));
                    },
                  ),
                ],
              ),

              Row(
                children: <Widget>[
                  IconButton(
                    color: Colors.red.shade400,
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      Alerts.messageBoxCustom(
                        context,
                        const Text('Eliminar cita'),
                        const Text('¿Está seguro de eliminar la cita?'),
                        <Widget>[
                          TextButton(
                            child: const Text("Cancelar"),
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true).pop();
                            },
                          ),
                          TextButton(
                            child: const Text("Confirmar"),
                            onPressed: () {
                              _controller.eliminarEvento(citas.UsuarioId,citas.uid,citas.Tipo);
                              Navigator.of(context, rootNavigator: true).pop();
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CitaPage(),
                                ),
                              );
                              setState(() {});
                            },
                          )
                        ],
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _agendaPerDiaadmin(Size size, String noDia, String dia, String actividad,String estado,
      String hora, Cita citas) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 8.0,
      ),
      width: size.width * 0.9,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 5.0),
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
                  Text(
                    actividad,
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff7B91A3),
                      ),
                    ),
                  ),
                  Text(
                    hora,
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff7B91A3),
                      ),
                    ),
                  ),
                  Text(
                    estado,
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff7B91A3),
                      ),
                    ),
                  ),
                ],
              )
                  : const SizedBox.shrink(),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    color: Colors.teal.shade400,
                    icon: const Icon(Icons.check_box),
                    onPressed: () {
                      Alerts.messageBoxCustom(
                        context,
                        const Text('Reservar cita'),
                        const Text('¿Está seguro desea solicitar la cita?'),
                        <Widget>[
                          TextButton(
                            child: const Text("Cancelar"),
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true).pop();
                            },
                          ),
                          TextButton(
                            child: const Text("Confirmar"),
                            onPressed: () {
                              _controller.solicitacitausuariosistema(citas.uid);
                              Navigator.of(context, rootNavigator: true).pop();
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CitaPage(),
                                ),
                              );
                              setState(() {});
                            },
                          )
                        ],
                      );
                    },
                  ),
                ],
              ),



            ],
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
            color: Color(0xffFF9132),
          ),
          monthTextStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(0xffFF9132),
          ),
          dayTextStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(0xffFF9132),
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
