import 'package:flutter/material.dart';
import '../models/student.dart';
import '../models/department.dart';

class StudentItem extends StatelessWidget {
  final Student student;

  const StudentItem({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final department = departments.firstWhere(
      (d) => d.id == student.department.id,
      orElse: () => departments[0],
    );

    final backgroundColor = student.gender == Gender.male
        ? Colors.blue.shade100
        : Colors.pink.shade100;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(department.icon, color: Colors.black87),
        ),
        title: Text(
          '${student.firstName} ${student.lastName}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(
          'Оцінка: ${student.grade}',
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
