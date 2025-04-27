import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class changeLogin extends StatefulWidget {
  const changeLogin({super.key});

  @override
  State<changeLogin> createState() => _changeLogin();
}

class _changeLogin extends State<changeLogin> {
  final logger = Logger();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ElevatedButton(
          onPressed: () => setState(() {
            logger.d("botão teste");
          }),
        child: Text(
          "Continuar sem login",
          style: TextStyle(color: Colors.white),
          )),
      ),
    );
  }
}