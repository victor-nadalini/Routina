import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:routina/controllers/task_controller.dart';
import 'package:intl/intl.dart';// ignore: unused_import
import 'package:routina/controllers/plan_b_controller.dart';
import 'package:provider/provider.dart';
import 'package:routina/models/task.dart';

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
  bool mostrarConcluidaPlanob = false;
  DateTime date = DateTime.now();
  late String dateFormat = DateFormat(
    'EEE, dd MMM yyyy',
    'pt_BR',
  ).format(date);
  

  final double _bottomSheetHeight = 60.0 + 16.0 + 33.0 + 60.0;

  void _showPlanBPresentationDialog(String planoBContent) { // somente durante o desenvolvimento
  showDialog(
    context: context, // 'context' está disponível dentro do State
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Seu Plano B:'), // Título do pop-up
        content: SingleChildScrollView(
          // Permite rolagem se o texto do plano B for muito longo
          child: Text(
            planoBContent, // Conteúdo do plano B que você passou
            style: const TextStyle(fontSize: 16),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Entendi'), // Botão para fechar o pop-up
            onPressed: () {
              Navigator.of(context).pop(); // Fecha o pop-up
            },
          ),
        ],
      );
    },
  );
}

  @override
  
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
        
    final planBController = Provider.of<PlanBController>(context);
    
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Builder(
          builder: (context) {
            return IconButton(
              color: Colors.blueAccent,
              icon: const Icon(Icons.menu, size: 25),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.black),
              child: Text(
                "Victor Nadalini",
                style: TextStyle(color: Colors.blueAccent),
              ),
            ),
            ListTile(
              title: const Text("Configurações"),
              textColor: Colors.blueAccent,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("Perfil"),
              textColor: Colors.blueAccent,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("Login"),
              textColor: Colors.blueAccent,
              onTap: () {
                Navigator.pushReplacementNamed(context, '/change');
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        //padding: EdgeInsets.all(40),
        child: Container(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: _bottomSheetHeight + 16,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // adicionar um subtexto com data e hora de baixo de routina
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Routina",
                      style: TextStyle(color: Colors.blueAccent, fontSize: 30),
                    ),
                    Text(
                      dateFormat, // adicionar a data em tempo real
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),

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
                    child: Container(
                      width: 340,
                      height: 73,
                      margin: EdgeInsets.only(top: 11),
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
                              controller: TextEditingController(
                                text: tarefa.titulo,
                              ),
                              onSubmitted: (newTitle) {
                                setState(() {
                                  logger.d("update realizado");
                                  _taskController.updateTaskAtivas(
                                    index,
                                    newTitle,
                                  );
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
              Row( 
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        if (mostrarConcluidaPlanob == false) {
                        mostrarConcluida = !mostrarConcluida;
                        logger.d("mostrar concluídas: $mostrarConcluida");
                        }
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          "Concluídas",
                          style: TextStyle(color: Colors.blueAccent),
                        ),

                        SizedBox(width: 1),
                        Icon(
                          mostrarConcluida
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: Colors.blueAccent,
                        ),
                      ]
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      setState(() {
                        if (mostrarConcluida == false) {
                        mostrarConcluidaPlanob = !mostrarConcluidaPlanob;
                        logger.d("lista do plano b");
                        }
                      });
                    },
                    child: Row(
                      children: [
                        Text("Plano B", style: TextStyle(color: Colors.blueAccent)),
                        SizedBox(width: 1),
                        Icon(
                          mostrarConcluidaPlanob
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: Colors.blueAccent,
                        ),
                      ],
                    ),
                  ),
                ],
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
                                controller: TextEditingController(
                                  text: tarefa.titulo,
                                ),
                                onSubmitted: (newTitle) {
                                  setState(() {
                                    logger.d("update realizado");
                                    _taskController.updateTaskConcluidas(
                                      index,
                                      newTitle,
                                    );
                                  });
                                },

                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),

                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Colors.blueAccent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      bottomSheet: Container(
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.only(bottom: 60),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: planBController.isLoading ? null : () async {
                  final List<Task> titulos = TaskController().tarefasAtivas; 
                  final List<String> tarefasEnviar = titulos.map((task) => task.titulo).toList();

                          if (tarefasEnviar.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Adicione tarefas antes de gerar o Plano B.",
                                ),
                              ),
                            );
                            return;
                          }
                         await planBController.gerarPlanoB(tarefasEnviar);

                         if (planBController.ganeratedPlanoBs != null) {
                          _showPlanBPresentationDialog(planBController.ganeratedPlanoBs!); // so em desenvolvimento 
                         }
                        }, 
                        

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                        child: planBController.isLoading
                        ? const CircularProgressIndicator(color: Colors.blueAccent)
                        : const Text("PLANO B", style: TextStyle(color: Colors.black, fontSize: 15)),
              ),

              if (planBController.errorMessage != null && !planBController.isLoading) // so em desenvolvimento
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Erro: ${planBController.errorMessage!}',
                style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),

              SizedBox(height: 16),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 33,
                  width: 251,
                  child: TextField(
                    textAlign: TextAlign.left,
                    controller: _controller,
                    onTap: () {
                      setState(() {
                        logger.d("input limbo digite");
                        clicouNoCampo = true;
                      });
                    },
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 0),
                        child: Icon(
                          Icons.radio_button_unchecked,
                          color: Colors.blueAccent,
                          size: 20,
                        ),
                      ),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                      contentPadding: EdgeInsets.only(left: 0),
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
                      if (inputNovaTarefa.trim().isEmpty) {
                        return;
                      }
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
