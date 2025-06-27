import 'dart:convert';
import "package:http/http.dart" as http;
import 'dart:async';

class GptAll4Service {
  Future<String> getGpt4allResponse(List<String> tarefasEnviar) async {
    final prompt = _buildFullPrompt(tarefasEnviar);
    final response = await http.post(
      Uri.parse('http://10.0.2.2:4891/v1/completions'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "model": "Meta-Llama-3-8B-Instruct.Q4_0.gguf",
        "prompt": prompt,
        "max_tokens": 200,
        "temperature": 0.5,
        "stream": false,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data['choices'][0]['text']; 
    } else {

      final String errorMessage =
          jsonDecode(response.body)['error'] ?? 'Erro desconhecido';
      throw Exception(
        "Erro ao buscar plano B: ${response.statusCode} - $errorMessage",
      );
    }
  }

// em observação 
  String _buildFullPrompt(List<String> tasks) {
    String tasksList = tasks
        .map((task) => '"$task"')
        .join('\n');

    return """
**Instrução:**
Você é um assistente de planejamento. Para cada tarefa da lista, forneça um "Plano B", deve ser somente o titulo da tarefa (em portugues do brasil) (não fale nada amais alem dos tirulos preciso somente dos titulos e nada mais)

**Lista de Tarefas:**
$tasksList

formato da resposta: 1.
                     2.
""";
  }
}
