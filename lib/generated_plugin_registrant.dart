//
// Generated file. Do not edit.
//

// ignore_for_file: directives_ordering
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: depend_on_referenced_packages

import 'package:assets_audio_player_web/web/assets_audio_player_web.dart';
import 'package:connectivity_plus_web/connectivity_plus_web.dart';
import 'package:flutter_secure_storage_web/flutter_secure_storage_web.dart';
import 'package:flutter_sms/flutter_sms_web.dart';
import 'package:geolocator_web/geolocator_web.dart';
import 'package:url_launcher_web/url_launcher_web.dart';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

// ignore: public_member_api_docs
void registerPlugins(Registrar registrar) {
  AssetsAudioPlayerWebPlugin.registerWith(registrar);
  ConnectivityPlusPlugin.registerWith(registrar);
  FlutterSecureStorageWeb.registerWith(registrar);
  FlutterSmsPlugin.registerWith(registrar);
  GeolocatorPlugin.registerWith(registrar);
  UrlLauncherPlugin.registerWith(registrar);
  registrar.registerMessageHandler();
}
