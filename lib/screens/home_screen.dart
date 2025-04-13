import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              // lista de tarefas:
              Container(
                width: 340,
                height: 73,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.blueAccent),
                ),

                padding: EdgeInsets.all(11),

                child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  color: Colors.blueAccent,
                  onPressed: () {
                    logger.d("concluir tarefa");
                  },
                  icon: Icon(Icons.radio_button_unchecked),
                ),
              ),
            ),

              SizedBox(height: 10),

              Container(
                width: 340,
                height: 73,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.blueAccent),
                ),

                padding: EdgeInsets.all(8),

                child: Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    color: Colors.blueAccent,
                    onPressed: () {
                      logger.d("concluir tarefa");
                    },
                    icon: Icon(Icons.radio_button_unchecked),
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

              SizedBox(height: 10),

              ElevatedButton(
                onPressed: () {
                  logger.d("GERA NOVA TAREFA");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  side: BorderSide(color: Colors.blueAccent, width: 1),
                ),
                child: Text(
                  "NOVA TAREFA",
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
