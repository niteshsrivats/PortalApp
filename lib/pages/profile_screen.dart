import 'dart:io';

import 'package:college_main/models/admin.dart';
import 'package:college_main/models/post.dart';
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
  final Post post;

  ProfileScreen({Key key, this.post}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState(this.post);
}

class _ProfileScreenState extends State<ProfileScreen> {
  Post post;
  User _user;
  Function _signOut, _setUserImage;
  String _title;

  _ProfileScreenState(this.post);

  @override
  void initState() {
    super.initState();
    _setUserImage = Provider.of<UserService>(context, listen: false).setImage;
    _signOut = Provider.of<AuthService>(context, listen: false).signOut;
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    _user = Provider.of<UserService>(context).user;
    _setTitle();
  }

  void _removeImage(String id) async {
    final FirebaseStorage _storage = FirebaseStorage.instance;
    String filePath = 'images/' + id + '.jpg';
    await _storage.ref().child(filePath).delete();
    _setUserImage(null);
  }

  void _setTitle() {
    if (post != null) {
      _title = post.title == null ? '' : post.title;
      return;
    }
    if (_user.type == 'admin') {
      _title = (_user as Admin).title;
    } else if (_user.type == 'student') {
      _title = (_user as Student).department;
    } else if (_user.type == 'teacher') {
      _title = (_user as Teacher).title;
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

  void _showDialog() {
    if (post != null) {
      return;
    }
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
                    _pickImage(ImageSource.camera, _user.uid);
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton.icon(
                  label: Text('Gallery'),
                  icon: Icon(Icons.photo_library),
                  onPressed: () {
                    _pickImage(ImageSource.gallery, _user.uid);
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton.icon(
                  label: Text('Remove'),
                  icon: Icon(Icons.close),
                  onPressed: () {
                    _removeImage(_user.uid);
                    Navigator.of(context).pop();
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
    String image = post == null ? _user.image : post.image;
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
      bottomNavigationBar: Navbar(
        index: 2,
        post: _user.type == 'student' ? false : true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              image != null
                  ? Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: GestureDetector(
                        onTap: _showDialog,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black87, width: 2),
                              borderRadius: BorderRadius.all(Radius.circular(15.0))),
                          child: GFAvatar(
                            backgroundColor: Colors.black,
                            borderRadius: BorderRadius.all(Radius.circular(13.0)),
                            radius: 80,
                            backgroundImage: NetworkImage(image),
                            shape: GFAvatarShape.square,
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: GestureDetector(
                        onTap: _showDialog,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black87, width: 2.5),
                              borderRadius: BorderRadius.all(Radius.circular(15.0))),
                          child: GFAvatar(
                            backgroundColor: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(13.0)),
                            radius: 80,
                            backgroundImage: NetworkImage(
                                'https://www.materialui.co/materialIcons/action/account_circle_grey_192x192.png'),
                            shape: GFAvatarShape.square,
                          ),
                        ),
                      ),
                    ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child:
                    Text(post == null ? _user.name : post.author, style: TextStyle(fontSize: 24)),
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
                  title: Text(_title, style: TextStyle(fontSize: 16)),
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
                  title: Text(
                    post == null ? _user.email : post.authorEmail,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
