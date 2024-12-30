import 'package:flutter/material.dart';

class DepartmentModel {
  final String id;
  final String name;
  final IconData icon;
  final Color color; 

  const DepartmentModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.color, 
  });
}

const List<DepartmentModel> departments = [
  DepartmentModel(
    id: 'finance',
    name: 'Finance',
    icon: Icons.attach_money,
    color: Colors.green, 
  ),
  DepartmentModel(
    id: 'law',
    name: 'Law',
    icon: Icons.gavel,
    color: Colors.blue,
  ),
  DepartmentModel(
    id: 'it',
    name: 'IT',
    icon: Icons.computer,
    color: Colors.orange,
  ),
  DepartmentModel(
    id: 'medical',
    name: 'Medical',
    icon: Icons.local_hospital,
    color: Colors.red,
  ),
];
