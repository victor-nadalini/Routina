import 'package:routina/models/listTasks.dart';
import 'package:routina/models/task.dart';
import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';


class ListTasksController {
  final Logger logger = Logger();

  List<Listtasks> taskLists = [];

  static Box<Listtasks> get listTasks => Hive.box<Listtasks>('listtasks'); // estava abrindo o open box dinoov aaqui
  final _uuid = Uuid();


  Listtasks buscarListaPorId(String tituloOuId) {
  return listTasks.values.firstWhere(
    (l) => l.titulo == tituloOuId || l.id == tituloOuId, // 👈 Procura por ambos para garantir!
    orElse: () => Listtasks(id: "erro_404", titulo: "não encontrado", tarefas: [], planosB: []),
  );
}

  void addTaskList(String titulo) {
  String tituloOriginal = titulo.trim(); 
  String tituloFinal = tituloOriginal;
  int contador = 1;

  while (listTasks.values.any((lista) => lista.titulo.toLowerCase() == tituloFinal.toLowerCase())) {
    tituloFinal = "$tituloOriginal ($contador)";
    contador++;
  }

  Listtasks newList = Listtasks(
    id: _uuid.v4(),
    titulo: tituloFinal,
    tarefas: [],
    planosB: [],
  );

  listTasks.add(newList);

  logger.d("nova lista adicionada: $tituloFinal");
}
  void addTaskInSublist(String titulo, Listtasks listaAtual) { // tarefas da lista atual serão decididas a partir das tarefas criadas nessa função
    Task novaTarefa = Task(id: _uuid.v4(), titulo: titulo);
    listaAtual.tarefas.add(novaTarefa);
    listaAtual.save();
    logger.d("Tarefa adicionada na lista: ${listaAtual.titulo}");
  }
  void deleteAllLists() {
    listTasks.clear();
  }
}
