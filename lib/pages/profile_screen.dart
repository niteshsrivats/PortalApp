import 'dart:io';

import 'package:college_main/providers/user_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage> with SingleTickerProviderStateMixin {
  final FocusNode myFocusNode = FocusNode();

  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://college-information-portal.appspot.com/');

  Future<void> _pickImage(ImageSource source, String id) async {
    File selected = await ImagePicker.pickImage(source: source);
    // StorageUploadTask _uploadTask;
    String filePath = 'images/' + id + '.png';

    StorageTaskSnapshot snapshot =
        await _storage.ref().child(filePath).putFile(selected).onComplete;
    String url = await snapshot.ref.getDownloadURL().then((value) => value);
    // set IMAGE

    // _uploadTask = _storage.ref().child(filePath).putFile(selected);
    // while (!_uploadTask.isComplete) {
    //   if (_uploadTask.isComplete) {
    //     print("Done!");
    //     break;
    //   }
    // }
    // final ref = FirebaseStorage.instance.ref().child('images/' + id + '.png');
    // final String url = await ref.getDownloadURL();
    // print(url);
  }

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
    final UserService _userService = Provider.of<UserService>(context, listen: false);
    var id = _userService.user.uid;
    var name = _userService.user.name;
    var email = _userService.user.email;
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
                            backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                            shape: GFAvatarShape.standard)),
                    Positioned(
                      top: 130,
                      left: 120.0,
                      child: IconButton(
                        color: Colors.white,
                        icon: Icon(Icons.edit),
                        onPressed: () => _showDialog(id),
                      ),
                    )
                  ],
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                      name,
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
                    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.school,
                        color: Colors.teal[900],
                      ),
                      title: Text(
                        '6A CSE',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    )),
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      side: new BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(20.0)),
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.email,
                      color: Colors.teal[900],
                    ),
                    title: Text(
                      email,
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
