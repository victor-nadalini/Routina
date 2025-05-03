import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/change_login.dart';
import 'screens/login.dart';
import 'screens/register.dart';
import 'screens/usuario_teste.dart';
import 'package:logger/logger.dart';
import 'models/task.dart';

void main() async {
  try {
  runApp(const MyApp());


  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationCacheDirectory();
  Hive.init(dir.path);

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
        '/Login': (context) => Login(),
        '/RegisterUser': (context) => RegisterUserState(),
        '/kanban': (context) => HomeScreen(),
        '/testeUser': (context) => UsuariosTeste(),
      },
    );
  }
}
