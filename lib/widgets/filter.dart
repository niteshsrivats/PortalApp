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
  final String role, type;

  @override
  void initState() {
    super.initState();
  }

  void publicHandleState(bool value) {
    this.selected['semesters'] = List.generate(this.data['semesters'].length, (int index) => value);
    this.selected['departments'] =
        List.generate(this.data['departments'].length, (int index) => value);
    this.selected['public'][0] = value;
  }

  void handlePublic(int index) {
    bool public = selected['public'][0];
    if (public) {
      this.setState(() => publicHandleState(false));
    } else {
      this.setState(() => publicHandleState(true));
    }
  }

  void handleYear(int index) {
    this.setState(() => selected['years'][index] = !selected['years'][index]);
  }

  void handleSemester(int index) {
    if (type == 'post') {
      if (role == 'admin' && selected['public'][0] == false) {
        this.setState(() => selected['semesters'][index] = !selected['semesters'][index]);
      } else if (role == 'teacher') {
        this.setState(() {
          selected['semesters'][index] = !selected['semesters'][index];
          this.selected['sections'] =
              List.generate(this.data['sections'].length, (int index) => false);
        });
      }
    }
  }

  void handleDepartment(int index) {
    if (type == 'post' && role == 'admin' && selected['public'][0] == false) {
      this.setState(() => selected['departments'][index] = !selected['departments'][index]);
    }
  }

  void handleSection(int index) {
    if (type == 'post' && role == 'teacher') {
      this.setState(() {
        selected['sections'][index] = !selected['sections'][index];
        this.selected['semesters'] =
            List.generate(this.data['semesters'].length, (int index) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        data['years'] != null
            ? Column(
                children: [
                  Text("Year", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox(height: 4),
                  FilterField(data: data['years'], selected: selected['years'], onTap: handleYear),
                  SizedBox(height: 16),
                ],
              )
            : Container(),
        data['semesters'] != null
            ? Column(
                children: [
                  Text("Semesters", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox(height: 4),
                  FilterField(
                    data: data['semesters'],
                    selected: selected['semesters'],
                    onTap: handleSemester,
                  ),
                  SizedBox(height: 16),
                ],
              )
            : Container(),
        Text(data['departments'].length == 1 ? "Department" : "Departments",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        SizedBox(height: 4),
        FilterField(
            data: data['departments'], selected: selected['departments'], onTap: handleDepartment),
        SizedBox(height: 16),
        data['sections'] != null
            ? Column(
                children: [
                  Text("Sections", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox(height: 4),
                  FilterField(
                      data: data['sections'], selected: selected['sections'], onTap: handleSection),
                  SizedBox(height: 16),
                ],
              )
            : Container(),
        data['public'] != null
            ? Column(
                children: [
                  Text("Public", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox(height: 4),
                  FilterField(
                      data: data['public'], selected: selected['public'], onTap: handlePublic),
                  SizedBox(height: 16),
                ],
              )
            : Container(),
      ],
    );
  }

  _FilterState(this.data, this.selected, this.role, this.type);
}
