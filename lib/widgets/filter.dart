import 'package:college_main/widgets/filter_field.dart';
import 'package:flutter/material.dart';

class Filter extends StatefulWidget {
  final Map<String, List<bool>> selected;
  final Map<String, List<String>> data;

  const Filter({Key key, @required this.selected, @required this.data}) : super(key: key);

  @override
  _FilterState createState() => _FilterState(this.data, this.selected);
}

class _FilterState extends State<Filter> {
  final Map<String, List<String>> data;
  final Map<String, List<bool>> selected;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        data['years'] != null
            ? Column(
                children: [
                  Text(
                    "Year",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 4),
                  FilterField(
                    data: data['years'],
                    selected: selected['years'],
                    onTap: (index) =>
                        this.setState(() => selected['years'][index] = !selected['years'][index]),
                  ),
                  SizedBox(height: 16),
                ],
              )
            : Container(),
        Text(
          "Semesters",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 4),
        FilterField(
          data: data['semesters'],
          selected: selected['semesters'],
          onTap: (index) =>
              this.setState(() => selected['semesters'][index] = !selected['semesters'][index]),
        ),
        SizedBox(height: 16),
        Text(
          "Departments",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 4),
        FilterField(
          data: data['departments'],
          selected: selected['departments'],
          onTap: (index) =>
              this.setState(() => selected['departments'][index] = !selected['departments'][index]),
        ),
        SizedBox(height: 16),
        data['sections'] != null
            ? Column(
                children: [
                  Text(
                    "Sections",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 4),
                  FilterField(
                    data: data['sections'],
                    selected: selected['sections'],
                    onTap: (index) => this
                        .setState(() => selected['sections'][index] = !selected['sections'][index]),
                  ),
                  SizedBox(height: 16),
                ],
              )
            : Container(),
      ],
    );
  }

  _FilterState(this.data, this.selected);
}
