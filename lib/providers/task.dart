import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class Task {
  final String id;
  String description;
  DateTime dueDate;
  TimeOfDay dueTime;
  bool isDone;

  // Konstruktor untuk inisialisasi properti Task.
  Task({
    required this.id,
    required this.description,
    required this.dueDate,
    required this.dueTime,
    this.isDone = false,
  });

  get title => null;
}

class TaskProvider with ChangeNotifier {
  // Getter untuk mengambil daftar tugas (to-do list).
  List<Task> get itemsList {
    return _toDoList;
  }

  // Daftar privat yang berisi objek Task.
  final List<Task> _toDoList = [
     // Inisialisasi contoh task
    Task(
      id: 'task#1',
      description: 'Tugas Mobile',
      dueDate: DateTime.now(),
      dueTime: TimeOfDay.now(),
    ),
    Task(
      id: 'task#2',
      description: 'Tugas Grafika Komputer',
      dueDate: DateTime.now(),
      dueTime: TimeOfDay.now(),
    ),
  ];

  Task getById(String id) {
    return _toDoList.firstWhere((task) => task.id == id);
  }

  // Method untuk menambahkan task baru ke dalam list.
  void createNewTask(Task task) {
    final newTask = Task(
      id: task.id,
      description: task.description,
      dueDate: task.dueDate,
      dueTime: task.dueTime,
    );
    _toDoList.add(newTask);
    notifyListeners();
  }

  void editTask(Task task) {
    removeTask(task.id);
    createNewTask(task);

  }

// Method untuk menghapus task berdasarkan ID.
  void removeTask(String id) {
    _toDoList.removeWhere((task) => task.id == id);
    notifyListeners();
  }

   // Method untuk mengubah status task (selesai atau belum selesai).
  void changeStatus(String id) {
    int index = _toDoList.indexWhere((task) => task.id == id);
    _toDoList[index].isDone = !_toDoList[index].isDone;
    print('PROVIDER ${_toDoList[index].isDone.toString()}');
  }
}
