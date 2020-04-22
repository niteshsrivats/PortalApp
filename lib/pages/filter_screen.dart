import 'package:college_main/widgets/filter.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  final Map<String, List<bool>> selected;
  final Map<String, List<String>> data;
  final String role;
  final Function reset, getPosts;

  const FilterScreen({
    Key key,
    @required this.selected,
    @required this.data,
    @required this.role,
    @required this.reset,
    @required this.getPosts,
  }) : super(key: key);

  @override
  _FilterScreenState createState() =>
      _FilterScreenState(this.selected, this.data, this.role, this.reset, this.getPosts);
}

class _FilterScreenState extends State<FilterScreen> {
  final Map<String, List<bool>> selected;
  final Map<String, List<String>> data;
  final String role;
  final Function reset, getPosts;

  _FilterScreenState(this.selected, this.data, this.role, this.reset, this.getPosts);

  handleReset() {
    this.setState(() {
      reset();
    });
  }

  handleApply() {
    getPosts();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
//      appBar: AppBar(
//        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 120),
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
