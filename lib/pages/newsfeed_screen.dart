import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_main/models/post.dart';
import 'package:college_main/models/student.dart';
import 'package:college_main/models/teacher.dart';
import 'package:college_main/models/user.dart';
import 'package:college_main/pages/filter_screen.dart';
import 'package:college_main/pages/profile_screen.dart';
import 'package:college_main/providers/defaults_service.dart';
import 'package:college_main/providers/post_service.dart';
import 'package:college_main/providers/user_service.dart';
import 'package:college_main/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class NewsfeedScreen extends StatefulWidget {
  @override
  _NewsfeedScreenState createState() => _NewsfeedScreenState();
}

class _NewsfeedScreenState extends State<NewsfeedScreen> {
  User _user;
  List<Post> _posts;
  Function _getPosts;
  List<String> _defaultDepartments;
  List<String> _defaultSemesters;
  List<String> _defaultYears;

  Map<String, List<bool>> _selected = Map();
  Map<String, List<String>> _data = Map();

  Future<void> getPosts() async {
    List<String> accessSpecifiers = [];
    if (_selected['public'][0]) {
      accessSpecifiers.add('public');
    }

    String year = _data['years'][_selected['years'].indexOf(true)];
    for (int i = 0; i < _selected['semesters'].length; i++) {
      if (_selected['semesters'][i]) {
        if (_user.type == 'admin') {
          String semester = _data['semesters'][i] + '-' + year;
          accessSpecifiers.add(semester);
        } else {
          String department;
          if (_user.type == 'teacher') {
            department = (_user as Teacher).department;
          } else if (_user.type == 'student') {
            department = (_user as Student).department;
          }
          String semester = _data['semesters'][i];
          String departmentSemester = semester[0] + '-' + department + '-' + year;
          accessSpecifiers.add(departmentSemester);
        }
      }
    }

    for (int i = 0; i < _selected['departments'].length; i++) {
      if (_selected['departments'][i]) {
        accessSpecifiers.add(_data['departments'][i]);
      }
    }

    if (_user.type != 'admin') {
      for (int i = 0; i < _selected['sections'].length; i++) {
        if (_selected['sections'][i]) {
          String section =
              _data['sections'][i].substring(0, 2) + '-' + _data['departments'][0] + '-' + year;
          accessSpecifiers.add(section);
        }
      }
    }
    _getPosts(accessSpecifiers);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _user = Provider.of<UserService>(context).user;
    _posts = Provider.of<PostService>(context).posts;
    _getPosts = Provider.of<PostService>(context).getPosts;
    _defaultYears = Provider.of<DefaultsService>(context).years;
    _defaultSemesters = Provider.of<DefaultsService>(context).semesters;
    _defaultDepartments = Provider.of<DefaultsService>(context).departments;

    if (_user != null &&
        _selected.keys.length == 0 &&
        (_user.type != 'admin' || _defaultYears != null)) {
      _initialize();
      setDefaults();
    }
  }

  void setDefaults() {
    setState(() {
      String year = _data['years'][0];

      _selected['years'] = List.generate(_data['years'].length, (int index) => false);
      _selected['departments'] = List.generate(_data['departments'].length, (int index) => false);
      _selected['public'][0] = true;
      _selected['years'][0] = true;

      if (_user.type != 'admin') {
        _selected['departments'][0] = true;
        _selected['semesters'] = List.generate(_data['semesters'].length, (int index) => false);
        _selected['sections'] = List.generate(_data['sections'].length, (int index) => false);

        bool isOddSemester = false;
        for (int i = 0; i < _data['semesters'].length; i++) {
          if (_data['semesters'][i].endsWith(year) &&
              int.tryParse(_data['semesters'][i][0]) % 2 == 1) {
            isOddSemester = true;
            break;
          }
        }

        _selected['semesters'] = List.generate(_data['semesters'].length, (int index) => false);
        for (int i = 0; i < _data['semesters'].length; i++) {
          if (_data['semesters'][i].endsWith(year)) {
            _selected['semesters'][i] =
                isOddSemester ? int.tryParse(_data['semesters'][i][0]) % 2 == 1 : true;
          }
        }

        _selected['sections'] = List.generate(_data['sections'].length, (int index) => false);
        for (int i = 0; i < _data['sections'].length; i++) {
          if (_data['sections'][i].endsWith(year)) {
            _selected['sections'][i] =
                isOddSemester ? int.tryParse(_data['sections'][i][0]) % 2 == 1 : true;
          }
        }
      } else {
        _selected['semesters'] = List.generate(_data['semesters'].length, (int index) => true);
      }
    });
    getPosts();
  }

  void _initialize() {
    String role = _user.type;
    _data['public'] = ['Public'];
    _selected['public'] = [false];

    if (role != 'admin') {
      if (role == 'student') {
        _data['years'] = (_user as Student).years;
        _data['semesters'] = (_user as Student).semesters;
        _data['sections'] = (_user as Student).sections;
        _data['departments'] = [(_user as Student).department];
      } else if (role == 'teacher') {
        _data['years'] = (_user as Teacher).years;
        _data['semesters'] = (_user as Teacher).semesters;
        _data['sections'] = (_user as Teacher).sections;
        _data['departments'] = [(_user as Teacher).department];
      }
      _selected['sections'] = List.generate(_data['sections'].length, (int index) => false);
    } else {
      _data['years'] = _defaultYears;
      _data['semesters'] = _defaultSemesters;
      _data['departments'] = _defaultDepartments;
    }
    _selected['years'] = List.generate(_data['years'].length, (int index) => false);
    _selected['semesters'] = List.generate(_data['semesters'].length, (int index) => false);
    _selected['departments'] = List.generate(_data['departments'].length, (int index) => false);
  }

  String getTime(Timestamp timestamp) {
    if (timestamp == null) {
      return "0s";
    }
    Duration duration = DateTime.now()
        .difference(DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch));
    if (duration.inDays != 0) {
      return duration.inDays.toString() + 'd';
    } else if (duration.inHours != 0) {
      return duration.inHours.toString() + 'hr';
    } else if (duration.inMinutes != 0) {
      return duration.inMinutes.toString() + 'm';
    } else if (duration.inSeconds != 0) {
      return duration.inSeconds.toString() + 's';
    }
    return duration.inMilliseconds.toString() + 'ms';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.filter_list),
            color: Theme.of(context).primaryColor,
            padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => FilterScreen(
                  data: _data,
                  selected: _selected,
                  role: _user.type,
                  reset: setDefaults,
                  getPosts: getPosts,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          Navbar(index: 1, post: _user == null ? false : (_user.type == 'student' ? false : true)),
      body: RefreshIndicator(
        onRefresh: getPosts,
        child: ListView.builder(
          itemCount: _posts.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ProfileScreen(post: _posts[index])),
              ),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 3,
                margin: const EdgeInsets.only(top: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _posts[index].image == null
                          ? Icon(Icons.account_circle, size: 56, color: Colors.grey)
                          : GFAvatar(
                              radius: 24,
                              backgroundImage: NetworkImage(_posts[index].image),
                              shape: GFAvatarShape.circle,
                            ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 24, 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text(
                                        _posts[index].author,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        _posts[index].title,
                                        style: TextStyle(fontSize: 14, color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  getTime(_posts[index].timestamp),
                                  style: TextStyle(fontSize: 14, color: Colors.black87),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Text(
                                _posts[index].content,
                                style: TextStyle(fontSize: 14.0, color: Colors.black54),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                color: Colors.grey,
                                icon: Icon(Icons.share),
                                onPressed: () => Share.share(
                                    _posts[index].content + '\n - ' + _posts[index].author),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
