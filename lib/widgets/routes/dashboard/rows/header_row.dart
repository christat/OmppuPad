import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:omppu_pad/styles.dart';

class HeaderRow extends StatelessWidget {
  HeaderRow(
      {Key key, @required this.useDarkTheme, @required this.onSwitchTheme})
      : super(key: key);

  final bool useDarkTheme;
  final Function onSwitchTheme;

  @override
  Widget build(BuildContext context) {
    return new Container(
        padding: EdgeInsets.only(bottom: Spacing.gutterMini),
        child: Row(
          children: <Widget>[
            new HeaderText(),
            new Padding(
              padding: EdgeInsets.only(right: Spacing.gutterMini),
              child: new Text('Night Mode',
                  style: Theme
                      .of(context)
                      .textTheme
                      .body1
                      .merge(new TextStyle(fontSize: FontSize.smallText))),
            ),
            new CupertinoSwitch(value: useDarkTheme, onChanged: onSwitchTheme)
          ],
        ));
  }
}

//TODO fix transition between Night Mode and normal with texts re-rendering weirdly
class HeaderText extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HeaderTextState();
}

enum MomentOfDay { morning, day, evening, night }

class _HeaderTextState extends State<HeaderText> {
  //Timer timer;
  MomentOfDay momentOfDay;

  _HeaderTextState() {
    //timer = new Timer.periodic(new Duration(minutes: 30), updateCurrentMomentOfDay);
  }

  void updateCurrentMomentOfDay(Timer timer) {
    var currentMomentOfDay = getCurrentMomentOfDay();
    if (momentOfDay != currentMomentOfDay) {
      this.setState(() => momentOfDay = currentMomentOfDay);
    }
  }

  MomentOfDay getCurrentMomentOfDay() {
    var hour = DateTime.now().hour;
    if (hour >= 21 || hour < 5) {
      return MomentOfDay.night;
    }
    if (hour >= 5 && hour < 11) {
      return MomentOfDay.morning;
    }
    if (hour >= 11 && hour < 17) {
      return MomentOfDay.day;
    }
    return MomentOfDay.evening;
  }

  String randomTextFromPool({List<String> pool}) {
    var randomIndex = new Random().nextInt(pool.length);
    return pool[randomIndex];
  }

  List<String> textPoolByTimeOfDay() {
    switch (momentOfDay) {
      case MomentOfDay.morning:
        return morningTextPool;
      case MomentOfDay.evening:
        return eveningTextPool;
      case MomentOfDay.night:
        return nightTextPool;
      default:
        return dayTextPool;
    }
  }

  static final List<String> morningTextPool = [
    'Good morning,',
    'Hyvää huomenta,',
    'Buenos días,',
    'Dzien dobry,',
    'Guten Morgen',
    'Bonjour,',
    'God morgon',
  ];

  static final List<String> dayTextPool = [
    'Hello again,',
    'Hi, Wish you have a nice day!'
  ];

  static final List<String> eveningTextPool = ['Good evening,'];

  static final List<String> nightTextPool = [
    'Still awake?',
    'Escaping for a night snack? ;)',
    'Hello, night owl.',
  ];

  static final List<String> helpTextPool = [
    'How can I help you?',
    "Check out the weather forecast!",
  ];

  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(
            "Home Dashboard",
            //randomTextFromPool(pool: textPoolByTimeOfDay()),
            style: Theme.of(context).textTheme.title,
          ),
          new Text(
            'Overview',
            //randomTextFromPool(pool: helpTextPool),
            style: Theme.of(context).textTheme.subhead,
          )
        ],
      ),
    );
  }
}
