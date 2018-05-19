import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:omppu_pad/styles.dart';

class ToggleSwitchCard extends StatelessWidget {
  final String label;
  final Function onToggle;

  ToggleSwitchCard({Key key, @required this.label, @required this.onToggle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Padding(
        padding: EdgeInsets.all(Spacing.gutterMini),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Text(label),
            new Switch(value: false, onChanged: (bool value) => onToggle(value))
          ],
        ),
      ),
    );
  }
}
