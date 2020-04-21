import 'package:college_main/widgets/filter_field.dart';
import 'package:flutter/material.dart';

class Filter extends StatefulWidget {
  final Map<String, List<bool>> selected;
  final Map<String, List<String>> data;
  final String role, type;

  const Filter({
    Key key,
    @required this.selected,
    @required this.data,
    @required this.role,
    @required this.type,
  }) : super(key: key);

  @override
  _FilterState createState() => _FilterState(this.data, this.selected, this.role, this.type);
}

class _FilterState extends State<Filter> {
  final Map<String, List<String>> data;
  final Map<String, List<bool>> selected;
  Map<String, List<String>> _data;
  Map<String, List<bool>> _selected;
  final String role, type;

  _FilterState(this.data, this.selected, this.role, this.type) {
    if (type == 'post') {
      _data = data;
      _selected = selected;
    } else if (type == 'feed') {
      _data = Map.from(data);
      _selected = Map.from(selected);

      String year = data['years'][selected['years'].indexOf(true)];

      _data['semesters'].retainWhere((semester) => semester.endsWith(year));
      _selected['semesters'] = List.generate(
          _data['semesters'].length,
          (int index) =>
              selected['semesters'][data['semesters'].indexOf(_data['semesters'][index])]);
      _data['semesters'] = _data['semesters'].map((semester) => semester[0]).toList();

      if (role != 'admin') {
        _data['sections'].retainWhere((section) => section.endsWith(year));
        _data['sections'] = _data['sections'].map((section) => section.substring(0, 2)).toList();
        _selected['sections'] = List.generate(
            _data['sections'].length,
            (int index) =>
                _selected['semesters'][_data['semesters'].indexOf(data['sections'][index][0])]);
        _selected['departments'][0] = true;
      }

      for (var i = 0; i < _data['semesters'].length; i++) {
        if (int.tryParse(_data['semesters'][i]) % 2 == 1) {
          _data['semesters'].retainWhere((semester) => int.tryParse(semester) % 2 == 1);
          break;
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  void publicHandleState(bool value) {
    this._selected['semesters'] =
        List.generate(this._data['semesters'].length, (int index) => value);
    this._selected['departments'] =
        List.generate(this._data['departments'].length, (int index) => value);
    this._selected['public'][0] = value;
  }

  void handlePublic(int index) {
    bool public = _selected['public'][0];
    if (public) {
      this.setState(() => publicHandleState(false));
    } else {
      this.setState(() => publicHandleState(true));
    }
  }

  void handleYear(int index) {
    if (type == 'feed') {
      this.setState(() {
        _selected['years'][index] = !_selected['years'][index];
      });
    }
  }

  void handleSemester(int index) {
    if (type == 'post') {
      if (role == 'admin' && _selected['public'][0] == false) {
        this.setState(() => _selected['semesters'][index] = !_selected['semesters'][index]);
      } else if (role == 'teacher') {
        this.setState(() {
          _selected['semesters'][index] = !_selected['semesters'][index];
          this._selected['sections'] =
              List.generate(this._data['sections'].length, (int index) => false);
        });
      }
    }
  }

  void handleDepartment(int index) {
    if (type == 'post' && role == 'admin' && _selected['public'][0] == false) {
      this.setState(() => _selected['departments'][index] = !_selected['departments'][index]);
    }
  }

  void handleSection(int index) {
    if (type == 'post' && role == 'teacher') {
      this.setState(() {
        _selected['sections'][index] = !_selected['sections'][index];
        this._selected['semesters'] =
            List.generate(this._data['semesters'].length, (int index) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _data['years'] != null
            ? Column(
                children: [
                  Text("Year", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox(height: 4),
                  FilterField(
                      data: _data['years'], selected: _selected['years'], onTap: handleYear),
                  SizedBox(height: 16),
                ],
              )
            : Container(),
        _data['semesters'] != null
            ? Column(
                children: [
                  Text("Semesters", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox(height: 4),
                  FilterField(
                    data: _data['semesters'],
                    selected: _selected['semesters'],
                    onTap: handleSemester,
                  ),
                  SizedBox(height: 16),
                ],
              )
            : Container(),
        _data['sections'] != null
            ? Column(
                children: [
                  Text("departments", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox(height: 4),
                  FilterField(
                    data: _data['departments'],
                    selected: _selected['departments'],
                    onTap: handleDepartment,
                  ),
                  SizedBox(height: 16),
                ],
              )
            : Container(),
        _data['sections'] != null
            ? Column(
                children: [
                  Text("Sections", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox(height: 4),
                  FilterField(
                      data: _data['sections'],
                      selected: _selected['sections'],
                      onTap: handleSection),
                  SizedBox(height: 16),
                ],
              )
            : Container(),
        _data['public'] != null
            ? Column(
                children: [
                  Text("Public", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox(height: 4),
                  FilterField(
                      data: _data['public'], selected: _selected['public'], onTap: handlePublic),
                  SizedBox(height: 16),
                ],
              )
            : Container(),
      ],
    );
  }
}
