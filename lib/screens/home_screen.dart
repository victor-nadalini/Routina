// ignore_for_file: unnecessary_to_list_in_spreads, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:routina/controllers/task_controller.dart';

// Transformamos em StatefulWidget para gerenciar o estado das tarefas
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TaskController _taskController = TaskController();
  final logger = Logger();
  final TextEditingController _controller = TextEditingController();
  bool clicouNoCampo = false;

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

              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _taskController.tarefas.length,
                itemBuilder: (context, index) {
                  logger.d(
                    "Renderizando: ${_taskController.tarefas[index].titulo}",
                  );
                  // Pega a tarefa atual
                  var tarefa = _taskController.tarefas[index];

                  return Dismissible(
                    key: Key(tarefa.titulo[index]),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      setState(() {
                        _taskController.deleteTask(index);
                        logger.d("deletada tarefa $index");
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Tarefa removida")),
                      );
                    },

                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),

                    child: Container(
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
                          IconButton(
                            color: Colors.blueAccent,
                            onPressed: () {
                              setState(() {
                                _taskController.concluirTarefa(index);
                              });
                            },
                            icon: Icon(Icons.radio_button_unchecked),
                          ),
                          Expanded(
                            child: Text(
                              tarefa.titulo,
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              TextButton(
                onPressed: () {
                  logger.d("mostrar concluidas");
                },
                child: Row(
                  children: [
                    Text("Concluídas", style: TextStyle(color: Colors.white)),
                    SizedBox(width: 1), // Espaço entre texto e imagem
                   Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.blueAccent,
                   ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

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
                    textAlign: TextAlign.start,
                    controller: _controller,
                    onTap: () {
                      setState(() {
                        logger.d("input limbo digite");
                        clicouNoCampo = true;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                      contentPadding: EdgeInsets.only(left: 12),
                      hintText: clicouNoCampo ? '' : "Digite nova tarefa?",
                      hintStyle: TextStyle(color: Colors.blueAccent),
                      fillColor: Colors.black,
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
                        _controller.clear();
                        clicouNoCampo = false;
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
