import 'package:flutter/material.dart';
import 'package:romanov_daniil_kiuki_21_7/models/student.dart';

class StudentItem extends StatelessWidget {
  final Student student;

  const StudentItem({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = student.gender == Gender.male ? Colors.teal[100] : Colors.purple[100];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          '${student.firstName} ${student.lastName}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          'Grade: ${student.grade}',
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(
            departmentIcons[student.department],
            color: Colors.teal,
          ),
        ),
      ),
    );
  }
}
