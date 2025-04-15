import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:routina/controllers/task_controller.dart';

// Transformamos em StatefulWidget para gerenciar o estado das tarefas
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// Classe que gerencia o estado da tela
class _HomeScreenState extends State<HomeScreen> {
  // Instância do controlador de tarefas que será compartilhada
  final TaskController _taskController = TaskController();
  final logger = Logger();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(40),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "SE MEU DIA",
                  style: TextStyle(color: Colors.blueAccent, fontSize: 30),
                ),
              ),
              SizedBox(height: 66),

              // Usando spread operator (...) com map para criar um widget para cada tarefa
              // O map converte cada tarefa em um Container personalizado
              ..._taskController
                  .listarTarefas()
                  .map(
                    (tarefa) => Container(
                      width: 340,
                      height: 73,
                      margin: EdgeInsets.only(bottom: 11),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.blueAccent),
                      ),
                      padding: EdgeInsets.all(11),
                      child: Row(
                        children: [
                          // Botão para marcar a tarefa como concluída
                          IconButton(
                            color: Colors.blueAccent,
                            onPressed: () {
                              // setState força a UI a atualizar quando o estado muda
                              setState(() {
                                // Encontra o índice da tarefa atual e marca como concluída
                                _taskController.concluirTarefa(
                                  _taskController.tarefas.indexOf(tarefa),
                                );
                              });
                            },
                            icon: Icon(Icons.radio_button_unchecked),
                            selectedIcon: SizedBox(height: 8),
                          ),
                          // Texto da tarefa que ocupa o espaço restante
                          Expanded(
                            child: Text(
                              tarefa.titulo,
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

              SizedBox(height: 16),

              ElevatedButton(
                onPressed: () {
                  logger.d("gera lista de plano b");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                child: Text("PLANO B", style: TextStyle(color: Colors.white)),
              ),

              SizedBox(height: 17),

              // Campo de texto para adicionar novas tarefas
              Center(
                child: SizedBox(
                  height: 33,
                  width: 251,
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                      hintText: "Digite nova tarefa?",
                      hintStyle: TextStyle(color: Colors.blueAccent),
                      fillColor: Colors.black,
                      contentPadding: EdgeInsets.symmetric(vertical: 6),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                    ),
                    cursorColor: Colors.blueAccent,
                    style: TextStyle(color: Colors.blueAccent),
                    // Quando o usuário pressiona Enter, adiciona a nova tarefa
                    onSubmitted: (String inputNovaTarefa) {
                      setState(() {
                        // Adiciona a tarefa ao controlador
                        _taskController.adicionarTarefa(inputNovaTarefa);
                      });
                      logger.d(
                        "tarefa adicionada com sucesso $inputNovaTarefa",

                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
