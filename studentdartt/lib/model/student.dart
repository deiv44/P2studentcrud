class Student {
  final String id;
  final String firstname;
  final String lastname;
  final String course;
  final String year;
  final bool enrolled;

  Student({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.course,
    required this.year,
    required this.enrolled,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['_id'] ?? '',
      firstname: json['Firstname'] ?? '',
      lastname: json['Lastname'] ?? '',
      course: json['Course'] ?? '',
      year: json['Year'] ?? '',
      enrolled: json['Enrolled'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Firstname': firstname, 
      'Lastname': lastname,
      'Course': course,
      'Year': year,
      'Enrolled': enrolled,
    };
  }
}
