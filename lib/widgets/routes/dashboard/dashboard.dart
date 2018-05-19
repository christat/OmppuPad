import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:omppu_pad/widgets/routes/dashboard/rows/body_row.dart';
import 'package:omppu_pad/widgets/routes/dashboard/rows/footer_row.dart';
import 'package:omppu_pad/widgets/routes/dashboard/rows/header_row.dart';

import 'package:omppu_pad/styles.dart';

class Dashboard extends StatelessWidget {
  Dashboard(
      {Key key, @required this.useDarkTheme, @required this.onSwitchTheme})
      : super(key: key);

  final bool useDarkTheme;
  final Function onSwitchTheme;

  @override
  Widget build(BuildContext context) {
    var palette = useDarkTheme ? Palette.dark : Palette.light;

    return new Container(
        decoration: new BoxDecoration(color: palette[Colorable.background]),
        padding: new EdgeInsets.all(Spacing.gutterMini),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new HeaderRow(
              useDarkTheme: useDarkTheme,
              onSwitchTheme: onSwitchTheme,
            ),
            new BodyRow(),
            new FooterRow()
          ],
        ));
  }
}
