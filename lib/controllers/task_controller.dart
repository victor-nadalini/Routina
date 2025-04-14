import 'package:routina/models/task.dart';
import '../screens/home_screen.dart';


class TaskController {
  List<Task> tarefas = [];

  void adicionarTarefa(String novaTarefaInput) {
    Task novaTarefa = Task(titulo: novaTarefaInput);
    tarefas.add(novaTarefa);
  }

  void concluirTarefa(int index) {
    if (index >= 0 && index < tarefas.length) {
      tarefas[index].comcluida = true;
    }
  }

  List<Task> listarTarefas() {
    return tarefas;
  }
}
