import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final logger = Logger();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Faça seu login",
              style: TextStyle(color: Colors.blueAccent, fontSize: 30),
            ),

            SizedBox(height: 66),

            const SizedBox(
              width: 340,
              height: 73,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                  contentPadding: EdgeInsets.only(left: 12),
                  hintText: "Digite seu E-mail",
                  hintStyle: TextStyle(color: Colors.blueAccent),
                  fillColor: Colors.black,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
              ),
            ),

            SizedBox(height: 8),

            const SizedBox(
              width: 340,
              height: 73,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                  contentPadding: EdgeInsets.only(left: 12),
                  hintText: "Digite sua senha",
                  hintStyle: TextStyle(color: Colors.blueAccent),
                  fillColor: Colors.black,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
              ),
            ),

            SizedBox(height: 16),

            ElevatedButton(
            onPressed:
                () => setState(() {
                  Navigator.pushReplacementNamed(context, '/kanban');
                  logger.d("Entrar no app");
                }),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(340, 73),
              backgroundColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: Colors.white),
              ),
            ),
            child: Text(
              "Entrar",
              style: TextStyle(color: Colors.white),
            ),
          ),

          SizedBox(height:16),

          Text(
            "Não tem conta ?",
            style: TextStyle(color: Colors.blueAccent, fontSize:16),
            ), 
          TextButton(
            onPressed:() => setState(() {
            Navigator.pushReplacementNamed(context, "/RegisterUser");
            logger.d("link do criar conta");
          },
          ),
          child: Text(
            "Criar uma conta",
            style: TextStyle(color:Colors.white,),
            ),
          )
          ],
        ),
      ),
    );
  }
}