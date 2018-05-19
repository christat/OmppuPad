import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:omppu_pad/utils/keychain.dart';
import 'package:omppu_pad/widgets/routes/dashboard/dashboard.dart';
import 'package:omppu_pad/styles.dart';

void main() async {
  // load keychain before app load
  new Keychain().loadKeys().then((v) {
    // Disable system bar
    SystemChrome.setEnabledSystemUIOverlays([]);
    // Lock orientation to landscape only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    runApp(new OmppuPad());
  }); 
  
}

// Root widget of the application
class OmppuPad extends StatefulWidget {
  @override
  _OmppuPadState createState() => new _OmppuPadState();
}

class _OmppuPadState extends State<OmppuPad> {
  static bool useDarkTheme;

  void onSwitchTheme(bool value) => this.setState(() => useDarkTheme = value);
  
  static bool isNight() {
    var hour = DateTime.now().hour;
    if (hour >= 21 || hour < 6) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    if (useDarkTheme == null) useDarkTheme = isNight();
    return new MaterialApp(
      title: 'Omppu Pad',
      // Global themes and other rules in styles.dart
      theme: useDarkTheme ? darkThemeData : lightThemeData, 
      home: new Dashboard(useDarkTheme: useDarkTheme, onSwitchTheme: onSwitchTheme),
    );
  }
}
