part of 'student_bloc.dart';

abstract class StudentEvent extends Equatable {
  const StudentEvent();

  @override
  List<Object> get props => [];
}

class LoadStudents extends StudentEvent {}

class CreateStudent extends StudentEvent {
  final Student student;

  const CreateStudent(this.student);

  @override
  List<Object> get props => [student];
}

class UpdateStudent extends StudentEvent {
  final Student student;

  const UpdateStudent(this.student);

  @override
  List<Object> get props => [student];
}

class DeleteStudent extends StudentEvent {
  final String studentId;

  const DeleteStudent(this.studentId);

  @override
  List<Object> get props => [studentId];
}
