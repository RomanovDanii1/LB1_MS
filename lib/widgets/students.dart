import 'package:flutter/material.dart';
import 'package:romanov_daniil_kiuki_21_7/models/student.dart';
import 'package:romanov_daniil_kiuki_21_7/widgets/student_item.dart';
import 'package:romanov_daniil_kiuki_21_7/widgets/new_student.dart';

class StudentsScreen extends StatefulWidget {
  final List<Student> students;

  const StudentsScreen({super.key, required this.students});

  @override
  _StudentsScreenState createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  List<Student> _studentsList = [];

  @override
  void initState() {
    super.initState();
    _studentsList = widget.students;
  }

  void _addOrEditStudent({Student? student}) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return NewStudent(
          student: student,
          onSave: (newStudent) {
            setState(() {
              if (student != null) {
                final index = _studentsList.indexOf(student);
                _studentsList[index] = newStudent;
              } else {
                _studentsList.add(newStudent);
              }
            });
          },
        );
      },
    );
  }

  void _deleteStudent(int index) {
    final deletedStudent = _studentsList[index];
    setState(() {
      _studentsList.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${deletedStudent.firstName} deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () => setState(() => _studentsList.insert(index, deletedStudent)),
        ),
      ),
    );
  }

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
        itemCount: _studentsList.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: ValueKey(_studentsList[index]),
            background: Container(color: Colors.red),
            onDismissed: (_) => _deleteStudent(index),
            child: InkWell(
              onTap: () => _addOrEditStudent(student: _studentsList[index]),
              child: StudentItem(student: _studentsList[index]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEditStudent(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
