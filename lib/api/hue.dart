import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:omppu_pad/utils/keychain.dart';

const int HUE_GROUP_ALL = 0; // group containing all lights
const int HUE_GROUP_BEDROOM = 1;
const int HUE_GROUP_LIVING_ROOM = 2;
final keychain = new Keychain();

// toggles all lights on/off, defined by bool value.
void toggleLightsByGroup(bool switchOn, int group) async {
  http.put(
      Uri.parse('http://${keychain.hueBridgeAddress}/api/${keychain.hueAPIKey}/groups/$group/action'),
      body: '{"on": $switchOn}');
}

// returns true if at least one light is on
Future<bool> checkAnyLightsOn() async {
  http.Response response =
      await http.get(Uri.parse('http://${keychain.hueBridgeAddress}/api/${keychain.hueAPIKey}/groups/0'));

  if (response.statusCode == 200)
    return json.decode(response.body)['state']['any_on'];
    
  return true; // fallback for error
}
