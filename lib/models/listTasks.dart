// ignore_for_file: file_names

import 'package:hive/hive.dart';
import 'package:routina/models/planb.dart';
import 'package:routina/models/task.dart';

part 'listTasks.g.dart'; 

@HiveType(typeId: 1)
class Listtasks extends HiveObject {
  @HiveField(0)
  String id; 
  @HiveField(1)
  String titulo;
  @HiveField(2) 
  List<Task> tarefas; 
  @HiveField(3)
  List<Planb> planosB;

  Listtasks ({
    required this.id, 
    required this.titulo,
    required this.tarefas,
    required this.planosB
  });
}