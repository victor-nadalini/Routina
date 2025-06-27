import 'package:routina/models/task.dart';
import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';

class TaskController {
  static Box get taskBoxAtivas => Hive.box(
    'TasksAtivas',
  ); // terei que substituir em teoria apenas as duas listas por tabelhas do hive static Box get taskBoxAtivas => Hive.box('tasks_ativas');
  static Box get taskBoxConcluidas => Hive.box(
    'TasksConcluidas',
  ); //   static Box get taskBoxConcluidas => Hive.box('tasks_concluidas');
  final _uuid = Uuid();

  List<Task> get tarefasAtivas {
    return taskBoxAtivas.values.cast<Task>().toList();
  }

  List<Task> get tarefasConcluidas {
    return taskBoxConcluidas.values.cast<Task>().toList();
  }

  void adicionarTarefa(String titulo) {
    Task novaTarefa = Task(titulo: titulo, id: _uuid.v4());
    taskBoxAtivas.add(novaTarefa);
  }

  void concluirTarefa(int index) {
    if (index >= 0 && index < taskBoxAtivas.length) {
      final tarefa = taskBoxAtivas.getAt(index);
      if (tarefa != null) {
        
        final novaTarefa = Task(
          id: tarefa.id,
          titulo: tarefa.titulo,
          concluida: true,
        );

        taskBoxConcluidas.add(novaTarefa);
        taskBoxAtivas.deleteAt(index);
      }
    }
  }

  void desconcluirTarefa(int index) {
    if (index >= 0 && index < taskBoxConcluidas.length) {
      final tarefa = taskBoxConcluidas.getAt(index);
      if (tarefa != null) {

        final novaTarefa = Task(
          id: tarefa.id,
          titulo: tarefa.titulo,
          concluida: true,
        );

        taskBoxAtivas.add(novaTarefa);
        taskBoxConcluidas.deleteAt(index);
      }
    }
  }

  void deleteTaskAtiva(int index) {
    if (index >= 0 && index < taskBoxAtivas.length) {
      taskBoxAtivas.deleteAt(index);
    }
  }

  void deleteTaskConcluidas(int index) {
    if (index >= 0 && index < taskBoxConcluidas.length) {
      taskBoxConcluidas.deleteAt(index);
    }
  }

  void updateTaskAtivas(int id, String newTitle) {
    final tarefa = taskBoxAtivas.getAt(id) as Task;

    final updateTask = Task(
      id: tarefa.id,
      titulo: newTitle,
      concluida: tarefa.concluida,
    );

    taskBoxAtivas.putAt(id, updateTask);
  }

  void updateTaskConcluidas(int id, String newTitle) {
    final tarefa = taskBoxConcluidas.getAt(id) as Task;

    final updateTask = Task(
      id: tarefa.id,
      titulo: newTitle,
      concluida: tarefa.concluida,
    );

    taskBoxConcluidas.putAt(id, updateTask);
  }
}
