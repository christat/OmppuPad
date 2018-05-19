# OmppuPad

Smart home control center/Dashboard written in Flutter.

## About

The idea for this project started with an old iPad 2 (2011) laying around at home.
The main goal was to repurpose it and have an excuse to test drive [Flutter](https://flutter.io/).

Eventually, the project has expanded to become a smart home hub for personal use:

![alt text](https://github.com/christat/OmppuPad/blob/master/example/omppu_pad.png "Dashboard screenshot")


Overall, it's impressive how quick and easily one can build fairly elaborate apps with Flutter. :fireworks:

## Features

- Weather forecast through [OpenWeatherMap API](https://openweathermap.org/forecast5) (Key required)
- Finnish Public Transport routing API from [HSL Open Data](https://digitransit.fi/en/developers/apis/1-routing-api/)
- Philips [Hue API](https://www.developers.meethue.com/philips-hue-api) Light per-room light switches (Key, bridge address required)
- Dark mode toggle
- Device battery indicator (app is fullscreen)
- Spotify integration (WIP)

## Configuration

For the application to work as intended, a configuration file `keychain.yml` needs to
be provided under the `lib/assets` folder, with the following contents:

```yaml
hue_api_key: <key>
hue_bridge_addr: <bridge addr>
open_weather_map_api_key: <key>
```

## Work In Progress

- [ ] Spotify Beta Remote API Integration

## Wishlist

This app is far from something deployable.
Namely, lots of configuration options are locked down to preset values, such as:

- [ ] stops to be queried for (cards could have an options button with a modal)
- [ ] Choose city for date and forecast (same as above)
- [ ] Automagic discovery of Hue bridge and API Key
- [ ] Have actual commercial Keys to the APIs and adjust to licenses

## License

MIT




