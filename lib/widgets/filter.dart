import 'dart:convert';

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

  _FilterState(this.data, this.selected, this.role, this.type);

  @override
  void initState() {
    super.initState();
    if (type == 'post') {
      _data = data;
      _selected = selected;
    } else if (type == 'feed') {
      _data = _decodeData(data);
      _selected = _decodeSelected(selected);
      applyYear(data['years'][selected['years'].indexOf(true)]);
    }
  }

  Map<String, List<String>> _decodeData(data) {
    Map<String, dynamic> jsondata = json.decode(json.encode(data));
    Map<String, List<String>> finalJson = Map();
    for (String key in jsondata.keys) {
      finalJson.putIfAbsent(key, () => jsondata[key].cast<String>());
    }
    return finalJson;
  }

  Map<String, List<bool>> _decodeSelected(data) {
    Map<String, dynamic> jsondata = json.decode(json.encode(data));
    Map<String, List<bool>> finalJson = Map();
    for (String key in jsondata.keys) {
      finalJson.putIfAbsent(key, () => jsondata[key].cast<bool>());
    }
    return finalJson;
  }

  void _applySelections() {
    String year = _data['years'][_selected['years'].indexOf(true)];
    for (String key in _selected.keys) {
      for (int index = 0; index < _selected[key].length; index++) {
        bool value = _selected[key][index];

        String dataValue;
        if (key == 'sections') {
          dataValue = _data[key][index] + _data['departments'][0] + year;
        } else if (key == 'semesters') {
          if (role == 'admin') {
            dataValue = _data[key][index];
          } else {
            dataValue = _data[key][index] + '-' + year;
          }
        } else {
          dataValue = _data[key][index];
        }
        selected[key][data[key].indexOf(dataValue)] = value;
      }
    }
  }

  void applyYear(year) {
    if (role == 'admin') {
      _selected['semesters'] = List.generate(_data['semesters'].length, (int index) => true);
      _selected['public'] = List.generate(_data['public'].length, (int index) => true);
    } else {
      bool isOddSemester = false;
      for (int i = 0; i < data['semesters'].length; i++) {
        if (data['semesters'][i].endsWith(year) && int.tryParse(data['semesters'][i][0]) % 2 == 1) {
          isOddSemester = true;
          break;
        }
      }
      _data['semesters'].retainWhere((semester) => semester.endsWith(year));
      _data['semesters'] = _data['semesters'].map((semester) => semester[0]).toList();
      _selected['semesters'] = List.generate(_data['semesters'].length,
          (int index) => isOddSemester ? int.tryParse(_data['semesters'][index]) % 2 == 1 : true);

      _selected['departments'][0] = true;
      _selected['public'][0] = true;

      _data['sections'].retainWhere((section) => section.endsWith(year));
      _data['sections'] = _data['sections'].map((section) => section.substring(0, 2)).toList();
      _selected['sections'] = List.generate(_data['sections'].length,
          (int index) => isOddSemester ? int.tryParse(_data['sections'][index][0]) % 2 == 1 : true);
    }
  }

  void publicHandleState(bool value) {
    this._selected['semesters'] =
        List.generate(this._data['semesters'].length, (int index) => value);
    this._selected['departments'] =
        List.generate(this._data['departments'].length, (int index) => value);
    this._selected['public'][0] = value;
  }

  void handlePublic(int index) {
    if (type == 'post') {
      bool public = _selected['public'][0];
      if (public) {
        this.setState(() => publicHandleState(false));
      } else {
        this.setState(() => publicHandleState(true));
      }
    } else if (type == 'feed') {
      this.setState(() => _selected['public'][0] = !_selected['public'][0]);
    }
  }

  void handleYear(int index) {
    if (type == 'feed') {
      if (!_selected['years'][index]) {
        setState(() {
          _data = _decodeData(data);
          _selected = _decodeSelected(selected);
          _selected['years'] = List.generate(_data['years'].length, (int i) => index == i);
          applyYear(_data['years'][index]);
        });
      }
    }
  }

  void handleSemester(int index) {
    if (type == 'post') {
      if (role == 'admin' && _selected['public'][0] == false) {
        this.setState(() => selected['semesters'][index] = !_selected['semesters'][index]);
      } else if (role == 'teacher') {
        this.setState(() {
          _selected['semesters'][index] = !_selected['semesters'][index];
          this._selected['sections'] =
              List.generate(this._data['sections'].length, (int index) => false);
        });
      }
    } else if (type == 'feed') {
      this.setState(() => _selected['semesters'][index] = !_selected['semesters'][index]);
    }
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    _applySelections();
  }

  void handleDepartment(int index) {
    if (type == 'post' && role == 'admin' && _selected['public'][0] == false) {
      this.setState(() => _selected['departments'][index] = !_selected['departments'][index]);
    } else if (type == 'feed') {
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
    } else if (type == 'feed') {
      this.setState(() => _selected['sections'][index] = !_selected['sections'][index]);
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
        _data['departments'] != null
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
