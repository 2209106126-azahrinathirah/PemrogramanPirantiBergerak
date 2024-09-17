import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task.dart';
import '../widgets/add_new_task.dart';
import './item_text.dart';

//class untuk Satetefulwidget ListItem
class ListItem extends StatefulWidget {
  final Task task;

  ListItem(this.task);

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  // Method untuk mengubah status "done" (selesai/tidak) pada sebuah task
  void _checkItem() {
    setState(() {
      Provider.of<TaskProvider>(context, listen: false)
          .changeStatus(widget.task.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.task.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        Provider.of<TaskProvider>(context, listen: false)
            .removeTask(widget.task.id);
      },

      // Background yang muncul saat di-swipe
      background: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        alignment: Alignment.centerRight,
        color: Theme.of(context).colorScheme.error.withOpacity(0.8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
              size: 28,
            ),
            SizedBox(width: 5),
            Text(
              'DELETE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      
      // Tampilan utama task (isi dari ListItem)
      child: GestureDetector(
        onTap: _checkItem,
        child: Container(
          height: 65,
          child: Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: widget.task.isDone,
                      onChanged: (value) => _checkItem(),
                    ),
                    ItemText(
                      check: widget.task.isDone,
                      text: widget.task.description,
                      dueDate: widget.task.dueDate,
                      dueTime: widget.task.dueTime,
                    ),
                  ],
                ),

                // Jika task belum selesai, tampilkan tombol edit
                if (!widget.task.isDone)
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (_) => AddNewTask(
                          id: widget.task.id,
                          isEditMode: true,
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
