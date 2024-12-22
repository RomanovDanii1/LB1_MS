import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/student.dart';

class StudentsNotifier extends StateNotifier<List<Student>> {
  StudentsNotifier() : super([]);

  Student? _deletedStudent;
  int? _deletedIndex;

  void addStudent(Student student) {
    state = [...state, student];
  }

  void editStudent(Student updatedStudent, int index) {
    final updatedState = [...state];
    updatedState[index] = updatedStudent;
    state = updatedState;
  }

  void removeStudent(int index) {
    _deletedStudent = state[index];
    _deletedIndex = index;

    final updatedState = [...state];
    updatedState.removeAt(index);
    state = updatedState;
  }

  void undoDelete() {
    if (_deletedStudent != null && _deletedIndex != null) {
      final updatedState = [...state];
      updatedState.insert(_deletedIndex!, _deletedStudent!);
      state = updatedState;

      // Сбрасываем данные
      _deletedStudent = null;
      _deletedIndex = null;
    }
  }

  bool canUndo() {
    return _deletedStudent != null && _deletedIndex != null;
  }
}

final studentsProvider =
    StateNotifierProvider<StudentsNotifier, List<Student>>((ref) {
  return StudentsNotifier();
});
