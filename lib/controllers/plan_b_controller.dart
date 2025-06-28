import 'package:routina/services/gpt4all_service.dart';
import 'package:logger/logger.dart';
import 'package:flutter/foundation.dart';

class PlanBController extends ChangeNotifier {
  final GptAll4Service _service = GptAll4Service();
  final logger = Logger();

  // values to be observed 
  String? _generatedPlanoBs; 
  bool _isLoading = false; 
  String? _errorMesage;

  // Getters for get elements for work to UI 
  String? get ganeratedPlanoBs => _generatedPlanoBs;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMesage;
  
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
      _generatedPlanoBs = resultado; 
      
    } catch (e) {
    _errorMesage = "Erro ao criar plano b $e.toString()";
    logger.d("erro ao criar plano b");
    } finally {
      _isLoading = false;
      notifyListeners(); 
    }
  }
}