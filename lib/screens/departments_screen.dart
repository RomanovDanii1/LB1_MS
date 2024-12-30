import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/students_provider.dart';
import '../models/department.dart';
import '../widgets/department_item.dart';

class DepartmentsScreen extends ConsumerWidget {

  const DepartmentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(studentsProvider);

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Departments'),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 3 / 2,
        ),
        itemCount: departments.length,
        itemBuilder: (context, index) {
          final department = departments[index];
          final studentCount = state.studentsList
              .where((student) => student.department.id == department.id)
              .length;

          return DepartmentItem(
            department: department,
            studentCount: studentCount,
          );
        },
      ),
    );
  }
}
