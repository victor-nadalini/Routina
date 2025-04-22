import 'package:routina/models/task.dart';
import 'package:uuid/uuid.dart';


class TaskController {
  List<Task> tarefas = [];
  final _uuid = Uuid();

  void adicionarTarefa(String titulo) {
    Task novaTarefa = Task(titulo: titulo, id: _uuid.v4());
    tarefas.add(novaTarefa);
  }

  void concluirTarefa(int index) {
    if (index >= 0 && index < tarefasAtivas.length) {
      tarefasAtivas[index].concluida = true;
    }
  }

  void deleteTask(int index) {
    if (index >= 0 && index < tarefasAtivas.length) {
      tarefasConcluidas.removeAt(index);
    }
    if (index >= 0 && index < tarefasConcluidas.length) {
      tarefasConcluidas.removeAt(index);
    }
  }

  List<Task> listarTarefas() {
    return tarefas;
  }

  List<Task> get tarefasAtivas =>
      tarefas.where((tarefa) => !tarefa.concluida).toList();

  List<Task> get tarefasConcluidas =>
      tarefas.where((tarefa) => tarefa.concluida).toList();
}
