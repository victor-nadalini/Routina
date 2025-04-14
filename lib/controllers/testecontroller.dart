import 'package:routina/controllers/task_controller.dart';

void main() {
  final controller = TaskController();
  
  // Adicionando algumas tarefas
  controller.adicionarTarefa("Estudar Flutter");
  controller.adicionarTarefa("Fazer exercícios");
  
  // Listando as tarefas
  print("\nTarefas cadastradas:");
  for (var tarefa in controller.listarTarefas()) {
    print("- ${tarefa.titulo}");
  }
} 