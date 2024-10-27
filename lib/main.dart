import 'package:flutter/material.dart';
import 'package:romanov_daniil_kiuki_21_7/models/student.dart';
import 'package:romanov_daniil_kiuki_21_7/widgets/students.dart';

void main() {
  List<Student> studentsList = [
    const Student(
      firstName: 'Олександра',
      lastName: 'Шевченко',
      department: Department.finance,
      grade: 5,
      gender: Gender.female,
    ),
    const Student(
      firstName: 'Максим',
      lastName: 'Коваль',
      department: Department.it,
      grade: 4,
      gender: Gender.male,
    ),
    const Student(
      firstName: 'Софія',
      lastName: 'Бондар',
      department: Department.law,
      grade: 3,
      gender: Gender.female,
    ),
    const Student(
      firstName: 'Андрій',
      lastName: 'Демченко',
      department: Department.medical,
      grade: 5,
      gender: Gender.male,
    ),
    const Student(
      firstName: 'Аліна',
      lastName: 'Захарова',
      department: Department.finance,
      grade: 4,
      gender: Gender.female,
    ),
    const Student(
      firstName: 'Дмитро',
      lastName: 'Мельник',
      department: Department.it,
      grade: 2,
      gender: Gender.male,
    ),
    const Student(
      firstName: 'Єва',
      lastName: 'Кравченко',
      department: Department.law,
      grade: 5,
      gender: Gender.female,
    ),
    const Student(
      firstName: 'Богдан',
      lastName: 'Мороз',
      department: Department.medical,
      grade: 3,
      gender: Gender.male,
    ),
    const Student(
      firstName: 'Марія',
      lastName: 'Литвин',
      department: Department.finance,
      grade: 4,
      gender: Gender.female,
    ),
    const Student(
      firstName: 'Лука',
      lastName: 'Ярошенко',
      department: Department.it,
      grade: 5,
      gender: Gender.male,
    ),
  ];

  runApp(MaterialApp(
    home: StudentsScreen(students: studentsList),
  ));
}
