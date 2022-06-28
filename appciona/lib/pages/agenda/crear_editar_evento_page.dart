import 'package:appciona/pages/agenda/crear_editar_evento_controller.dart';
import 'package:flutter/material.dart';

class CrearEditarEventoPage extends StatefulWidget {
  const CrearEditarEventoPage({Key? key}) : super(key: key);

  @override
  State<CrearEditarEventoPage> createState() => _CrearEditarEventoPageState();
}

class _CrearEditarEventoPageState extends State<CrearEditarEventoPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController tituloCtrl = TextEditingController();
  TextEditingController descripcionCtrl = TextEditingController();
  TextEditingController fechaCtrl = TextEditingController();
  TextEditingController horaCtrl = TextEditingController();
  CrearEditarEventoController _controller = CrearEditarEventoController();

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
                TextBox(controller: tituloCtrl, label: 'Título'),
                TextBox(controller: descripcionCtrl, label: 'Descripción'),
                formItemsDesign(
                  IconButton(
                      onPressed: () {
                        _controller.selectDate(context);
                      },
                      icon: Icon(Icons.calendar_month_outlined)),
                  Text("${_controller.selectedDate.toLocal()}".split(' ')[0],
                      style: TextStyle(color: const Color(0xff6f6f6f))),
                ),
                formItemsDesign(
                  IconButton(
                      onPressed: () {
                        _controller.selectTime(context);
                      },
                      icon: Icon(Icons.watch_later_outlined)),
                  Text(
                      "${_controller.selectedTime24Hour.hour} : ${_controller.selectedTime24Hour.minute}",
                      style: TextStyle(color: const Color(0xff6f6f6f))),
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 20),
                _bottomSend(size),
                const SizedBox(height: 20),
                RaisedButton(
                  padding: const EdgeInsets.all(20),
                  textColor: Colors.white,
                  color: Colors.green,
                  onPressed: () {
                    _controller.obtenerAgendasUsuario();
                  },
                  child: const Text('Obtener agendas del usuario'),
                ),
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
      _controller.save(tituloCtrl.text, descripcionCtrl.text, context);
      _formKey.currentState!.reset();
    }
  }
}

class TextBox extends StatelessWidget {
  const TextBox({Key? key, required this.controller, required this.label})
      : super(key: key);

  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return '$label requerido';
        }
      },
    );
  }
}

formItemsDesign(icon, item) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 7),
    child: Card(child: ListTile(leading: icon, title: item)),
  );
}
