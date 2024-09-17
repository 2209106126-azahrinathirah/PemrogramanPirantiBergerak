import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task.dart';
import './list_item.dart';

// Widget class StatelessWidget dari semua ListItem
class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Mengambil daftar tugas dari provider
    final taskList = Provider.of<TaskProvider>(context).itemsList;

    // Menampilkan daftar tugas jika ada, jika tidak, menampilkan pesan tidak ada tugas
    return taskList.isNotEmpty
        ? ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (context, index) {
              return ListItem(taskList[index]);
            },
          )
        : LayoutBuilder(
            builder: (ctx, constraints) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: constraints.maxHeight * 0.5,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'No tasks added yet...',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              );
            },
          );
  }
}
