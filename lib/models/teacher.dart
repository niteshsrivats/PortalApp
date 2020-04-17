import 'package:flutter/foundation.dart';

import 'user.dart';

class Teacher extends User {
  final String id;
  final String year;
  final String department;
  final List<String> semesters;
  final List<String> sections;
  final String type = 'teacher';

  Teacher({
    @required uid,
    @required name,
    @required email,
    @required phoneNumber,
    @required this.id,
    @required this.year,
    @required this.department,
    @required this.semesters,
    @required this.sections,
  }) : super(uid, name, email, phoneNumber);

  factory Teacher.fromMap(Map<String, dynamic> data) {
    return Teacher(
        uid: data['documentId'],
        name: data['name'],
        email: data['email'],
        phoneNumber: data['number'],
        id: data['id'],
        year: data['year'],
        department: data['department'],
        semesters: data['semesters'],
        sections: data['sections']);
  }

  @override
  String toString() {
    return 'Teacher{id: $id, year: $year, department: $department, semesters: $semesters, sections: $sections, type: $type}';
  }
}
