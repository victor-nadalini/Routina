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

  static Box get planosb => Hive.box(
    'PlanosB'
  );

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
  
  Future<void> gerarPlanoB(List <String> tarefasEnviar) async {
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

      String resultado = await _service.getGpt4allResponse(tarefasEnviar);
      _generatedPlanoBs = extrairTarefasDoPlanoB(resultado).join("\n"); 
      logger.d("informaçoes sobre plano b gerado $_generatedPlanoBs");
      logger.d("informações na tabela $planosB");
      
    } catch (e) {
    _errorMesage = "Erro ao criar plano b $e.toString()";
    logger.d("erro ao criar plano b");
    } finally {
      _isLoading = false;
      notifyListeners(); 
    }
  }
  void createPlanB(List<String> generatedPlanoBs) {
    for (int p = 0; p <= generatedPlanoBs.length; ) {
      String planoBgerado = generatedPlanoBs[p];
    Planb planb = Planb(
      id: _uuid.v4(),
      titulo: planoBgerado
      );
    planosB.add(planb);
    break;
    }
  }
}