import 'package:flutter/foundation.dart';

import 'user.dart';

class Teacher extends User {
  final String id;
  final String title;
  final List<String> years;
  final String department;
  final List<String> semesters;
  final List<String> sections;

  Teacher({
    @required uid,
    @required image,
    @required name,
    @required email,
    @required number,
    @required this.id,
    @required this.title,
    @required this.years,
    @required this.department,
    @required this.semesters,
    @required this.sections,
  }) : super(uid, name, email, number, 'teacher', image);

  factory Teacher.fromMap(Map<String, dynamic> data) {
    return Teacher(
      uid: data['documentId'],
      image: data['image'],
      name: data['name'],
      title: data['title'],
      email: data['email'],
      number: data['number'],
      id: data['id'],
      years: data['years'].cast<String>(),
      department: data['department'],
      semesters: data['semesters'].cast<String>(),
      sections: data['sections'].cast<String>(),
    );
  }

  @override
  String toString() {
    return 'Teacher{id: $id, years: $years, department: $department, semesters: $semesters, sections: $sections, type: $type}';
  }
}
