import 'package:college_main/models/admin.dart';
import 'package:college_main/models/post.dart';
import 'package:college_main/models/teacher.dart';
import 'package:college_main/models/user.dart';
import 'package:college_main/providers/defaults_service.dart';
import 'package:college_main/providers/post_service.dart';
import 'package:college_main/providers/user_service.dart';
import 'package:college_main/widgets/filter.dart';
import 'package:college_main/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class NewPostScreen extends StatefulWidget {
  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  final _formKey = GlobalKey<FormState>();
  Map<String, List<bool>> _selected = Map();
  Map<String, List<String>> _data = Map();
  String _content;

  PostService _postService;
  DefaultsService _defaultsService;
  UserService _userService;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _postService = Provider.of<PostService>(context, listen: false);
    _defaultsService = Provider.of<DefaultsService>(context, listen: false);
    _userService = Provider.of<UserService>(context, listen: false);
  }

  void _initialize() {
    if (_selected.length == 0 || _data.length == 0) User user = _userService.user;
    User user = _userService.user;
    String role = user.type;

    if (role == 'admin') {
      _data['semesters'] = _defaultsService.semesters;
      _data['public'] = ['Public'];
      _selected['public'] = [false];
    } else if (role == 'teacher') {
      String year = DateTime.now().year.toString();
      _data['semesters'] = (user as Teacher).semesters;
      _data['semesters'].retainWhere((semester) => semester.endsWith(year));
      _data['semesters'] = _data['semesters'].map((semester) => semester[0]).toList();
    }

    for (var i = 0; i < _data['semesters'].length; i++) {
      if (int.tryParse(_data['semesters'][i]) % 2 == 1) {
        _data['semesters'].retainWhere((semester) => int.tryParse(semester) % 2 == 1);
        break;
      }
    }
    _selected['semesters'] = List.generate(_data['semesters'].length, (index) => false);

    if (role == 'teacher') {
      List<String> sections = (user as Teacher).sections;
      sections.retainWhere((section) =>
          section.endsWith(DateTime.now().year.toString()) &&
          _data['semesters'].contains(section[0]));

      _data['sections'] = sections.map((section) => section.substring(0, 2)).toList();
      _selected['sections'] = List.generate(sections.length, (index) => false);
    }

    if (role == 'teacher') {
      _data['departments'] = [(user as Teacher).department];
      _selected['departments'] = [true];
    } else {
      _data['departments'] = _defaultsService.departments;
      _selected['departments'] = List.generate(_data['departments'].length, (index) => false);
    }
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 75,
            child: Column(
              children: <Widget>[
                Center(
                    child: Text(
                  "Invalid",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
                Expanded(child: Center(child: Text("Please select recepients"))),
              ],
            ),
          ),
        );
      },
    );
  }

  void post() {
    final form = _formKey.currentState;
    if (!form.validate()) {
      return;
    }
    form.save();

    User user = _userService.user;
    String role = user.type;
    String title;
    Set<String> accessSpecifiers = Set();
    String year = DateTime.now().year.toString();

    bool isSemestersSelected = _selected['semesters'].indexOf(true) == -1 ? false : true;

    if (role == 'teacher') {
      bool isSectionsSelected = _selected['sections'].indexOf(true) == -1 ? false : true;
      if (!isSectionsSelected && !isSemestersSelected) {
        _showDialog();
        return;
      }
      title = (user as Teacher).title;

      if (isSemestersSelected) {
        for (int i = 0; i < _data['semesters'].length; i++) {
          if (_selected['semesters'][i]) {
            accessSpecifiers.add(_data['semesters'][i] + '-' + year);
            accessSpecifiers
                .add(_data['semesters'][i] + '-' + _data['departments'][0] + '-' + year);
          }
        }
      } else if (isSectionsSelected) {
        for (int i = 0; i < _data['sections'].length; i++) {
          if (_selected['sections'][i]) {
            accessSpecifiers.add(_data['sections'][i][0] + '-' + year);
            accessSpecifiers.add(_data['sections'][i] + '-' + _data['departments'][0] + '-' + year);
          }
        }
      }
    } else if (role == 'admin') {
      bool isDepartmentsSelected = _selected['departments'].indexOf(true) == -1 ? false : true;
      if (!isDepartmentsSelected && !isSemestersSelected) {
        _showDialog();
        return;
      }
      title = (user as Admin).title;

      for (int i = 0; i < _data['departments'].length; i++) {
        for (int j = 0; j < _data['semesters'].length; j++) {
          if (!_selected['public'][0]) {
            if (isSemestersSelected && isDepartmentsSelected) {
              if (!_selected['semesters'][j] || !_selected['departments'][i]) {
                accessSpecifiers.add(_data['semesters'][j] + '-' + year);
                accessSpecifiers
                    .add(_data['semesters'][j] + '-' + _data['departments'][i] + '-' + year);
              }
            } else if (isSemestersSelected) {
              if (!_selected['semesters'][j]) {
                accessSpecifiers.add(_data['semesters'][j] + '-' + year);
                accessSpecifiers
                    .add(_data['semesters'][j] + '-' + _data['departments'][i] + '-' + year);
              }
            } else if (isDepartmentsSelected) {
              if (_selected['departments'][i]) {
                accessSpecifiers.add(_data['departments'][i] + '-' + year);
              }
            }
          } else {
            accessSpecifiers.add('public');
          }
        }
      }
    }

    Map<String, dynamic> data = Post(
            author: user.name,
            authorId: user.uid,
            authorEmail: user.email,
            image: user.image,
            title: title,
            content: _content,
            accessSpecifiers: accessSpecifiers.toList())
        .toMap();

    _postService.post(data: data);
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    _initialize();

    return Scaffold(
      bottomNavigationBar: const Navbar(index: 0, post: true),
      extendBody: true,
      body: Container(
        height: double.infinity,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
          child: ListView(
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.all(32),
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      autofocus: false,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        labelText: "Write Your Post...",
                        labelStyle: TextStyle(color: Colors.grey),
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      validator: (content) => content.isEmpty ? "Enter your post" : null,
                      onSaved: (content) => setState(() => _content = content),
                    ),
                  ),
                ),
              ),
              Filter(selected: _selected, data: _data, role: _userService.user.type, type: 'post'),
              Center(
                child: Container(
                  width: 100,
                  padding: const EdgeInsets.all(8),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    color: Theme.of(context).primaryColor,
                    onPressed: post,
                    child: Text(
                      "POST",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
