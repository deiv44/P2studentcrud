import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:studentdartt/model/student.dart';
import 'package:studentdartt/repository/repository.dart';
part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final StudentRepository repository;

  StudentBloc(this.repository) : super(StudentLoading()) {
    // Load Students
    on<LoadStudents>((event, emit) async {
      try {
        final students = await repository.fetchStudents();
        print('Data loaded: ${students.length} students found');
        if (students.isEmpty) {
          print('No students in the database');
        }
        emit(StudentLoaded(students));
      } catch (e) {
        print('Error loading data: $e');
        emit(const StudentError("Failed to load students"));
      }
    });

    // Add Student
    on<CreateStudent>((event, emit) async {
      if (state is StudentLoaded) {
        try {
          await repository.createStudent(event.student);
          final currentStudents = (state as StudentLoaded).students;
          final updatedStudents = List<Student>.from(currentStudents)
            ..add(event.student);
          emit(StudentLoaded(updatedStudents));
        } catch (e) {
          emit(StudentError("Failed to add student: $e"));
        }
      }
    });

    on<UpdateStudent>((event, emit) async {
      if (state is StudentLoaded) {
        try {
          await repository.updateStudent(event.student);

          final updatedStudents = (state as StudentLoaded)
              .students
              .map((student) =>
                  student.id == event.student.id ? event.student : student)
              .toList();

          print('Updated student list: $updatedStudents');

          emit(StudentLoaded(updatedStudents));
        } catch (e) {
          print('Error updating student: $e');
          emit(StudentError('Failed to update student: $e'));
        }
      }
    });


    // Delete Student
    on<DeleteStudent>((event, emit) async {
      if (state is StudentLoaded) {
        try {
          await repository.deleteStudent(event.studentId);
          print('Student deleted: ${event.studentId}');
          final updatedStudents = (state as StudentLoaded)
              .students
              .where((student) => student.id != event.studentId)
              .toList();
          emit(StudentLoaded(updatedStudents));
        } catch (e) {
          print('Error deleting student: $e');
          emit(const StudentError("Failed to delete student"));
        }
      }
    });
  }
}
