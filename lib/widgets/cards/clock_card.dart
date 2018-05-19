import 'dart:async';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

import 'package:omppu_pad/styles.dart';

class ClockCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ClockCardState();
}

class _ClockCardState extends State<ClockCard> {
  Timer timer;
  DateTime now = DateTime.now();

  _ClockCardState() {
    timer = new Timer.periodic(new Duration(seconds: 1), updateClock);
  }

  void updateClock(Timer timer) => this.setState(() => now = DateTime.now());

  final DateFormat hourFormat = new DateFormat('HH:mm');
  final DateFormat secondFormat = new DateFormat('ss');
  final DateFormat dateFormat = new DateFormat('EEEE, dd MMMM yyyy');

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 300.0, //TODO figure out relative card sizing
      width: 300.0,
      child: new Card(
          child: new Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                width:
                    150.0, //TODO don't fix sizes, instead figure out how to set margins and avoid tick movement
                child: new Text(
                    //TODO, split formatted time texts into separate components to minimize reload?????
                    hourFormat.format(now),
                    style: Theme
                        .of(context)
                        .textTheme
                        .body2
                        .merge(new TextStyle(fontSize: 50.0))),
              ),
              new Container(
                  margin: EdgeInsets.only(top: 10.0),
                  width: 20.0,
                  child: new Text(secondFormat.format(now),
                      style: Theme.of(context).textTheme.body2.merge(
                          new TextStyle(
                              fontSize: FontSize.smallText,
                              color: Colors.deepOrangeAccent))))
            ],
          ),
          new Padding(
              padding: EdgeInsets.only(top: Spacing.gutterMini),
              child: new Text(
                dateFormat.format(now),
                style: Theme
                    .of(context)
                    .textTheme
                    .body1
                    .merge(new TextStyle(fontSize: FontSize.subheadText)),
              ))
        ],
      )),
    );
  }
}
