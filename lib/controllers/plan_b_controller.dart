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

      String resultado = await _service.getGpt4allResponse(tarefasEnviar);
      List<String>? generatedPlanoBs = extrairTarefasDoPlanoB(resultado) as List<String>?;
      logger.d("informaçoes sobre plano b gerado $generatedPlanoBs");
      logger.d("plano 1 ${generatedPlanoBs?[0]} plano 2 ${generatedPlanoBs?[1]} plano 3 ${generatedPlanoBs?[2]}");


      for (int p = 0; p < generatedPlanoBs!.length; p++) {
        
        logger.d("loop de genrate esta mostrando o que $generatedPlanoBs"); // entra aqui como valor list
        String planoBgerado = generatedPlanoBs[p]; // o problema esta exatamente aqui, acho que por p ser um int deve ter algum problema passando por generete plans b a saida de é somente um t
        logger.d("o que esta mostrando no plano b gerado com generate ${planoBgerado[p]}"); // saida: o que esta mostrando no plano b gerado com generate t
        Planb planb = Planb(id: _uuid.v4(), titulo: planoBgerado);
        logger.d("esta sendo criando plan b $planb");
        planosB.add(planb);
        logger.d("a tabela é atualizada ? $planosB");

      }

      logger.d("tem alguma na tabela planos b $planosB");
      
    } catch (e) {
      _errorMesage = "Erro ao criar plano b $e.toString()";
      logger.d("erro ao criar plano b $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
