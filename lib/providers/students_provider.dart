import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/student.dart';

class StudentsScreenState {
  final List<Student> studentsList;
  final bool isLoading;
  final String? msg;

  StudentsScreenState({
    required this.studentsList,
    required this.isLoading,
    this.msg,
  });

  StudentsScreenState copyWith({
    List<Student>? students,
    bool? isLoading,
    String? errorMessage,
  }) {
    return StudentsScreenState(
      studentsList: students ?? this.studentsList,
      isLoading: isLoading ?? this.isLoading,
      msg: errorMessage ?? this.msg,
    );
  }
}

class StudentsNotifier extends StateNotifier<StudentsScreenState> {
  StudentsNotifier() : super(StudentsScreenState(studentsList: [], isLoading: false));

  Student? _lastDeletion;
  int? _lastDeletionIndex;

  Future<void> loadList() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final students = await Student.remoteGetList();
      state = state.copyWith(students: students, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> addStudent(
    String firstName,
    String lastName,
    department,
    gender,
    int grade,
  ) async {
    try {
      state = state.copyWith(isLoading: true, errorMessage: null);
      final student = await Student.remoteCreate(
          firstName, lastName, department, gender, grade);
      state = state.copyWith(
        students: [...state.studentsList, student],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> editStudent(
    int index,
    String firstName,
    String lastName,
    department,
    gender,
    int grade,
  ) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final updatedStudent = await Student.remoteUpdate(
        state.studentsList[index].id,
        firstName,
        lastName,
        department,
        gender,
        grade,
      );
      final updatedList = [...state.studentsList];
      updatedList[index] = updatedStudent;
      state = state.copyWith(students: updatedList, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  void removeStudent(int index) {
    _lastDeletion = state.studentsList[index];
    _lastDeletionIndex = index;
    final updatedList = [...state.studentsList];
    updatedList.removeAt(index);
    state = state.copyWith(students: updatedList);
  }

  void undoDelete() {
    if (_lastDeletion != null && _lastDeletionIndex != null) {
      final updatedList = [...state.studentsList];
      updatedList.insert(_lastDeletionIndex!, _lastDeletion!);
      state = state.copyWith(students: updatedList);
    }
  }

  Future<void> deleteFromServer() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      if (_lastDeletion != null) {
        await Student.remoteDelete(_lastDeletion!.id);
        _lastDeletion = null;
        _lastDeletionIndex = null;
      }
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }
}

final studentsProvider =
    StateNotifierProvider<StudentsNotifier, StudentsScreenState>((ref) {

  final notifier = StudentsNotifier();
  notifier.loadList();
  return notifier;
});
