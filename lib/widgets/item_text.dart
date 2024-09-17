import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Menampilkan teks di dalam ListItem.
// Menampilkan tanggal jatuh tempo dan waktu jatuh tempo jika ada.

//clas untuk Statelesswidgets ItemText
class ItemText extends StatelessWidget {
  final bool check;
  final String text;
  final DateTime? dueDate; // Nullable
  final TimeOfDay? dueTime; // Nullable

  ItemText({
    required this.check,
    required this.text,
    this.dueDate,
    this.dueTime,
  });

  // Method untuk membangun teks tanggal (jika dueDate tidak null)
  Widget _buildDateText(BuildContext context) {
    return dueDate == null
        ? Container() // Tidak menampilkan apa-apa jika dueDate null
        : Text(
            DateFormat.yMMMd().format(dueDate!),
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              color: check ? Colors.grey : Theme.of(context).primaryColorDark,
            ),
          );
  }

  // Method untuk membangun teks waktu (jika dueTime tidak null)
  Widget _buildTimeText(BuildContext context) {
    return dueTime == null
        ? Container() // Tidak menampilkan apa-apa jika dueTime null
        : Text(
            dueTime!.format(context),
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              color: check ? Colors.grey : Theme.of(context).primaryColorDark,
            ),
          );
  }

  // Method untuk membangun baris teks yang menampilkan tanggal dan waktu jatuh tempo
  Widget _buildDateTimeTexts(BuildContext context) {
    if (dueDate == null && dueTime == null) {
      return Container(); // Tidak menampilkan apa-apa jika keduanya null
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        if (dueDate != null) ...[
          _buildDateText(context),
          if (dueTime != null) SizedBox(width: 10),
        ],
        if (dueTime != null) _buildTimeText(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Membuat tampilan dalam bentuk kolom
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 22,
            color: check ? Colors.grey : Colors.black,
            decoration: check ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        _buildDateTimeTexts(context),
      ],
    );
  }
}
