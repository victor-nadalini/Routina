import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class RegisterUserState extends StatefulWidget {
  const RegisterUserState({super.key});

  @override
  State<RegisterUserState> createState() => _RegisterUserStateState();
}

class _RegisterUserStateState extends State<RegisterUserState> {
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
              "Faça seu Cadastro",
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
                  hintText: "Digite a senha novamente",
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
                  hintText: "Digite seu nome",
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
                  logger.d("Cadastrar");
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
              "Cadastrar",
              style: TextStyle(color: Colors.white),
            ),
          ),

          SizedBox(height:16),

          Text(
            "Ja tem uma conta ?",
            style: TextStyle(color: Colors.blueAccent, fontSize:16),
            ), 
          TextButton(
            onPressed:() => setState(() {
            Navigator.pushReplacementNamed(context, "/Login");
            logger.d("link do login");
          },
          ),
          child: Text(
            "Fazer login",
            style: TextStyle(color:Colors.white,),
            ),
          )
          ],
        ),
      ),
    );
  }
}