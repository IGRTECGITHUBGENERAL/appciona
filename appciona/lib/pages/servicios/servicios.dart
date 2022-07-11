import 'dart:io';

import 'package:appciona/config/palette.dart';
import 'package:appciona/models/servicio.dart';
import 'package:appciona/pages/servicios/servicios_controller.dart';
import 'package:appciona/pages/widgets/alerts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ServiciosPage extends StatefulWidget {
  const ServiciosPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ServiciosPage> createState() => _ServiciosPageState();
}

class _ServiciosPageState extends State<ServiciosPage> {
  final ServiciosController _controller = ServiciosController();
  final GlobalKey<FormState> _keyForm = GlobalKey();

  late TextEditingController titleCtrl;
  late TextEditingController descrCtrl;

  late File? file;

  void submit() async {
    if (_keyForm.currentState!.validate()) {
      Alerts.messageBoxLoading(context, 'Enviando');
      Servicio sugg = Servicio();

      if (file != null) {
        String? urlFile = await _controller.uploadFile(file, titleCtrl.text);
        if (urlFile != null) {
          sugg.titulo = titleCtrl.text;
          sugg.descripcion = descrCtrl.text;
          sugg.archivo = urlFile;
          sugg.revisado = false;
          if (await _controller.createSuggestion(sugg)) {
            Navigator.of(context, rootNavigator: true).pop();
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("¡Sugerencia o queja enviado con éxito!"),
              ),
            );
          } else {
            Navigator.of(context, rootNavigator: true).pop();
            Alerts.messageBoxMessage(context, 'Ups',
                'Hubo un error al enviar tu sugerencia, inténtalo más tarde.');
          }
        } else {
          Navigator.of(context, rootNavigator: true).pop();
          Alerts.messageBoxMessage(context, 'Ups',
              'Hubo un error al subir el archivo, intentelo más tarde.');
        }
      } else {
        sugg.titulo = titleCtrl.text;
        sugg.descripcion = descrCtrl.text;
        sugg.archivo = '';
        sugg.revisado = false;
        if (await _controller.createSuggestion(sugg)) {
          Navigator.of(context, rootNavigator: true).pop();
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("¡Sugerencia o queja enviado con éxito!"),
            ),
          );
        } else {
          Navigator.of(context, rootNavigator: true).pop();
          Alerts.messageBoxMessage(context, 'Ups',
              'Hubo un error al enviar tu sugerencia, inténtalo más tarde.');
        }
      }
    }
  }

  @override
  void initState() {
    titleCtrl = TextEditingController(text: '');
    descrCtrl = TextEditingController(text: '');
    file = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Palette.appcionaPrimaryColor,
          ),
        ),
        title: const Text(
          "Servicios",
          style: TextStyle(
            color: Palette.appcionaPrimaryColor,
          ),
        ),
        centerTitle: true,
        actions: [
          Image.asset(
            'assets/images/logo-green.png',
            fit: BoxFit.contain,
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _keyForm,
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Manda tu queja o sugerencia',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.75,
                    child: const Divider(
                      thickness: 1,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.orange.shade200,
                    ),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: size.width * 0.75,
                          margin: const EdgeInsets.only(top: 20, bottom: 5),
                          child: Text(
                            'Coloca un titulo que nos permita identificar tu sugerencia de la mejor forma.',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.brown.shade800,
                            ),
                          ),
                        ),
                        _textBox(size, 'Titulo', titleCtrl, TextInputType.text,
                            TextInputAction.next, false),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.orange.shade200,
                    ),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: size.width * 0.75,
                          margin: const EdgeInsets.only(top: 20, bottom: 5),
                          child: Text(
                            'La descripción es muy importante para nosotros, pues es tu opinión, detalla al máximo posible el inconveniente.',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.brown.shade800,
                            ),
                          ),
                        ),
                        _textBox(size, 'Descripcion', descrCtrl,
                            TextInputType.text, TextInputAction.done, true),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.orange.shade200,
                    ),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: size.width * 0.75,
                          margin: const EdgeInsets.only(top: 20, bottom: 5),
                          child: Text(
                            'Si así lo requieres, adjunta un archivo para complementar la sugerencia.',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.brown.shade800,
                            ),
                          ),
                        ),
                        _file(size),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0XFF007474),
                    ),
                    onPressed: submit,
                    child: const Text(
                      "Enviar",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Card _file(Size size) {
    return Card(
      color: const Color(0XFFFFEFD5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles();
          if (result != null) {
            file = File('${result.files.single.path}');
            setState(() {});
          }
        },
        child: Container(
          width: size.width * 0.75,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              const Icon(Icons.file_open),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: file != null
                    ? Text(file!.path.split('/').last)
                    : const Text('Ningún archivo seleccionado'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _textBox(Size size, String labelText, TextEditingController ctrl,
      TextInputType tit, TextInputAction tia, bool isLarge) {
    return Container(
      width: size.width * 0.75,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0XFFFFEFD5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        textInputAction: tia,
        keyboardType: tit,
        controller: ctrl,
        maxLines: isLarge ? null : 1,
        minLines: isLarge ? 6 : 1,
        validator: (value) {
          return value!.isEmpty ? 'El campo está vacío' : null;
        },
        style: TextStyle(color: Colors.brown.shade800),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          hintText: labelText,
          hintStyle: TextStyle(color: Colors.brown.shade500),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
