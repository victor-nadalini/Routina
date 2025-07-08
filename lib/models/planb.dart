import 'package:hive/hive.dart';

part 'planB.g.dart';

@HiveType(typeId: 4) // type id é o cpf, rg, identificação da classe no programa

class Planb extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String titulo; 

  Planb ({
    required this.id,
    required this.titulo
  });
}