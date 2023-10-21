import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/add_todo_provider.dart';
import 'package:todo_app/screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddTodoProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo List App',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.purple,
          ),
          scaffoldBackgroundColor: Colors.purple[200],
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
