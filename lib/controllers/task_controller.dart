import 'package:routina/models/task.dart';

class TaskController {
  List<Task> tarefas = [];

  void adicionarTarefa(String titulo) {
    Task novaTarefa = Task(titulo: titulo);
    tarefas.add(novaTarefa);
  }

  void concluirTarefa(int index) {
    if (index >= 0 && index < tarefas.length) {
      tarefas[index].concluida = true;
    }
  }

  List<Task> listarTarefas() {
    return tarefas;
  }
}