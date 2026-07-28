import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:routina/controllers/task_controller.dart';
import 'package:intl/intl.dart';
import 'package:routina/controllers/plan_b_controller.dart';
import 'package:provider/provider.dart';
import 'package:routina/models/listTasks.dart';
import 'package:routina/models/task.dart';
import 'package:routina/controllers/list_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TaskController _taskController = TaskController();
  final ListTasksController _listTasksController = ListTasksController();
  final logger = Logger();
  final TextEditingController _controller = TextEditingController();
  bool clicouNoCampo = false;
  bool clicouNoCampoAdicionarLista = false;
  bool mostrarConcluida = false;
  bool mostrarPlanob = false;
  DateTime date = DateTime.now();
  var tituloExibido = "Routina";
  late String dateFormat = DateFormat('EEE, dd MMM yyyy', 'pt_BR').format(date);

  final double _bottomSheetHeight = 60.0 + 16.0 + 33.0 + 60.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final planBController = Provider.of<PlanBController>(context);
    final args = ModalRoute.of(context)?.settings.arguments;
    final String tituloExibido = (args as String?) ?? "Routina";

    final Listtasks listaFiltrada = _listTasksController.buscarListaPorId(
      tituloExibido,
    );

    final List tarefasParaExibir =
        (tituloExibido == "Routina" || listaFiltrada.id == "erro_404")
            ? TaskController.taskBoxAtivas.values.toList()
            : listaFiltrada.tarefas; // testar de noite parece que funcionar

    final List tarefasParaExibirConcluidas =
        (tituloExibido == "Routina" || listaFiltrada.id == "erro_404")
            ? TaskController.taskBoxConcluidas.values.toList()
            : listaFiltrada.tarefas;

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
        child: Column(
          children: [
            Padding(padding: EdgeInsetsGeometry.directional(top: 60)),
            ListTile(
              title: const Text("Victor Nadalini"),
              textColor: Colors.blueAccent,
              onTap: () {
                Navigator.pop(context);
              },
            ),

            Container(
              height: 1,
              width: double.infinity,
              color: Colors.blueAccent,
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
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.blueAccent,
            ),
            ListTile(
              title: const Text("Minha lista"),
              textColor: Colors.blueAccent,
              onTap: () {
                Navigator.pushReplacementNamed(context, '/kanban');
              },
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.blueAccent,
            ),

            Expanded(
              child: ValueListenableBuilder(
                valueListenable: Hive.box<Listtasks>('listtasks').listenable(),
                builder: (context, Box<Listtasks> box, _) {
                  if (box.isEmpty) {
                    return const Center(
                      child: Text("nenhuma lista foi encontrada"),
                    );
                  }
                  final listas = box.values.toList();

                  return ListView.builder(
                    // aqui é onde as listas são contruidas onde posso adicionar o apagar
                    padding: EdgeInsets.all(0),
                    itemCount: listas.length,
                    itemBuilder: (context, index) {
                      final lista = listas[index];

                      return Dismissible(
                        key: Key(lista.id),
                        background: Container(
                          margin: EdgeInsets.only(top: 11),
                          color: Colors.blueAccent,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 20),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          setState(() {
                            _listTasksController.deletarSublistas(lista);
                          });
                        },

                        child: ListTile(
                          title: Text(lista.titulo),
                          textColor: Colors.blueAccent,
                          onTap: () {
                            logger.d("Navegando ate a lista ${lista.titulo}");

                            Navigator.pushNamed(
                              context,
                              '/kanban',
                              arguments:
                                  lista
                                      .titulo, // o problema dos titulos iguais vou resolver igual o to do toda vez que um titulo igual for criando sera adicionado (1) nele
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            TextField(
              controller: _controller,
              style: const TextStyle(color: Colors.blueAccent),
              onTap: () {
                setState(() {
                  logger.d("input limbo digite");
                  clicouNoCampoAdicionarLista = true;
                });
              },
              decoration: InputDecoration(
                hintText:
                    clicouNoCampoAdicionarLista ? 'Nova lista' : "+ Nova lista",
                hintStyle: const TextStyle(color: Colors.blueAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.black,
              ),
              onSubmitted: (String titulo) {
                setState(() {
                  if (titulo.isNotEmpty) {
                    _listTasksController.addTaskList(titulo);
                    _controller.clear();
                    clicouNoCampoAdicionarLista = false;
                  } else {
                    _controller.clear();
                    clicouNoCampoAdicionarLista = false;
                  }
                });
                logger.d("lista adicionada com sucesso $titulo");
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // este é um botão para uso esclusivo de desenvolvimento logo pensaremos em uma solução futura melhor
        backgroundColor: Colors.redAccent,
        child: const Icon(Icons.delete_sweep, color: Colors.white),
        onPressed: () {
          showDialog(
            context: context,
            builder:
                (context) => AlertDialog(
                  title: const Text("Limpar TUDO?"),
                  content: const Text(
                    "Isso vai apagar todas as listas do Routina para teste.",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancelar"),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _listTasksController.deleteAllLists();
                        });
                        Navigator.pop(context);
                        logger.d("Database resetada para testes.");
                      },
                      child: const Text(
                        "APAGAR TUDO",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
          );
        },
      ),
      body: SingleChildScrollView(
        //padding: EdgeInsets.all(40),
        child: Container(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: _bottomSheetHeight + 60,
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
                      tituloExibido,
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

                itemCount: tarefasParaExibir.length,
                itemBuilder: (context, index) {
                  var tarefa = tarefasParaExibir[index];
                  return Dismissible(
                    key: Key(tarefa.id),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      setState(() {
                        tarefasParaExibir.removeAt(index);

                        if (tituloExibido == "Routina") {
                          _taskController.deleteTaskAtiva(index);
                          logger.d("deletada tarefa $index");
                          logger.d(
                            "esta tarefa foi deletada no if de Routina $tituloExibido",
                          );
                        } else {
                          listaFiltrada.tarefas.removeWhere(
                            (t) => t.id == tarefa.id,
                          );
                          listaFiltrada
                              .save(); // Salva a sublista sem a tarefa deletada
                        }
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Tarefa removida")),
                      );
                    },

                    background: Container(
                      margin: EdgeInsets.only(top: 11),
                      color: Colors.blueAccent,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    child: Container(
                      width: 340,
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
                              maxLines: 5,
                              minLines: 1,

                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.text,

                              controller: TextEditingController(
                                text: tarefa.titulo,
                              ),
                              onSubmitted: (newTitle) {
                                setState(() {
                                  if (tituloExibido == "Routina") {
                                    logger.d("update realizado");
                                    _taskController.updateTaskAtivas(
                                      index,
                                      newTitle,
                                    );
                                  } else {
                                    logger.d("update realizado nas sublistas");
                                    _listTasksController.updateTask(
                                      idDaLista: tituloExibido,
                                      idDaTarefa: tarefa.id,
                                      novoTitulo: newTitle,
                                    );
                                    listaFiltrada.save();
                                  }
                                });
                                FocusScope.of(context).unfocus();
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
                        if (mostrarPlanob == false) {
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
                      ],
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      setState(() {
                        if (mostrarConcluida == false) {
                          mostrarPlanob = !mostrarPlanob;
                          logger.d("lista do plano b");
                        }
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          "Plano B",
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                        SizedBox(width: 1),
                        Icon(
                          mostrarPlanob
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
                  itemCount: tarefasParaExibirConcluidas.length,
                  itemBuilder: (context, index) {
                    var tarefa = tarefasParaExibirConcluidas[index];
                    return Dismissible(
                      key: Key(tarefa.id),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        setState(() {
                          if (tituloExibido == "Routina") {
                            _taskController.deleteTaskConcluidas(index);
                            logger.d("deletada tarefa $index");
                          } else {
                            logger.d(
                              "deletada tarefa da sublista concluida $index",
                            );
                          }
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Tarefa removida")),
                        );
                      },

                      background: Container(
                        margin: EdgeInsets.only(bottom: 11),
                        color: Colors.blueAccent,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 20),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),

                      child: Container(
                        width: 340,
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
                                maxLines: 5,
                                minLines: 1,

                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.text,
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
                                  FocusScope.of(context).unfocus();
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
              if (mostrarPlanob)
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: planBController.planosB.length,
                  itemBuilder: (context, index) {
                    var tarefa = planBController.planosB[index];
                    return Dismissible(
                      key: Key(tarefa.id),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        setState(() {
                          planBController.deletePlanb(index);
                          logger.d("deletada tarefa $index");
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Tarefa removida")),
                        );
                      },

                      background: Container(
                        margin: EdgeInsets.only(bottom: 11),
                        color: Colors.blueAccent,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 20),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                      child: Container(
                        width: 340,
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
                                  if (tarefa.concluida == false) {
                                    planBController.concluirPlanob(index);
                                    logger.d(
                                      "botão de conclusão de plano b clicado $mostrarPlanob",
                                    );
                                  } else if (tarefa.concluida == true) {
                                    planBController.desconcluirPlanob(index);
                                    logger.d(
                                      "botão de desconclusão de plano b clicado $mostrarPlanob",
                                    );
                                  }
                                });
                              },
                              icon: Icon(
                                tarefa.concluida
                                    ? Icons.radio_button_unchecked
                                    : Icons.check_circle,
                                color: Colors.blueAccent,
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                maxLines: 5,
                                minLines: 1,

                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.text,
                                controller: TextEditingController(
                                  text: tarefa.titulo,
                                ),
                                onSubmitted: (newTitle) {
                                  setState(() {
                                    logger.d("update realizado");
                                    planBController.updatePlanb(
                                      index,
                                      newTitle,
                                    );
                                  });
                                  FocusScope.of(context).unfocus();
                                },

                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),

                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  decoration:
                                      tarefa.concluida
                                          ? TextDecoration.none
                                          : TextDecoration.lineThrough,
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
                onPressed:
                    planBController.isLoading
                        ? null
                        : () async {
                          final List<Task> titulos =
                              TaskController().tarefasAtivas;
                          final List<String> tarefasEnviar =
                              titulos.map((task) => task.titulo).toList();

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
                        },

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                child:
                    planBController.isLoading
                        ? const CircularProgressIndicator(
                          color: Colors.blueAccent,
                        )
                        : const Text(
                          "PLANO B",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
              ),

              if (planBController.errorMessage != null &&
                  !planBController.isLoading) // so em desenvolvimento
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Erro: ${planBController.errorMessage!}',
                    style: const TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ElevatedButton(
                onPressed: () {
                  planBController.delateListPlanB();
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                ),

                child: const Text(
                  "APAGAR PLANO B",
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),

              SizedBox(height: 16),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 73,
                  width: 340,
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
                          clicouNoCampo // parei aqui fazer a logica funcionar
                              ? Icons.add
                              : Icons.radio_button_unchecked,

                          color: Colors.blueAccent,
                          size: 20,
                        ),
                      ),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                      contentPadding: EdgeInsets.only(left: 0),
                      hintText: clicouNoCampo ? '' : "Digite nova tarefa",
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
                        if (inputNovaTarefa.isNotEmpty) {
                          if (tituloExibido != "Routina") {
                            Listtasks listaAtual = _listTasksController
                                .buscarListaPorId(tituloExibido);
                            _listTasksController.addTaskInSublist(
                              inputNovaTarefa,
                              listaAtual,
                            );
                            _controller.clear();
                            clicouNoCampo = false;
                          } else {
                            _taskController.adicionarTarefa(inputNovaTarefa);
                            _controller.clear();
                            clicouNoCampo = false;
                          }
                        } else {
                          _controller.clear();
                          clicouNoCampo = false;
                        }
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
