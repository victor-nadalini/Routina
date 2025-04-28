class User {
  final String id;
  final String nome;
  final String email;
  final String? fotoUrl;
  final DateTime dateRetister;
  final bool modoOffline;

  User ({
    required this.id,
    required this.nome,
    required this.email,
    this.fotoUrl,
    required this.dateRetister,
    this.modoOffline = false,
  }); 
}