import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:routina/services/notifications.dart';
import 'screens/home_screen.dart';
import 'screens/change_login.dart';
import 'package:logger/logger.dart';
import 'models/task.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:routina/controllers/plan_b_controller.dart';
import 'models/planb.dart';

void main() async {

  try {

    initializeDateFormatting('pt_BR', null).then((_) => runApp(
      ChangeNotifierProvider(create: (context) => PlanBController(),
      child: MyApp()
      )));
    
    WidgetsFlutterBinding.ensureInitialized();
    final dir = await getApplicationCacheDirectory();
    Hive.init(dir.path);

    await NotificationService().initNotification();

    NotificationService().agendarNotificacaoRecorrente(
      titulo: "não se esqueça de ver suas tarefas!!!", 
      corpo: "de uma olhada agora para não esquecer suas tarefas e deixar para depois",
    );

    // usar so durante o desenvolvimento
    await Hive.deleteBoxFromDisk('TasksAtivas');
    await Hive.deleteBoxFromDisk('TasksConcluidas');
    await Hive.deleteBoxFromDisk('PlanosB');

    Hive.registerAdapter(TaskAdapter()); 
    Hive.registerAdapter(PlanbAdapter());

    await Hive.openBox('PlanosB');
    await Hive.openBox('TasksAtivas');
    await Hive.openBox('TasksConcluidas');
  } catch (e) {
    final logger = Logger();
    logger.d('Error initialize App: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {   

    return MaterialApp(

      title: 'Routina',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueAccent,

        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.blueAccent,
          selectionHandleColor: Colors.blueAccent,
          selectionColor: Colors.blueAccent.withValues(alpha: 0.3),
      ),
      scaffoldBackgroundColor: Colors.black
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => changeLogin(),
        '/kanban': (context) => HomeScreen(),
      },
    );
  }
}
