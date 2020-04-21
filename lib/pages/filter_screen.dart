import 'package:college_main/widgets/filter.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  final Map<String, List<bool>> selected;
  final Map<String, List<String>> data;
  final String role;

  const FilterScreen({
    Key key,
    @required this.selected,
    @required this.data,
    @required this.role,
  }) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState(this.selected, this.data, this.role);
}

class _FilterScreenState extends State<FilterScreen> {
  final Map<String, List<bool>> selected;
  final Map<String, List<String>> data;
  final String role;

  _FilterScreenState(this.selected, this.data, this.role);

  handleReset() {
    this.setState(() {
      String year = data['years'][0];

      selected['public'][0] = true;
      selected['years'] = List.generate(data['years'].length, (int index) => false);

      bool isOddSemester = false;
      for (int i = 0; i < data['semesters'].length; i++) {
        if (data['semesters'][i].endsWith(year) && int.tryParse(data['semesters'][i][0]) % 2 == 1) {
          isOddSemester = true;
          break;
        }
      }
      selected['semesters'] = List.generate(
          data['semesters'].length,
          (int index) => data['semesters'][index].endsWith(year) && isOddSemester
              ? int.tryParse(data['semesters'][index][0]) % 2 == 1
              : true);
      if (role != 'admin') {
        selected['departments'][0] = true;
        selected['sections'] = List.generate(
            data['sections'].length,
            (int index) => data['sections'][index].endsWith(year) && isOddSemester
                ? int.tryParse(data['sections'][index][0]) % 2 == 1
                : true);
      } else {
        selected['departments'] = List.generate(data['departments'].length, (int index) => false);
      }
    });
  }

  handleApply() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 60),
            Filter(selected: widget.selected, data: widget.data, role: widget.role, type: 'feed'),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(width: 16),
                  Expanded(
                    child: RaisedButton(
                      elevation: 8,
                      child: Text("RESET"),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      color: Colors.white,
                      onPressed: handleReset,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: RaisedButton(
                      elevation: 8,
                      child: Text("APPLY"),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      color: Theme.of(context).primaryColor,
                      onPressed: handleApply,
                    ),
                  ),
                  SizedBox(width: 16),
                ],
              ),
            ),
            SizedBox(height: 32)
          ],
        ),
      ),
    );
  }
}
