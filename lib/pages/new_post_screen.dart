import 'package:college_main/providers/department_service.dart';
import 'package:college_main/providers/post_service.dart';
import 'package:college_main/widgets/filter.dart';
import 'package:college_main/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewPostScreen extends StatefulWidget {
  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  Map<String, List<bool>> _selected = Map();
  Map<String, List<String>> _data = Map();

  void _initialize(List<String> semesters, List<String> departments, List<String> sections) {
    if (_selected.length == 0 || _data.length == 0) {
      _selected['semesters'] = List.generate(semesters.length, (index) => false);
      _selected['departments'] = List.generate(departments.length, (index) => false);
      _selected['sections'] = List.generate(sections.length, (index) => false);

      _data['semesters'] = semesters;
      _data['departments'] = departments;
      _data['sections'] = sections;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> semesters = ['2nd', '4th', '6th', '8th'];
    List<String> sections = ['2A', '4A', '6A', '8A', '2B', '4B', '6B', '8B'];
    final _departmentService = Provider.of<DepartmentService>(context, listen: false);
    final _postsService = Provider.of<PostService>(context, listen: false);
    _initialize(semesters, _departmentService.departments, sections);

    return Scaffold(
      bottomNavigationBar: const Navbar(index: 0),
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
                  child: TextField(
                    autofocus: false,
                    controller: null,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      labelText: "Write Your Post...",
                      labelStyle: TextStyle(color: Colors.grey),
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  ),
                ),
              ),
              Filter(selected: _selected, data: _data),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
                  color: Theme.of(context).primaryColor,
                  onPressed: null,
                  child: Text(
                    "Post",
                    style:
                        TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.bold),
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
