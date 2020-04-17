abstract class User {
  final String uid;
  final String name;
  final String email;
  final String number;

  User(this.uid, this.name, this.email, this.number);

  @override
  String toString() {
    return 'User{uid: $uid, name: $name, email: $email, number: $number}';
  }
}
