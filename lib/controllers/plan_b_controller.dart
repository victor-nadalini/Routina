import 'package:flutter/material.dart';
import 'package:routina/services/gpt4all_service.dart';
import 'package:logger/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:routina/models/planb.dart';

class PlanBController extends ChangeNotifier {
  final GptAll4Service _service = GptAll4Service();
  final logger = Logger();
  // ignore: unused_field
  final _uuid = Uuid();

  static Box get planosb => Hive.box('PlanosB');

  Future<void> delateListPlanB() async {
    await planosb.clear();
    notifyListeners();
    logger.d("Todos os Planos B foram apagados da Box.");
  }

  List<Planb> get planosB {
    return planosb.values.cast<Planb>().toList();
  }

  // values to be observed
  String? _generatedPlanoBs;
  bool _isLoading = false;
  String? _errorMesage;

  // Getters for get elements for work to UI
  String? get ganeratedPlanoBs => _generatedPlanoBs;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMesage;

  List<String> extrairTarefasDoPlanoB(String planoB) {
    final regex = RegExp(r'^\s*\d+\.\s*(.+)$', multiLine: true);

    final Iterable<RegExpMatch> correspondencias = regex.allMatches(planoB);

    if (correspondencias.isEmpty) {
      logger.d("nenhuma linha com indice foi encontrada nesse texto");
    }

    logger.d("conteudo das linhas:");
    for (final Match match in correspondencias) {
      logger.d(match.group(1));
    }
    return correspondencias.map((match) => match.group(1)!).toList();
  }

  Future<void> gerarPlanoB(List<String> tarefasEnviar) async {
    _isLoading = true;
    _errorMesage = null;
    _generatedPlanoBs = null;
    notifyListeners();

    try {
      if (tarefasEnviar.isEmpty) {
        _errorMesage = ("Por favor, adicione tarefas para gerar o plano B.");
        notifyListeners();
        return;
      }

       if (planosb.isNotEmpty) {
      logger.d("Plano B existente detectado. Apagando antes de gerar um novo.");
      await delateListPlanB(); // Chama o método para limpar a Box
    }

      String resultado = await _service.getGpt4allResponse(tarefasEnviar);
      List<String>? generatedPlanoBs =
          extrairTarefasDoPlanoB(resultado) as List<String>?;
      logger.d("RESPOSTA BRUTA DA IA RECEBIDA:\n$resultado");
      logger.d("informaçoes sobre plano b gerado $generatedPlanoBs");

      logger.d("loop de genrate esta mostrando o que $generatedPlanoBs");

      for (String titulo in generatedPlanoBs!) {
        Planb planb = Planb(id: _uuid.v4(), titulo: titulo, concluida: true); // não faz o menor sentido, rever isso depois com tempo
        logger.d("o que tem no titulo plano b gerado $titulo");
        planosb.add(planb);
      }

      logger.d("a tabela é atualizada ? ${planosb.values.toList()}");

      logger.d("a tabela é atualizada ? Número de itens: ${planosb.length}");

      logger.d(
        "a tabela é atualizada ? Conteúdo completo: ${planosb.toMap()}",
      ); 

      logger.d("tem alguma na tabela planos b $planosB");
    } catch (e) {
      _errorMesage = "Erro ao criar plano b $e.toString()";
      logger.d("erro ao criar plano b $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void deletePlanb(int index) {
    if (index >= 0 && index < planosB.length) {
      planosb.deleteAt(index);
    }
  }

  void updatePlanb(int id, String newTitle) {
    final tarefa = planosb.getAt(id) as Planb;

    final updateTask = Planb(
      id: tarefa.id,
      titulo: newTitle,
      concluida: tarefa.concluida,
    );

    planosb.putAt(id, updateTask);
  }

  void concluirPlanob(int index) {
    if (index >= 0 && index < planosB.length) {
      final tarefa = planosb.getAt(index);
      if (tarefa != null) {
        
        final concluir = Planb(
          id: tarefa.id,
          titulo: tarefa.titulo,
          concluida: true,
        );

        planosb.putAt(index, concluir);
      }
    }
  }
  void desconcluirPlanob(int index) {
    if (index >= 0 && index < planosB.length) {
      final tarefa = planosb.getAt(index);
      if (tarefa != null) {
        
        final desconcluir = Planb(
          id: tarefa.id,
          titulo: tarefa.titulo,
          concluida: false,
        );

        planosb.putAt(index, desconcluir);
      }
    }
  }
}
