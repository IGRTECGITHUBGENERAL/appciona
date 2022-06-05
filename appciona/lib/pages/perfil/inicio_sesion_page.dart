import 'package:appciona/pages/perfil/registro_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InicioSesionPage extends StatefulWidget {
  const InicioSesionPage({Key? key}) : super(key: key);

  @override
  _InicioSesionPageState createState() => _InicioSesionPageState();
}

class _InicioSesionPageState extends State<InicioSesionPage> {
  TextEditingController dniCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();

  @override
  void initState() {
    dniCtrl = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    passCtrl = TextEditingController()
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: Image.asset(
                    'assets/images/logo-green.png',
                    fit: BoxFit.contain,
                    width: 200,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.10,
                ),
                _textBox(
                  size,
                  'Correo electrónico',
                  dniCtrl,
                  false,
                ),
                _textBox(
                  size,
                  'Contraseña',
                  passCtrl,
                  true,
                ),
                const SizedBox(
                  height: 20,
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
                          Color(0XFF005059),
                          Color(0XFF007373),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Container(
                      height: 40,
                      width: size.width * 0.6,
                      alignment: Alignment.center,
                      child: const Text(
                        'INICIAR SESIÓN',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: size.width * 0.60,
                  margin: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: const Divider(
                    height: 5,
                    thickness: 1,
                    color: Color(0XFF005059),
                  ),
                ),
                const Text('¿No tienes cuenta?'),
                TextButton(
                  onPressed: () => {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const RegistroPage(),
                      ),
                    ),
                  },
                  child: const Text(
                    'Registrate',
                    style: TextStyle(color: Colors.orange),
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
      bool isPassword) {
    return Container(
      width: size.width * 0.75,
      margin: const EdgeInsets.all(10),
      child: TextFormField(
        controller: ctrl,
        obscureText: isPassword,
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
