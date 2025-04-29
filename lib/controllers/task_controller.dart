import 'package:routina/models/task.dart';
import 'package:uuid/uuid.dart';


class TaskController {
  List<Task> tarefasAtivas = [];
  List<Task> tarefasConcluidas = [];
  final _uuid = Uuid();

  void adicionarTarefa(String titulo) {
    Task novaTarefa = Task(titulo: titulo, id: _uuid.v4());
    tarefasAtivas.add(novaTarefa);
  }

  void concluirTarefa(int index) {
    if (index >= 0 && index < tarefasAtivas.length) {
      tarefasAtivas[index].concluida = true;

      var tarefa = tarefasAtivas[index];

      tarefasAtivas.removeAt(index);

      tarefasConcluidas.add(tarefa);
    }
  }

  void deleteTaskAtiva(int index) {
    if (index >= 0 && index < tarefasAtivas.length) {
      tarefasAtivas.removeAt(index);
    }
  }

  void deleteTaskConcluidas(int index) {
    if (index >= 0 && index < tarefasConcluidas.length) {
      tarefasConcluidas.removeAt(index);
    }
  }

  Map<String, List<Task>> getTarefasSeparadas() {
  return {
    'ativas': tarefasAtivas,
    'concluidas': tarefasConcluidas,
  };
}
}
