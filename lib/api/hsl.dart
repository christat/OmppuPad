import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

String stringListToString(List<String> list) =>
    list.map((string) => "\"$string\"").join(", ");

Future<List<Arrival>> queryStopArrivals(List<String> stopGtfsIds) async {
  http.Response response = await queryHSL("""
  {
    stops(ids: [${stringListToString(stopGtfsIds)}]) {
      gtfsId
      stoptimesWithoutPatterns {
        headsign
        realtime
        realtimeArrival
        scheduledArrival
        serviceDay
        trip{
          route {
            shortName
          }
        }
      }
    }  
  }
  """);
  return getArrivalsFromJson(utf8.decode(response.bodyBytes));
}

List<Arrival> getArrivalsFromJson(String jsonString) {
  List<Arrival> result = new List<Arrival>();
  json.decode(jsonString)['data']['stops'].forEach((stop) {
    for (var arrival in stop["stoptimesWithoutPatterns"]) {
      // WHY THE HELL DOES THIS FAIL WITH A MAP FN?!
      result.add(new Arrival(
          gtfsId: stop['gtfsId'],
          headsign: arrival['headsign'],
          realtime: arrival['realtime'],
          realtimeArrival: arrival['realtimeArrival'],
          scheduledArrival: arrival['scheduledArrival'],
          serviceDay: arrival['serviceDay'],
          shortName: arrival['trip']['route']['shortName'],
          ));
    }
  });
  return result;
}

class Arrival {
  final String gtfsId;
  final String headsign;
  final bool realtime;
  final int realtimeArrival;
  final int scheduledArrival;
  final int serviceDay;
  final String shortName;

  Arrival(
      {this.gtfsId,
      this.headsign,
      this.realtime,
      this.realtimeArrival,
      this.scheduledArrival,
      this.serviceDay,
      this.shortName});
}

// base boilerplate function to query the HSL/digitransit GraphQL API
Future<dynamic> queryHSL(String graphQl) async {
  return http.post(
      Uri.parse(
          'https://api.digitransit.fi/routing/v1/routers/hsl/index/graphql'),
      body: graphQl,
      headers: {'Content-Type': 'application/graphql'});
}
