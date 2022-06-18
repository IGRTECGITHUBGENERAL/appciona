import 'package:appciona/models/user_model.dart';
import 'package:appciona/pages/inicio/inicio_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../firebaseServices/auth_services.dart';
import '../widgets/drawer.dart';

class RegistroPage extends StatefulWidget {
  const RegistroPage({Key? key}) : super(key: key);

  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  GlobalKey<FormState> _keyForm = GlobalKey();

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController surnameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController dniCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();
  TextEditingController passPassCtrl = TextEditingController();

  bool singin = false;

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
    emailCtrl = TextEditingController()
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

  signUp() async {
    setState(() {
      singin = true;
    });
    if (_keyForm.currentState!.validate()) {
      AuthServices as = AuthServices();
      UserCredential? user = await as.authSignUp(emailCtrl.text, passCtrl.text);
      if (user != null) {
        UsersModel register = UsersModel(
          user.user!.uid,
          nameCtrl.text,
          surnameCtrl.text,
          emailCtrl.text,
          dniCtrl.text,
          passCtrl.text,
        );
        bool result = await register.agregarUsuarioFirestore();
        if (result) {
          UserCredential? uc = await as.singIn(emailCtrl.text, passCtrl.text);
          if (uc != null) {
            int counter = 0;
            Navigator.of(context).popUntil((route) => counter++ >= 3);
          }
        }
      }
    }
    setState(() {
      singin = false;
    });
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
        child: Form(
          key: _keyForm,
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
                  TextInputType.text,
                  TextInputAction.next,
                  false,
                ),
                _textBox(
                  size,
                  'Apellidos',
                  surnameCtrl,
                  TextInputType.text,
                  TextInputAction.next,
                  false,
                ),
                _textBox(
                  size,
                  'Correo electrónico',
                  emailCtrl,
                  TextInputType.emailAddress,
                  TextInputAction.next,
                  false,
                ),
                _textBox(
                  size,
                  'DNI',
                  dniCtrl,
                  TextInputType.text,
                  TextInputAction.next,
                  false,
                ),
                _textBox(
                  size,
                  'Contraseña',
                  passCtrl,
                  TextInputType.visiblePassword,
                  TextInputAction.next,
                  true,
                ),
                _textBox(
                  size,
                  'Confirme contraseña',
                  passPassCtrl,
                  TextInputType.visiblePassword,
                  TextInputAction.done,
                  true,
                ),
                ElevatedButton(
                  onPressed: singin ? null : signUp,
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
                      child: singin
                          ? RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(text: 'REGISTRANDO...  '),
                                  WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const Text(
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
      ),
    );
  }

  Container _textBox(Size size, String labelText, TextEditingController ctrl,
      TextInputType tit, TextInputAction tia, bool isPassword) {
    return Container(
      width: size.width * 0.75,
      margin: const EdgeInsets.all(10),
      child: TextFormField(
        controller: ctrl,
        textInputAction: tia,
        keyboardType: tit,
        obscureText: isPassword,
        validator: (value) {
          if (value!.isEmpty) {
            return "Campo necesario";
          } else {
            return null;
          }
        },
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
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              color: Color(0XFF005059),
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Colors.red.shade900,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
