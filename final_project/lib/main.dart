import 'package:final_project/pages/auth/controller/auth_provider.dart';
import 'package:final_project/pages/auth/login_screen.dart';
import 'package:final_project/pages/tasks/controller/tasks_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'database/database.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await DBHelper().createDataBase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return AuthProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return TasksProvider();
          },
        ),
      ],
      child: MaterialApp(
        title: 'Task App',
        theme: ThemeData(
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
