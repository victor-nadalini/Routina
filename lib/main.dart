import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/change_login.dart';
import 'package:logger/logger.dart';
import 'models/task.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:routina/controllers/plan_b_controller.dart';

void main() async {

  try {

    initializeDateFormatting('pt_BR', null).then((_) => runApp(
      ChangeNotifierProvider(create: (context) => PlanBController(),
      child: MyApp()
      )));
    
    WidgetsFlutterBinding.ensureInitialized();
    final dir = await getApplicationCacheDirectory();
    Hive.init(dir.path);

    // usar so durante o desenvolvimento
    await Hive.deleteBoxFromDisk('TasksAtivas');
    await Hive.deleteBoxFromDisk('TasksConcluidas');

    Hive.registerAdapter(TaskAdapter());

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
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/change': (context) => changeLogin(),
        '/kanban': (context) => HomeScreen(),
      },
    );
  }
}
