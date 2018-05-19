import 'package:flutter/material.dart';

import 'package:omppu_pad/widgets/cards/clock_card.dart';
import 'package:omppu_pad/widgets/cards/weather/weather_card.dart';

class BodyRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[new ClockCard(), new WeatherCard()],
      ),
    );
  }
}
