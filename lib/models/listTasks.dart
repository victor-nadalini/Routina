import 'package:hive/hive.dart';
import 'package:routina/models/task.dart';

class Listtasks extends HiveObject {
  String id; 
  String titulo; 
  List<Task> tarefas; 

  Listtasks ({
    required this.id, 
    required this.titulo,
    required this.tarefas
  });
}