import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/students_provider.dart';
import '../widgets/new_student_form.dart';
import '../widgets/student_item.dart';

class StudentsScreen extends ConsumerWidget {
  const StudentsScreen({super.key});

  void _addOrEditStudent(BuildContext context, WidgetRef ref,
      {int? index}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return NewStudent(studentIndex: index,);
      },
    );
  }

  void _deleteStudent(BuildContext context, WidgetRef ref, int index) {
    ref.read(studentsProvider.notifier).removeStudent(index);
    _showUndoSnackbar(context, ref);
  }

  void _showUndoSnackbar(BuildContext context, WidgetRef ref) {
    final container = ProviderScope.containerOf(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Students removed'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            container.read(studentsProvider.notifier).undoDelete();
          },
        ),
        duration: const Duration(seconds: 5),
      ),
    ).closed.then((value) {
      if (value != SnackBarClosedReason.action) {
        ref.read(studentsProvider.notifier).deleteFromServer();
      }
    });

  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(studentsProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state.msg != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              state.msg!,
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    });

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: state.studentsList.length,
        itemBuilder: (context, index) {
          final student = state.studentsList[index];
          return Dismissible(
            key: ValueKey(student),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20),
              child: const Icon(Icons.delete, color: Colors.white, size: 32),
            ),
            direction: DismissDirection.startToEnd,
            onDismissed: (_) => _deleteStudent(context, ref, index),
            child: InkWell(
              onTap: () =>
                  _addOrEditStudent(context, ref, index: index),
              child: StudentItem(student: student),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEditStudent(context, ref),
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add),
      ),
    );
  }
}
