import 'user.dart';

class Admin extends User {
  final String type = 'admin';

  Admin({uid, name, email, number}) : super(uid, name, email, number);

  factory Admin.fromMap(Map<String, dynamic> data) {
    return Admin(
      uid: data['documentId'],
      name: data['name'],
      email: data['email'],
    );
  }

  @override
  String toString() {
    return 'Admin{type: $type, ${super.toString()}}';
  }
}
