import 'package:appciona/config/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MensajeriaPage extends StatefulWidget {
  const MensajeriaPage({Key? key}) : super(key: key);

  @override
  State<MensajeriaPage> createState() => _MensajeriaPageState();
}

class _MensajeriaPageState extends State<MensajeriaPage> {
  final TextEditingController _messageCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0XFFF3F4F6),
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        title: const Text(
          "Mensajería",
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
        actions: [
          Image.asset(
            'assets/images/logo-green.png',
            fit: BoxFit.contain,
          )
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logo-green.png',
                    width: size.width * 0.40,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: const Text(
                      '¡Bienvenido!, este espacio, está destinado para que puedas comunicarte con nosotros de una forma más directa y personalizada.',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.80,
                    child: const Divider(
                      thickness: 1,
                      color: Palette.appcionaPrimaryColor,
                    ),
                  ),
                  _adminMessage(),
                  _userMessage(),
                  const SizedBox(
                    height: 70,
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: const Color(0XFFF3F4F6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: _textBox(
                        size,
                        'Mensaje',
                        _messageCtrl,
                        TextInputType.multiline,
                        TextInputAction.send,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          CupertinoIcons.arrow_right_circle_fill,
                          color: Palette.appcionaSecondaryColor,
                          size: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _userMessage() {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(
              top: 5,
              bottom: 5,
              left: 20,
            ),
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Palette.appcionaSecondaryColor,
            borderRadius: BorderRadius.circular(40),
          ),
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.all(5.0),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: Icon(
            CupertinoIcons.person_fill,
            color: Palette.appcionaSecondaryColor.shade100,
            size: 26,
          ),
        ),
      ],
    );
  }

  Widget _adminMessage() {
    return Row(
      children: [
        Container(
          alignment: Alignment.topCenter,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: Image.asset(
            'assets/images/logo-green.png',
            width: 40,
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(
              top: 5,
              bottom: 5,
              right: 20,
            ),
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Palette.appcionaPrimaryColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Container _textBox(Size size, String labelText, TextEditingController ctrl,
      TextInputType tit, TextInputAction tia) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.appcionaPrimaryColor.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: TextFormField(
        textInputAction: tia,
        keyboardType: tit,
        controller: ctrl,
        style: TextStyle(color: Palette.appcionaPrimaryColor.shade700),
        minLines: 1,
        maxLines: 4,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          hintText: labelText,
          hintStyle: TextStyle(
            color: Palette.appcionaPrimaryColor.shade600,
            fontWeight: FontWeight.w500,
          ),
          errorStyle: const TextStyle(fontWeight: FontWeight.bold),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
