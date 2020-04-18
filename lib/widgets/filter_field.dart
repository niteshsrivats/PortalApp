import 'package:flutter/material.dart';

class FilterField extends StatelessWidget {
  final List<String> data;
  final List<bool> selected;
  final Function onTap;

  const FilterField({Key key, this.data, this.selected, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ToggleButtons(
          children: [
            for (int i = 0; i < data.length; i++)
              Container(
                margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                decoration: BoxDecoration(
                  border: Border.all(color: selected[i] ? Colors.lightBlue : Colors.black54),
                  borderRadius: BorderRadius.all(Radius.circular(32)),
                  color: selected[i] ? Colors.lightBlue[50] : Colors.white,
                ),
                width: 75,
                child: Center(child: Text(data[i])),
              ),
          ],
          isSelected: selected,
          onPressed: (int index) => onTap(index),
          color: Colors.black54,
          selectedColor: Colors.black87,
          splashColor: Colors.transparent,
          renderBorder: false,
          fillColor: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
    );
  }
}
