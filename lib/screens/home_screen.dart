import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:routina/controllers/task_controller.dart';

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
  bool mostrarConcluida = false;

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
                itemCount: _taskController.tarefasAtivas.length,
                itemBuilder: (context, index) {
                  var tarefa = _taskController.tarefasAtivas[index];
                  return Dismissible(
                    key: Key(tarefa.id),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      setState(() {
                        _taskController.deleteTaskAtiva(index);
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
                    // rodear por um button
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
                                logger.d("cocluir tarefa");
                                logger.d("mostrar $mostrarConcluida");
                              });
                            },
                            icon: Icon(Icons.radio_button_unchecked),
                          ),
                          Expanded(
                            child: TextField(
                              controller: TextEditingController(text: tarefa.titulo),
                              onSubmitted: (newTitle) {
                                setState(() {
                                  logger.d("update realizado");
                                  _taskController.updateTaskAtivas(index, newTitle);
                                });
                              },

                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              
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
                  setState(() {
                    mostrarConcluida = !mostrarConcluida;
                    logger.d("mostrar concluídas: $mostrarConcluida");
                  });
                },
                child: Row(
                  children: [
                    Text("Concluídas", style: TextStyle(color: Colors.white)),
                    SizedBox(width: 1), // Espaço entre texto e imagem
                    Icon(
                      mostrarConcluida
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.blueAccent,
                    ),
                  ],
                ),
              ),

              if (mostrarConcluida)
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _taskController.tarefasConcluidas.length,
                  itemBuilder: (context, index) {
                    var tarefa = _taskController.tarefasConcluidas[index];
                    return Dismissible(
                      key: Key(
                        tarefa.id,
                      ), // adicionar tarefa.id.tarefasConcluidas
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        setState(() {
                          _taskController.deleteTaskConcluidas(index);
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
                                  _taskController.desconcluirTarefa(index);
                                  logger.d("tarefas ja na lista de conclusão");
                                });
                              },
                              icon: Icon(Icons.check_circle),
                            ),
                            Expanded(
                              child: TextField(
                              controller: TextEditingController(text: tarefa.titulo),
                              onSubmitted: (newTitle) {
                                setState(() {
                                  logger.d("update realizado");
                                  _taskController.updateTaskConcluidas(index, newTitle);
                                });
                              },

                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              
                              style: TextStyle(
                                color: Colors.blueAccent,
                                decoration: TextDecoration.lineThrough, 
                                decorationColor: Colors.blueAccent),
                            ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

              SizedBox(height: 16),

              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/change');
                  logger.d("gera lista de plano b");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                child: Text("PLANO B", style: TextStyle(color: Colors.white)),
              ),

              SizedBox(height: 16),

              // Campo de texto para adicionar novas tarefas
              Align(
                alignment: Alignment.bottomCenter,
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
                    onSubmitted: (String inputNovaTarefa) {
                      setState(() {
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
