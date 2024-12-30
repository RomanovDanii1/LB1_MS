import 'package:flutter/material.dart';
import 'package:romanov_daniil_kiuki_21_7/models/department.dart';
import '../models/student.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/students_provider.dart';

class NewStudent extends ConsumerStatefulWidget {
  const NewStudent({
    super.key,
    this.studentIndex
  });

  final int? studentIndex;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewStudentState();
}

class _NewStudentState extends ConsumerState<NewStudent> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  DepartmentModel _selectedDepartment = departments.first;
  Gender _selectedGender = Gender.male;
  int _grade = 1;

  @override
  void initState() {
    super.initState();
    if (widget.studentIndex != null) {
      final student = ref.read(studentsProvider).studentsList[widget.studentIndex!];
      _firstNameController.text = student.firstName;
      _lastNameController.text = student.lastName;
      _selectedGender = student.gender;
      _selectedDepartment = student.department;
      _grade = student.grade;
    }
  }

  @override
  Widget build(BuildContext context) {
    final students = ref.watch(studentsProvider);
    if (students.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
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
                    onPressed: () async {
                      if (widget.studentIndex == null)  {
                        await ref.read(studentsProvider.notifier).addStudent(
                              _firstNameController.text.trim(),
                              _lastNameController.text.trim(),
                              _selectedDepartment,
                              _selectedGender,
                              _grade,
                            );
                      } else {
                        await ref.read(studentsProvider.notifier).editStudent(
                              widget.studentIndex!,
                              _firstNameController.text.trim(),
                              _lastNameController.text.trim(),
                              _selectedDepartment,
                              _selectedGender,
                              _grade,
                            );
                      }
                      if (!context.mounted) return;
                      Navigator.of(context).pop(); 
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
