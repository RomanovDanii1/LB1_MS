import 'package:flutter/material.dart';
import 'package:romanov_daniil_kiuki_21_7/models/student.dart';
import 'package:romanov_daniil_kiuki_21_7/widgets/student_item.dart';

class StudentsScreen extends StatelessWidget {
  final List<Student> students;

  const StudentsScreen({super.key, required this.students});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Our Students', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.tealAccent,
        elevation: 4,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: students.length,
        itemBuilder: (context, index) {
          return StudentItem(student: students[index]);
        },
      ),
    );
  }
}
