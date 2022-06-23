import 'package:flutter/material.dart';

class CrearEventoPage extends StatefulWidget {
  const CrearEventoPage({Key? key}) : super(key: key);

  @override
  State<CrearEventoPage> createState() => _CrearEventoPageState();
}

class _CrearEventoPageState extends State<CrearEventoPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController tituloCtrl = TextEditingController();
  TextEditingController descripcionCtrl = TextEditingController();
  TextEditingController fechaCtrl = TextEditingController();
  TextEditingController horaCtrl = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime24Hour = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? timePicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (timePicked != null && timePicked != selectedTime24Hour) {
      setState(() {
        selectedTime24Hour = timePicked;
      });
    }
  }

  @override
  void dispose() {
    tituloCtrl.dispose();
    descripcionCtrl.dispose();
    fechaCtrl.dispose();
    horaCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Nuevo evento'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(60.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextBox(
                  controller: tituloCtrl,
                  label: 'Título',
                  status: false,
                ),
                TextBox(
                  controller: descripcionCtrl,
                  label: 'Descripción',
                  status: false,
                ),
                formItemsDesign(
                  IconButton(
                      onPressed: () {
                        _selectDate(context);
                      },
                      icon: Icon(Icons.calendar_month_outlined)),
                  TextBox(
                    controller: fechaCtrl,
                    //label: "${selectedDate.toLocal()}".split(' ')[0],
                    label: "${selectedDate.toLocal()}".toString(),
                    status: true,
                  ),
                ),
                formItemsDesign(
                  IconButton(
                      onPressed: () {
                        _selectTime(context);
                      },
                      icon: Icon(Icons.watch_later_outlined)),
                  TextBox(
                    controller: horaCtrl,
                    //label: "${selectedTime24Hour.hour} : ${selectedTime24Hour.minute}",
                    label: "${selectedTime24Hour}".toString(),
                    status: true,
                  ),
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 20),
                _bottomSend(size),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomSend(Size size) {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size(size.width * 0.8, 60.0),
            primary: const Color(0xff2196F3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(60.0),
            ),
          ),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: const Text(
              'Crear',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          onPressed: () {
            save();
          },
        );
      },
    );
  }

  save() {
    if (_formKey.currentState!.validate()) {
      print("Título: ${tituloCtrl.text}");
      print("Descripción: ${descripcionCtrl.text}");
      print("Fecha: ${selectedDate.toLocal()}");
      print("Hora: ${selectedTime24Hour}");
      _formKey.currentState!.reset();
    }
  }
}

class TextBox extends StatelessWidget {
  const TextBox(
      {Key? key,
      required this.controller,
      required this.label,
      required this.status})
      : super(key: key);

  final TextEditingController controller;
  final String label;
  final bool status;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
      ),
      validator: (value) {
        if (status == false && value!.isEmpty) {
          return '$label requerido';
        }
      },
      readOnly: status,
    );
  }
}

formItemsDesign(icon, item) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 7),
    child: Card(child: ListTile(leading: icon, title: item)),
  );
}
