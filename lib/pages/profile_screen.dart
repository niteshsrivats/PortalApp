import 'dart:io';
import 'package:getflutter/getflutter.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:college_main/providers/user_service.dart';
import 'package:provider/provider.dart';
import 'package:college_main/models/user.dart';
import 'package:college_main/models/admin.dart';
import 'package:college_main/models/student.dart';
// import 'package:college_main/models/post.dart';
import 'package:college_main/models/teacher.dart';
// import 'package:college_main/widgets/navbar.dart';

class ProfilePage extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  final FocusNode myFocusNode = FocusNode();
  UserService _userService;
  String main;
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userService = Provider.of<UserService>(context, listen: true);
    _initalize();
  }

  void _initalize() {
    User user = _userService.user;
    if (user.type == 'admin')
      main = (user as Admin).title;
    else if (user.type == 'student')
      main = (user as Student).department;
    else if (user.type == 'teacher') main = (user as Teacher).title;
  }

  Future<void> _pickImage(ImageSource source, String id) async {
    File selected = await ImagePicker.pickImage(source: source);
    final FirebaseStorage _storage = FirebaseStorage(
        storageBucket: 'gs://college-information-portal.appspot.com/');

    // StorageUploadTask _uploadTask;
    String filePath = 'images/' + id + '.png';
    StorageTaskSnapshot snapshot =
        await _storage.ref().child(filePath).putFile(selected).onComplete;
    String url = await snapshot.ref.getDownloadURL().then((value) => value);
    print(url);
    _userService.setImage(url);
  }

  void checkUrl() {
    if (_userService.user.image == null)
      _userService.user.image = 'https://via.placeholder.com/150';
  }
  // Future<void> _getURL(String id) async {
  //   final ref = FirebaseStorage.instance.ref().child('images/' + id + '.png');
  //   final String url = await ref.getDownloadURL();
  //   print(url);
  //   _userService.setImage(url);
  // }

  void _showDialog(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            content: new Container(
          height: 150,
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                FlatButton.icon(
                  label: Text('Camera'),
                  icon: Icon(Icons.photo_camera),
                  onPressed: () {
                    _pickImage(ImageSource.camera, id);
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton.icon(
                  label: Text('Gallery'),
                  icon: Icon(Icons.photo_library),
                  onPressed: () {
                    _pickImage(ImageSource.gallery, id);
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton.icon(
                  label: Text('Remove'),
                  icon: Icon(Icons.close),
                  onPressed: () {
                    //_pickImage(ImageSource.gallery);
                    //Navigator.of(context).pop();
                  },
                ),
              ]),
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    checkUrl();
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Profile Page",
            style: TextStyle(fontSize: 18.0),
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: GFAvatar(
                            radius: 80,
                            backgroundImage:
                                NetworkImage(_userService.user.image),
                            shape: GFAvatarShape.standard)),
                    Positioned(
                      top: 130,
                      left: 120.0,
                      child: IconButton(
                        color: Colors.white,
                        icon: Icon(Icons.edit),
                        onPressed: () => _showDialog(_userService.user.uid),
                      ),
                    )
                  ],
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                      _userService.user.name,
                      style: TextStyle(
                        fontFamily: 'SourceSansPro',
                        fontSize: 25,
                      ),
                    )),
                SizedBox(
                  height: 20.0,
                  width: 200,
                  child: Divider(
                    color: Colors.teal[100],
                  ),
                ),
                Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        side: new BorderSide(color: Colors.blue, width: 2.0),
                        borderRadius: BorderRadius.circular(20.0)),
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.school,
                        color: Colors.teal[900],
                      ),
                      title: Text(
                        main,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    )),
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      side: new BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(20.0)),
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.email,
                      color: Colors.teal[900],
                    ),
                    title: Text(
                      _userService.user.email,
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
