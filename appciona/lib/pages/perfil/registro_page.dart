import 'package:flutter/material.dart';

class RegistroPage extends StatefulWidget {
  const RegistroPage({Key? key}) : super(key: key);

  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController surnameCtrl = TextEditingController();
  TextEditingController dniCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();
  TextEditingController passPassCtrl = TextEditingController();

  @override
  void initState() {
    nameCtrl = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    surnameCtrl = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    dniCtrl = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    passCtrl = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    passPassCtrl = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Registrarse',
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 5),
                child: Image.asset(
                  'assets/images/logo-green.png',
                  fit: BoxFit.contain,
                  width: 100,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Introduzca su información para poder crear su cuenta.',
                ),
              ),
              _textBox(
                size,
                'Nombre',
                nameCtrl,
              ),
              _textBox(
                size,
                'Apellidos',
                surnameCtrl,
              ),
              _textBox(
                size,
                'DNI',
                dniCtrl,
              ),
              _textBox(
                size,
                'Contraseña',
                passCtrl,
              ),
              _textBox(
                size,
                'Confirme contraseña',
                passPassCtrl,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0XFFFF8C29),
                        Color.fromARGB(255, 243, 93, 34),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Container(
                    height: 40,
                    width: size.width * 0.6,
                    alignment: Alignment.center,
                    child: const Text(
                      'REGISTRARME',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _textBox(Size size, String labelText, TextEditingController ctrl) {
    return Container(
      width: size.width * 0.75,
      margin: const EdgeInsets.all(10),
      child: TextFormField(
        controller: ctrl,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          labelText: labelText,
          labelStyle: const TextStyle(
            color: Color(0XFF007474),
            fontWeight: FontWeight.bold,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              color: Color(0XFF005059),
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              color: Color(0XFF005059),
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
