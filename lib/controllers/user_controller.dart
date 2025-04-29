import 'package:routina/models/user.dart';
import 'package:uuid/uuid.dart';

class UserController {
  List<User> usuarios = [];
  final _uuid = Uuid();


  void adicionarUsuario (String name, email, senha, confirmarSenha, id ) {
    User novoUsuario = User(nome: name, email:email, senha:senha, confirmarSenha: confirmarSenha, id: _uuid.v4(), dateRetister: DateTime.now());
    usuarios.add(novoUsuario);
  }

  List<User> getUser() {
    return usuarios;
  }

}
