class Task {
  final String id;
  final String titulo;
  bool concluida;

  Task({
    required this.id,
    required this.titulo, 
    this.concluida = false
     });
}
