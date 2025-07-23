import 'package:hive/hive.dart';

part 'planb.g.dart';

@HiveType(typeId: 4) // type id é o cpf, rg, identificação da classe no programa

class Planb extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String titulo; 

  @HiveField(2)
  bool concluida;

  Planb ({
    required this.id,
    required this.titulo,
    this.concluida = false
  });

  @override
  String toString() {
    return 'PlanB(id: $id, title: "$titulo", planBText: "$concluida")';
  }
}