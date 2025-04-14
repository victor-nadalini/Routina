import 'package:routina/models/task.dart';

void main() {
  try {
    print('Testando criação de Task...');
    final task = Task(titulo: "Teste");
    print('Task criada com sucesso: ${task.titulo}');
  } catch (e) {
    print('Erro ao criar Task: $e');
  }
}
