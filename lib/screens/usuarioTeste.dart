import 'package:flutter/material.dart';
import 'package:routina/controllers/user_controller.dart'; // certifique-se de que esse controller tem getUsuarios()

class UsuariosTeste extends StatefulWidget {
  const UsuariosTeste({super.key});

  @override
  State<UsuariosTeste> createState() => _UsuariosTesteState();
}

class _UsuariosTesteState extends State<UsuariosTeste> {
  @override
  Widget build(BuildContext context) {
    final usuarios = UserController.getUser(); // adaptado ao seu controller

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Usuários Teste"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: usuarios.length,
          itemBuilder: (context, index) {
            final user = usuarios[index];
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "${user.nome} - ${user.email}",
                style: const TextStyle(color: Colors.white),
              ),
            );
          },
        ),
      ),
    );
  }
}
