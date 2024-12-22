import 'package:romanov_daniil_kiuki_21_7/models/department.dart';

class Student {
  final String firstName;
  final String lastName;
  final DepartmentModel department;
  final int grade;
  final Gender gender;

  const Student({
    required this.firstName,
    required this.lastName,
    required this.department,
    required this.grade,
    required this.gender,
  });
}

enum Gender { male, female }
