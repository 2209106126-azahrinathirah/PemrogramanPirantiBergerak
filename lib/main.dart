import 'package:flutter/material.dart';
import 'package:task_project/providers/task.dart';
import 'package:provider/provider.dart';
import 'package:task_project/screens/homepage.dart';

void main() {
  runApp(TodoListApp());
}

// Widget utama aplikasi Todo List
class TodoListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Menggunakan ChangeNotifierProvider untuk menyediakan TaskProvider kepada seluruh aplikasi
    return ChangeNotifierProvider(
     create: (_) => TaskProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: Colors.yellow[700],
          ),
          fontFamily: 'Lato',
          textTheme: ThemeData.light().textTheme.copyWith(
                titleLarge: TextStyle(
                  color: Colors.purple,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
                titleMedium: TextStyle(
                  color: Colors.purple,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.purple,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontFamily: 'Lato',
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: 'To Do List', // Menetapkan judul aplikasi yang ditampilkan di bilah tugas.
        home: Homepage(), // Menetapkan Homepage sebagai widget yang ditampilkan di layar utama.
      ),
    );
  }
}
