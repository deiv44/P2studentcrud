import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/student.dart';

class StudentRepository {
  final String apiUrl = 'http://localhost:3000/api/students';

  Future<List<Student>> fetchStudents() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Student.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load students');
      }
    } catch (e) {
      throw Exception('Failed to load students: $e');
    }
  }

  Future<void> createStudent(Student student) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'Firstname': student.firstname,
          'Lastname': student.lastname,
          'Course': student.course,
          'Year': student.year,
          'Enrolled': student.enrolled,
        }),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to add student: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to add student: $e');
    }
  }

  Future<void> updateStudent(Student student) async {
    try {
      final response = await http.put(
        Uri.parse('$apiUrl/${student.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'Firstname': student.firstname,
          'Lastname': student.lastname,
          'Course': student.course,
          'Year': student.year,
          'Enrolled': student.enrolled,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode != 200) {
        throw Exception(
            'Failed to update student. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update student: $e');
    }
  }



  Future<void> deleteStudent(String studentId) async {
    try {
      final response = await http.delete(
        Uri.parse('$apiUrl/$studentId'),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete student');
      }
    } catch (e) {
      throw Exception('Failed to delete student: $e');
    }
  }
}
