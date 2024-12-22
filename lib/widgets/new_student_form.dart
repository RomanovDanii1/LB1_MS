import 'package:flutter/material.dart';
import 'package:romanov_daniil_kiuki_21_7/models/department.dart';
import '../models/student.dart';

class NewStudent extends StatefulWidget {
  final Student? student;
  final Function(Student) onSave;

  const NewStudent({Key? key, this.student, required this.onSave})
      : super(key: key);

  @override
  _NewStudentState createState() => _NewStudentState();
}

class _NewStudentState extends State<NewStudent> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  DepartmentModel _selectedDepartment = departments.first;
  Gender _selectedGender = Gender.male;
  int _grade = 1;

  @override
  void initState() {
    super.initState();
    if (widget.student != null) {
      _firstNameController.text = widget.student!.firstName;
      _lastNameController.text = widget.student!.lastName;
      _selectedDepartment = widget.student!.department;
      _selectedGender = widget.student!.gender;
      _grade = widget.student!.grade;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, top: 20),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First name'),
              ),
              TextField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Second name'),
              ),
              DropdownButtonFormField<DepartmentModel>(
                  value: _selectedDepartment,
                  items: departments.map((dept) {
                    return DropdownMenuItem(
                      value: dept,
                      child: Row(
                        children: [
                          Icon(dept.icon, color: dept.color, size: 24),
                          const SizedBox(width: 8),
                          Text(dept.name),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) => setState(() => _selectedDepartment = value!),
                  decoration: const InputDecoration(labelText: 'Факультет'),
                ),
              DropdownButtonFormField<Gender>(
                value: _selectedGender,
                items: Gender.values.map((gender) {
                  return DropdownMenuItem(
                    value: gender,
                    child: Text(gender == Gender.male ? 'Male' : 'Female'),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedGender = value!),
                decoration: const InputDecoration(labelText: 'Sex'),
              ),
              Slider(
                value: _grade.toDouble(),
                min: 1,
                max: 5,
                divisions: 4,
                label: _grade.toString(),
                onChanged: (value) => setState(() => _grade = value.toInt()),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final newStudent = Student(
                        firstName: _firstNameController.text,
                        lastName: _lastNameController.text,
                        department: _selectedDepartment,
                        grade: _grade,
                        gender: _selectedGender,
                      );
                      widget.onSave(newStudent);
                      Navigator.pop(context);
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
