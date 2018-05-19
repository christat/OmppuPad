import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:omppu_pad/api/hue.dart';
import 'package:omppu_pad/styles.dart';

class LightsCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LightsCardState();
}

class _LightsCardState extends State<LightsCard> {
  bool enabled;
  bool bedroomEnabled;
  bool livingRoomEnabled;

  void onToggleSwitch(bool value, int hueGroup) {
    toggleLightsByGroup(value, hueGroup);
    this.setState(() {
      if (hueGroup == HUE_GROUP_ALL) {
        enabled = !enabled;
        bedroomEnabled = enabled;
        livingRoomEnabled = enabled;
      } else if (hueGroup == HUE_GROUP_BEDROOM) {
        bedroomEnabled = !bedroomEnabled;
        enabled = bedroomEnabled;
      } else { // living room
        livingRoomEnabled = !livingRoomEnabled;
        enabled = livingRoomEnabled;
      }
    });
  }

  Dialog buildLightsDialog(BuildContext context) {
    return new Dialog(
      child: new Container(
        width: 300.0,
        height: 285.0,
        child: Padding(
          padding: EdgeInsets.all(Spacing.gutterMini),
          child: new Column(
            children: <Widget>[
              new Text(
                'Toggle Room Lights',
                style: Theme.of(context).textTheme.body2
              ),
              new Divider(),
              new ToggleSwitchRow(
                title: 'Master Switch',
                value: enabled,
                onChanged: (value) => onToggleSwitch(value, HUE_GROUP_ALL),
              ),
              new ToggleSwitchRow(
                title: 'Bedroom',
                value: false,
                onChanged: (value) => onToggleSwitch(value, HUE_GROUP_BEDROOM),
              ),
              new ToggleSwitchRow(
                title: 'Living Room',
                value: false,
                onChanged: (value) => onToggleSwitch(value, HUE_GROUP_LIVING_ROOM),
              ),
              new Divider(),
              new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new OutlineButton(
                    textColor: Colors.deepOrangeAccent,
                    child: new Text('Close'),
                    onPressed: () => Navigator.pop(context)
                  )
                ],
              )
            ],
          ),
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Padding(
        padding: EdgeInsets.only(
          bottom: Spacing.gutterMini,
          left: Spacing.gutterMini,
          top: Spacing.gutterMini
        ),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Text('Lights'),
            new FutureBuilder<bool>(
              future: checkAnyLightsOn(),
              builder:
                  (BuildContext context, AsyncSnapshot<bool> snapshot) {
                enabled = false;
                if (snapshot.hasData) {
                  enabled = snapshot.data;
                  bedroomEnabled = snapshot.data;
                  livingRoomEnabled = snapshot.data; //TODO change async builder to check for each room
                }
                return new Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new CupertinoSwitch(
                      value: enabled,
                      onChanged: (value) => onToggleSwitch(value, HUE_GROUP_ALL),
                    ),
                    new IconButton(
                      icon: new Icon(Icons.more_vert),
                      onPressed: () => showDialog(
                        context: context,
                        builder: buildLightsDialog)
                    )
                  ]
                );
              })
          ])));
  }
}

class ToggleSwitchRow extends StatelessWidget {
  final String title;
  final bool value;
  final Function onChanged;

  ToggleSwitchRow({this.title, this.value, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.symmetric(vertical: Spacing.gutterMicro),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Text(title, style: Theme.of(context).textTheme.body1),
          new CupertinoSwitch(
            value: value,
            onChanged: onChanged,
          )
        ],
      )
    );
  }
}