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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              "Seja bem vindo !",
              style: TextStyle(color: Colors.blueAccent, fontSize: 30),
            ),
          ),
          SizedBox(height: 66),
          ElevatedButton(
            onPressed:
                () => setState(() {
                  Navigator.pushReplacementNamed(context, '/kanban');
                  logger.d("teste botão continuar sem login");
                }),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(340, 73),
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: Colors.blueAccent),
              ),
            ),
            child: Text(
              "Continuar sem login",
              style: TextStyle(color: Colors.blueAccent),
            ),
          ),

          SizedBox(height: 20),

          ElevatedButton(
            onPressed:
                () => setState(() {
                  Navigator.pushReplacementNamed(context, '/Login');
                  logger.d("fazer login no app");
                }),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(340, 73),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: Colors.blueAccent),
              ),
            ),
            child: Text(
              "Login / Criar conta",
              style: TextStyle(color: Colors.blueAccent),
            ),
          ),
        ],
      ),
    );
  }
}
