import 'package:flutter/material.dart';
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
    listaAtual.tarefas.add(novaTarefa); // as tarefas são adicionadas na propriedade de "tarefas" pra rastrear tenho que salvar o valor da variavel em tarefas
    listaAtual.save();
    logger.d("Tarefa adicionada na lista: ${listaAtual.titulo}");
    logger.d("valor dentro de lista atual tarefas: ${listaAtual.tarefas}"); // não tem valor nenhum porque o valor so passa aexistir quando esata na tela do app la é criado aqui so ha a execução não da para eu armazernar o valor que n~çao existe numa variavel

  }
  void updateTask({
    required String idDaLista,
    required String idDaTarefa,
    required String novoTitulo
  }) {
    final Listtasks? listaCorreta = listTasks.values
      .where((lista) => lista.id == idDaLista || lista.titulo == idDaLista)
      .firstOrNull;

    if(listaCorreta != null) {
      final Task? tarefaParaAtualizar = listaCorreta.tarefas
        .where((t) => t.id == idDaTarefa)
        .firstOrNull;

      if (tarefaParaAtualizar != null) {
        tarefaParaAtualizar.titulo = novoTitulo;

        listaCorreta.save();

        logger.d("tarefa atualizada com sucesso $novoTitulo");
      } else {
        logger.e("Tarefa não encontrada dentro da sublista.");
      }
    } else {
      logger.e("Sublista não encontrada.");
    }
  }
  void deleteAllLists() {
    listTasks.clear();
  }
}
