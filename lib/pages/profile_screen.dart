import 'dart:io';

import 'package:college_main/models/admin.dart';
import 'package:college_main/models/student.dart';
import 'package:college_main/models/teacher.dart';
import 'package:college_main/models/user.dart';
import 'package:college_main/providers/auth_service.dart';
import 'package:college_main/providers/user_service.dart';
import 'package:college_main/widgets/navbar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  final User user;

  ProfileScreen({Key key, this.user}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState(this.user);
}

class _ProfileScreenState extends State<ProfileScreen> {
  User user;
  User _user;
  Function _signOut, _setUserImage;
  String _title;

  _ProfileScreenState(this.user);

  @override
  void initState() {
    super.initState();
    _setUserImage = Provider.of<UserService>(context, listen: false).setImage;
    _signOut = Provider.of<AuthService>(context, listen: false).signOut;
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    _user = Provider.of<UserService>(context).user;
    if (user == null) {
      user = _user;
    }
    _setTitle();
  }

  void _setTitle() {
    if (user.type == 'admin') {
      _title = (user as Admin).title;
    } else if (user.type == 'student') {
      _title = (user as Student).department;
    } else if (user.type == 'teacher') {
      _title = (user as Teacher).title;
    }
  }

  Future<void> _pickImage(ImageSource source, String id) async {
    File selected = await ImagePicker.pickImage(source: source);
    final FirebaseStorage _storage = FirebaseStorage.instance;
    String filePath = 'images/' + id + '.jpg';
    StorageTaskSnapshot snapshot =
        await _storage.ref().child(filePath).putFile(selected).onComplete;
    String url = await snapshot.ref.getDownloadURL().then((value) => value);
    _setUserImage(url);
  }

  void _showDialog(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: new Container(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    // TODO Remove
                    //_pickImage(ImageSource.gallery);
                    //Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: RaisedButton(
              elevation: 0.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              color: Colors.white,
              onPressed: () => _signOut(),
              child: Text(
                'Logout',
                style:
                    TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: const Navbar(index: 2),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  // TODO Add Border
                  // TODO On Click Show Menu
                  // TODO Default User Icon
                  // TODO After changes, check if stack is necessary
                  user.image != null
                      ? Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: GFAvatar(
                            radius: 80,
                            backgroundImage: NetworkImage(user.image),
                            shape: GFAvatarShape.standard,
                          ),
                        )
                      : Container(),
//                    Positioned(
//                      top: 130,
//                      left: 120.0,
//                      child: IconButton(
//                        color: Colors.white,
//                        icon: Icon(Icons.edit),
//                        onPressed: () => _showDialog(_userService.user.uid),
//                      ),
//                    )
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(user.name, style: TextStyle(fontSize: 24)),
              ),
              SizedBox(
                height: 20.0,
                width: 200,
                child: Divider(
                  color: Colors.lightBlue[200],
                  thickness: 2,
                ),
              ),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.lightBlue[300]),
                    borderRadius: BorderRadius.circular(24)),
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 40),
                child: ListTile(
                  leading: Icon(Icons.school, color: Colors.lightBlue[900]),
                  title: Text(_title, style: TextStyle(fontSize: 20)),
                ),
              ),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.lightBlue[300]),
                    borderRadius: BorderRadius.circular(24)),
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 40),
                child: ListTile(
                  leading: Icon(Icons.email, color: Colors.lightBlue[900]),
                  title: Text(user.email, style: TextStyle(fontSize: 20)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
