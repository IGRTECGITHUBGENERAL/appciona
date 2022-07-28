import 'package:appciona/config/palette.dart';
import 'package:appciona/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../firebaseServices/auth_services.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _keyForm = GlobalKey();

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
    if (_keyForm.currentState!.validate()) {
      setState(() {
        singin = true;
      });
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
            Navigator.of(context).popUntil((route) => counter++ >= 2);
          }
        }
      }
      setState(() {
        singin = false;
      });
    }
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
          style: TextStyle(
            color: Palette.appcionaPrimaryColor,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Palette.appcionaPrimaryColor,
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
                  Icons.person,
                ),
                _textBox(
                  size,
                  'Apellidos',
                  surnameCtrl,
                  TextInputType.text,
                  TextInputAction.next,
                  false,
                  Icons.person_outline,
                ),
                _textBox(
                  size,
                  'Correo electrónico',
                  emailCtrl,
                  TextInputType.emailAddress,
                  TextInputAction.next,
                  false,
                  Icons.email,
                ),
                _textBox(
                  size,
                  'DNI',
                  dniCtrl,
                  TextInputType.text,
                  TextInputAction.next,
                  false,
                  Icons.card_membership,
                ),
                _textBox(
                  size,
                  'Contraseña',
                  passCtrl,
                  TextInputType.visiblePassword,
                  TextInputAction.next,
                  true,
                  Icons.lock,
                ),
                _textBox(
                  size,
                  'Confirme contraseña',
                  passPassCtrl,
                  TextInputType.visiblePassword,
                  TextInputAction.done,
                  true,
                  Icons.lock_outline,
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
      TextInputType tit, TextInputAction tia, bool isPassword, IconData icon) {
    return Container(
      width: size.width * 0.75,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: Palette.appcionaPrimaryColor.shade100,
        borderRadius: BorderRadius.circular(10.0),
      ),
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
        style: const TextStyle(
          color: Palette.appcionaPrimaryColor,
        ),
        decoration: InputDecoration(
          icon: Icon(icon),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          hintText: labelText,
          hintStyle: TextStyle(
            color: Palette.appcionaPrimaryColor.shade400,
            fontWeight: FontWeight.bold,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
