import 'package:college_main/models/student.dart';
import 'package:college_main/models/teacher.dart';
import 'package:college_main/models/user.dart';
import 'package:college_main/pages/filter_screen.dart';
import 'package:college_main/providers/auth_service.dart';
import 'package:college_main/providers/defaults_service.dart';
import 'package:college_main/providers/post_service.dart';
import 'package:college_main/providers/user_service.dart';
import 'package:college_main/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class NewsfeedScreen extends StatefulWidget {
  @override
  _NewsfeedScreenState createState() => _NewsfeedScreenState();
}

class _NewsfeedScreenState extends State<NewsfeedScreen> {
  PostService _postService;
  DefaultsService _defaultsService;
  User _user;
  AuthService _authService;

  Map<String, List<bool>> _selected = Map();
  Map<String, List<String>> _data = Map();

  static const bodyText = 'Lorem ipsum dolor sit amet, consectetur adipisi adipisicing elit. Asperiores aut dignissimos dolorem dolorum ducimus fuga in, numquam odio pariatur possimus quasi sint sunt ut? Placeat.';
  static const author = '\n- Adhyayan Panwar';
  
  @override
  void initState() {
    _postService = Provider.of<PostService>(context, listen: false);
    _defaultsService = Provider.of<DefaultsService>(context, listen: false);
    _authService = Provider.of<AuthService>(context, listen: false);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _user = Provider.of<UserService>(context).user;
  }

  void _initialize() {
    if (_user != null && (_selected.length == 0 || _data.length == 0)) {
      String role = _user.type;
      String year;
      _data['public'] = ['Public'];
      _selected['public'] = [true];

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
        _selected['departments'] = [true];

        year = _data['years'][0];
        bool isOddSemester = false;
        for (int i = 0; i < _data['semesters'].length; i++) {
          if (_data['semesters'][i].endsWith(year) &&
              int.tryParse(_data['semesters'][i][0]) % 2 == 1) {
            isOddSemester = true;
            break;
          }
        }

        _selected['semesters'] = List.generate(
            _data['semesters'].length,
            (int index) => _data['semesters'][index].endsWith(year) && isOddSemester
                ? int.tryParse(_data['semesters'][index][0]) % 2 == 1
                : true);

        _selected['sections'] = List.generate(
            _data['sections'].length,
            (int index) => _data['sections'][index].endsWith(year) && isOddSemester
                ? int.tryParse(_data['sections'][index][0]) % 2 == 1
                : true);
      } else {
        _data['years'] = _defaultsService.years;
        year = _data['years'][0];
        _data['semesters'] = _defaultsService.semesters;
        _data['departments'] = _defaultsService.departments;
        _selected['departments'] = List.generate(_data['departments'].length, (int index) => false);
        _selected['semesters'] = List.generate(
            _data['semesters'].length, (int index) => _data['semesters'][index].endsWith(year));
      }
      _selected['years'] = List.generate(_data['years'].length, (int index) => false);
      _selected['years'][0] = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    _initialize();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.settings),
          color: Theme.of(context).primaryColor,
          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
          onPressed: () => _authService.signOut(),
        ),
        title: Icon(
          Icons.language,
          color: Theme.of(context).primaryColor,
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.filter_list),
            color: Theme.of(context).primaryColor,
            padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FilterScreen(
                          data: _data,
                          selected: _selected,
                          role: _user.type,
                        ))),
          ),
        ],
      ),
      bottomNavigationBar: const Navbar(index: 1),
      body: ListView.builder(
        itemCount: 8,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 3,
            margin: const EdgeInsets.only(top: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Icon(Icons.account_circle,
                      size: 56, color: Colors.grey),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 24, 8),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  const Text(
                                    'Nitesh Srivats',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Text(
                                    '6A CSE',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black54),
                                  ),
                                ],
                              ),
                            ),
                            const Text(
                              '3hr',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black87),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: const Text(
                            bodyText,
                            style: TextStyle(
                                fontSize: 14.0, color: Colors.black54),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.thumb_up, color: Colors.grey),
                            const SizedBox(width: 4),
                            const Text(
                              '223',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black54),
                            ),
                            const SizedBox(width: 12),
                            const Icon(Icons.comment, color: Colors.grey),
                            const SizedBox(width: 4),
                            const Text(
                              '78',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black54),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  color: Colors.grey,
                                  icon: Icon(Icons.share),
                                  onPressed: () => Share.share(bodyText + author),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
