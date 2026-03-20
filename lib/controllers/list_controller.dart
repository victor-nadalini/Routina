import 'package:routina/models/listTasks.dart';
import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';

class ListTasksController {
  final Logger logger = Logger();

  static Box get listTasks => Hive.box('listtasks');

  final _uuid = Uuid();

  void addTaskList(String titulo) {
    Listtasks newList = Listtasks(
      id: _uuid.v4(),
      titulo: titulo,
      tarefas: [],
      planosB: [],
    );
    listTasks.add(newList);
    logger.d("nova lista adicionada");
  }
}
