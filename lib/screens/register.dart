import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:routina/controllers/user_controller.dart';
import 'package:uuid/uuid.dart';

class RegisterUserState extends StatefulWidget {
  const RegisterUserState({super.key});

  @override
  State<RegisterUserState> createState() => _RegisterUserStateState();
}

class _RegisterUserStateState extends State<RegisterUserState> {
  final logger = Logger();
  final UserController _userController = UserController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmarSenhaController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final _uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Faça seu Cadastro",
                style: TextStyle(color: Colors.blueAccent, fontSize: 30),
              ),

              SizedBox(height: 66),

              SizedBox(
                width: 340,
                height: 73,
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                    contentPadding: EdgeInsets.only(left: 12),
                    hintText: "Digite seu E-mail",
                    hintStyle: TextStyle(color: Colors.blueAccent),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                  ),
                ),
              ),

              SizedBox(
                width: 340,
                height: 73,
                child: TextFormField(
                  controller: _nomeController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                    contentPadding: EdgeInsets.only(left: 12),
                    hintText: "Digite seu nome",
                    hintStyle: TextStyle(color: Colors.blueAccent),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 8),

              SizedBox(
                width: 340,
                height: 73,
                child: TextFormField(
                  controller: _senhaController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                    contentPadding: EdgeInsets.only(left: 12),
                    hintText: "Digite sua senha",
                    hintStyle: TextStyle(color: Colors.blueAccent),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 8),

              SizedBox(
                width: 340,
                height: 73,
                child: TextFormField(
                  controller: _confirmarSenhaController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                    contentPadding: EdgeInsets.only(left: 12),
                    hintText: "Digite a senha novamente",
                    hintStyle: TextStyle(color: Colors.blueAccent),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16),

              ElevatedButton(
                onPressed: () {
                  logger.d("usuarios cadastrados: $_userController");
                  logger.d(_userController.usuarios);
                  if (_formKey.currentState!.validate()) {
                    () => setState(() {
                      final id = _uuid.v4();
                      _userController.adicionarUsuario(
                        _nomeController.text,
                        _emailController.text,
                        _senhaController.text,
                        _confirmarSenhaController.text,
                        id,
                      );
                      
                    });
                  }
                },

                style: ElevatedButton.styleFrom(
                  minimumSize: Size(340, 73),
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(color: Colors.white),
                  ),
                ),
                child: Text("Cadastrar", style: TextStyle(color: Colors.white)),
              ),

              SizedBox(height: 16),

              Text(
                "Ja tem uma conta ?",
                style: TextStyle(color: Colors.blueAccent, fontSize: 16),
              ),
              TextButton(
                onPressed:
                    () => setState(() {
                      Navigator.pushReplacementNamed(context, "/Login");
                      logger.d("link do login");
                    }),
                child: Text(
                  "Fazer login",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
