import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/task.dart';

// Stateful widget untuk menambahkan atau mengedit task
class AddNewTask extends StatefulWidget {
  final String? id; // Nullable
  final bool isEditMode;

  AddNewTask({
    this.id,
    required this.isEditMode,
  });

  @override
  _AddNewTaskState createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  Task? task;
  TimeOfDay? _selectedTime;
  DateTime? _selectedDate;
  String? _inputDescription;
  final _formKey = GlobalKey<FormState>();

  // Fungsi untuk memilih tanggal menggunakan date picker.
  void _pickUserDueDate() {
    showDatePicker(
      context: context,
      initialDate: widget.isEditMode ? (_selectedDate ?? DateTime.now()) : DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    ).then((date) {
      if (date == null) return;
      setState(() {
        _selectedDate = date;
      });
    });
  }

  // Fungsi untuk memilih waktu menggunakan time picker.
  void _pickUserDueTime() {
    showTimePicker(
      context: context,
      initialTime: widget.isEditMode ? (_selectedTime ?? TimeOfDay.now()) : TimeOfDay.now(),
    ).then((time) {
      if (time == null) return;
      setState(() {
        _selectedTime = time;
      });
    });
  }

// Fungsi untuk validasi form dan menyimpan atau mengedit task
void _validateForm() {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();
    
    // Jika waktu jatuh tempo tidak dipilih, atur ke waktu sekarang
    final selectedTime = _selectedTime ?? TimeOfDay.now();

    if (_selectedDate == null && _selectedTime != null) {
      _selectedDate = DateTime.now();
    }

    // Buat objek Task baru.
    final task = Task(
      id: widget.isEditMode ? this.task!.id : DateTime.now().toString(),
      description: _inputDescription!,
      dueDate: _selectedDate ?? DateTime.now(), // Gunakan nilai default jika null
      dueTime: selectedTime, // Gunakan nilai default jika null
    );

    if (!widget.isEditMode) {
      Provider.of<TaskProvider>(context, listen: false).createNewTask(task);
    } else {
      Provider.of<TaskProvider>(context, listen: false).editTask(task);
    }
    Navigator.of(context).pop();
  }
}


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Title', style: Theme.of(context).textTheme.titleMedium), 

            // TextFormField untuk input deskripsi tugas.
            TextFormField(
              initialValue: _inputDescription ?? '',
              decoration: InputDecoration(hintText: 'Describe your task'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onSaved: (value) {
                _inputDescription = value;
              },
            ),
            SizedBox(height: 20),
            Text('Due date', style: Theme.of(context).textTheme.titleMedium), 

            // TextFormField untuk memilih tanggal jatuh tempo menggunakan date picker
            TextFormField(
              onTap: _pickUserDueDate,
              readOnly: true,
              decoration: InputDecoration(
                hintText: _selectedDate == null
                    ? 'Provide your due date'
                    : DateFormat.yMMMd().format(_selectedDate!).toString(),
              ),
            ),
            SizedBox(height: 20),
            Text('Due time', style: Theme.of(context).textTheme.titleMedium), // subtitle -> subtitle1
            TextFormField(
              onTap: _pickUserDueTime,
              readOnly: true,
              decoration: InputDecoration(
                hintText: _selectedTime == null
                    ? 'Provide your due time'
                    : _selectedTime!.format(context),
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: TextButton( // FlatButton -> TextButton
                child: Text(
                  !widget.isEditMode ? 'ADD TASK' : 'EDIT TASK',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontFamily: 'Lato',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: _validateForm,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
