import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 3)
class Task extends HiveObject {

  @HiveField(1)
  final String id;
  
  @HiveField(2)
  final String titulo;
  
  @HiveField(3)
  bool concluida;

  Task({
    required this.id,
    required this.titulo, 
    this.concluida = false
     });
}
