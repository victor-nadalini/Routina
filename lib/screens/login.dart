import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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

              SizedBox(height: 16),

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
            ],
          ),
        ),
      );
  }
}


// avaliar mais tarde 
/*
child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(
            50,
          ), // Para dar um pouco de espaçamento dentro da borda
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blueAccent,
              width: 2,
            ), // Definindo a cor e largura da borda
            borderRadius: BorderRadius.circular(
              10,
            ), // Para bordas arredondadas, se necessário
          ),
 */
