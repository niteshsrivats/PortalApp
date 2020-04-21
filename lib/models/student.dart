import 'package:flutter/foundation.dart';

import 'user.dart';

class Student extends User {
  final String id;
  final List<String> years;
  final String department;
  final List<String> semesters;
  final List<String> sections;

  Student({
    @required uid,
    @required image,
    @required name,
    @required email,
    @required phoneNumber,
    @required this.id,
    @required this.years,
    @required this.department,
    @required this.semesters,
    @required this.sections,
  }) : super(uid, name, email, phoneNumber, 'student', image);

  factory Student.fromMap(Map<String, dynamic> data) {
    return Student(
      uid: data['documentId'],
      image: data['image'],
      name: data['name'],
      email: data['email'],
      phoneNumber: data['number'],
      id: data['id'],
      years: data['years'].cash<String>(),
      department: data['department'],
      semesters: data['semesters'].cast<String>(),
      sections: data['sections'].cast<String>(),
    );
  }

  @override
  String toString() {
    return 'Student{id: $id, year: $years, department: $department, semesters: $semesters, sections: $sections, type: $type}';
  }
}
