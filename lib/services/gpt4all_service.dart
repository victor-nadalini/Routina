import 'dart:convert';
import "package:http/http.dart" as http;
import 'dart:async';
import 'package:logger/logger.dart';

class GptAll4Service {

  final Logger logger = Logger();

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

  String _buildFullPrompt(List<String> tasks) {
    logger.d("recolhando informações de $tasks");
    String tasksList = tasks // exatamente aqui é convertido para string, aqui esta o problema de capturar os ids separados
        .map((task) => '"$task"')
        .join('\n');
        logger.d("recolhando informações de tasklist $tasksList");


    return """
**Instrução:**
**Você é um assistente de planejamento e sua função é gerar "Planos B" criativos e alternativos para cada tarefa.**
**Para cada tarefa da **"Lista de Tarefas"** abaixo, imagine que a tarefa original não pode ser cumprida. Sua missão é propor uma **segunda opção que seja uma alternativa prática e realista para alcançar o mesmo objetivo final da tarefa original.**

**É crucial que o Plano B seja diferente da tarefa original e que seja uma verdadeira alternativa.**
**O "Plano B" deve ser apresentado como um novo título de tarefa, curto e direto, em português do Brasil.**

**Exemplos para te guiar:**
**- Se a tarefa original é: "1. Lavar a louça à noite."**
  **O Plano B deve ser: "1. Lavar a louça na manhã seguinte." ou "1. Organizar a louça para lavar no dia seguinte."**

**- Se a tarefa original é: "2. Comprar pão na padaria da esquina."**
  **O Plano B deve ser: "2. Fazer pão caseiro." ou "2. Comprar pão no mercado."**

**- Se a tarefa original é: "3. Fazer a reunião presencial com o cliente."**
  **O Plano B deve ser: "3. Realizar a reunião online com o cliente." ou "3. Enviar e-mail com os pontos da reunião."**

**Agora, crie os Planos B para a seguinte "Lista de Tarefas":**
$tasksList

**formato da resposta:**
**1. [Plano B para a tarefa 1]**
**2. [Plano B para a tarefa 2]**
**3. [Plano B para a tarefa 3]**

**SOMENTE O TITULO DA TAREFA, NÃO MAIS NADA.**
**NÃO DE RESPOSTAS NULAS**
**LIMITE O TAMANHO DOS TITULOS DE TAREFAS A 25 CARACTERES NO MAXIMO CADA TITULO**
""";
  }
}
