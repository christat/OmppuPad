import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:omppu_pad/icons.dart';
import 'package:omppu_pad/styles.dart';

class MusicCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Padding(
          padding: EdgeInsets.all(1.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new HeaderButtons(),
              new SongInfo(title: "El Pastor", artist: 'Delta Sleep'),
              new ProgressBar(),
              new PlaybackControls()
            ],
          )),
    );
  }
}

class HeaderButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new IconButton(
              icon: new Icon(Icons.search),
              onPressed: () => print('TODO handle search')),
          new IconButton(
              icon: new Icon(Icons.more_vert),
              onPressed: () => print('TODO handle options'))
        ]);
  }
}

class SongInfo extends StatelessWidget {
  final String title;
  final String artist;

  SongInfo({this.title, this.artist});

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Padding(
            padding: EdgeInsets.symmetric(
                vertical: 4.0, horizontal: Spacing.gutterMini),
            child: new Text(
              title, //TODO animate overflow to scroll back and forth
              style: Theme.of(context).textTheme.body2,
              overflow: TextOverflow.fade,
              softWrap: false,
            )),
        new Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacing.gutterMini),
            child: new Text(
              artist,
              style: Theme
                  .of(context)
                  .textTheme
                  .body1
                  .merge(new TextStyle(fontSize: 13.0)),
              overflow: TextOverflow.fade,
              softWrap: false,
            ))
      ],
    );
  }
}

class ProgressBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  @override
  Widget build(BuildContext context) {
    return new Slider(
      activeColor: Theme.of(context).textTheme.body2.color,
      value: 0.5,
      onChanged: (val) => print('slider changed'),
    );
  }
}

class PlaybackControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).textTheme.body2.color;
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new ShuffleButton(
            isEnabled: true, onPressed: () => print('todo shuffle')),
        new IconButton(
            iconSize: 20.0,
            icon: new Icon(CustomIcons.prevSong, color: color),
            onPressed: () => print('todo prev')),
        new PlaybackButton(
            isPaused: false, onPressed: () => print('todo play/pause')),
        new IconButton(
            iconSize: 20.0,
            icon: new Icon(CustomIcons.nextSong, color: color),
            onPressed: () => print('todo next')),
        new RepeatButton(
            repeatMode: Repeat.off, onPressed: () => print('todo repeat'))
      ],
    );
  }
}

class PlaybackButton extends StatelessWidget {
  final bool isPaused;
  final Function onPressed;

  PlaybackButton({this.isPaused, this.onPressed});

  Widget getIcon(Color color) {
    if (isPaused) {
      return new Icon(CustomIcons.pause, size: 25.0, color: color);
    }
    return new Padding(
        padding: EdgeInsets.only(left: 4.0),
        child: new Icon(CustomIcons.play, size: 25.0, color: color));
  }

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).textTheme.body2.color;
    return new IconButton(
        iconSize: 45.0,
        onPressed: onPressed,
        icon: new Container(
            height: 45.0,
            width: 45.0,
            decoration: new BoxDecoration(
                shape: BoxShape.circle,
                border: new Border.all(
                  color: color,
                  width: 1.0,
                )),
            child: getIcon(color)));
  }
}

class ShuffleButton extends StatelessWidget {
  final bool isEnabled;
  final Function onPressed;

  ShuffleButton({this.isEnabled, this.onPressed});

  Widget getIconButton(Color color, double iconSize) {
    return new IconButton(
        iconSize: iconSize,
        icon: new Icon(CustomIcons.shuffle, color: color),
        onPressed: onPressed);
  }

  Widget getActiveIconButton(Color color, double iconSize) {
    return new Stack(
      children: <Widget>[
        getIconButton(color, iconSize),
        new Positioned(
          top: 35.0,
          left: 20.0,
          child: new Container(
            width: 4.0,
            height: 4.0,
            decoration: new BoxDecoration(shape: BoxShape.circle, color: color),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var color =
        isEnabled ? Palette.musicGreen : Theme.of(context).iconTheme.color;

    var iconSize = 20.0;
    return isEnabled
        ? getActiveIconButton(color, iconSize)
        : getIconButton(color, iconSize);
  }
}

enum Repeat { all, one, off }

class RepeatButton extends StatelessWidget {
  final Repeat repeatMode;
  final Function onPressed;
  final double iconSize = 22.0;

  RepeatButton({this.repeatMode, this.onPressed});

  Widget getActiveIconButton(Color color) {
    return new Stack(
      children: getButtonWithActiveOverlays(color),
    );
  }

  List<Widget> getButtonWithActiveOverlays(Color color) {
    var list = new List<Widget>();
    list.add(getIconButton(color));
    if (repeatMode != Repeat.off) {
      list.add(getRepeatDotOverlay());
    }
    if (repeatMode == Repeat.one) {
      list.add(getRepeatOneOverlay());
    }
    return list;
  }

  Widget getRepeatDotOverlay() {
    return new Positioned(
      top: 35.0,
      right: 22.5,
      child: new Container(
        width: 4.0,
        height: 4.0,
        decoration: new BoxDecoration(
            shape: BoxShape.circle, color: Palette.musicGreen),
      ),
    );
  }

  Widget getRepeatOneOverlay() {
    if (repeatMode != Repeat.one) return null;
    return new Positioned(
        top: 20.0,
        right: 18.0,
        child: new Container(
          height: 8.0,
          width: 8.0,
          child: new Text(
            '1',
            style: new TextStyle(color: Palette.musicGreen, fontSize: 6.0, fontWeight: FontWeight.bold),
          )
        ));
  }

  Widget getIconButton(Color color) {
    return new IconButton(
        iconSize: iconSize,
        icon: new Icon(CustomIcons.repeat, color: color),
        onPressed: onPressed);
  }

  @override
  Widget build(BuildContext context) {
    var color = repeatMode != Repeat.off
        ? Palette.musicGreen
        : Theme.of(context).iconTheme.color;

    return repeatMode == Repeat.off
        ? getIconButton(color)
        : getActiveIconButton(color);
  }
}
