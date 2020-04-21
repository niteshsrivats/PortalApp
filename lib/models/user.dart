abstract class User {
  final String uid;
  String image;
  final String name;
  final String email;
  final String number;
  final String type;
  
  User(this.uid, this.name, this.email, this.number, this.type, this.image);

  @override
  String toString() {
    return 'User{uid: $uid, name: $name, email: $email, number: $number, type: $type, image: $image}';
  }
}
