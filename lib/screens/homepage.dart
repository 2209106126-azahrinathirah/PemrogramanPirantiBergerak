import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_project/providers/task.dart'; 
import 'package:task_project/widgets/add_new_task.dart';
import 'package:task_project/widgets/list_item.dart'; 

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
     // Membangun UI HomePage
    return Scaffold(
      appBar: AppBar(
        title: Text('TO DO LIST'),
        actions: <Widget>[
          // Menambahkan ikon profil di pojok kanan
          IconButton(
            icon: CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar.jpeg'),
            ),
            onPressed: () {
              // Aksi untuk ketika ikon profil ditekan
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // TextField untuk pencarian
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search Todos...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onChanged: (value) {
                // Implementasikan logika pencarian disini
              },
            ),
          ),
          // Expanded untuk membuat ListView di bawah pencarian agar bisa diskroll.
          Expanded(
            child: Consumer<TaskProvider>( // Gunakan Consumer untuk mendapatkan data dari TaskProvider
              builder: (ctx, taskProvider, child) => ListView.builder(
                itemCount: taskProvider.itemsList.length,
                itemBuilder: (ctx, index) => ListItem(taskProvider.itemsList[index]),
              ),
            ),
          ),
        ],
      ),
      // Tombol floating action button untuk menambah tugas baru.
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (_) => AddNewTask(isEditMode: false),
          );
        },
        tooltip: 'Add a new item!',
      ),
       // Bottom Navigation 
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        onTap: (index) {
          // Implementasikan aksi saat navigasi ditekan
        },
      ),
    );
  }
}
