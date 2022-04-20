import 'package:railway_alert/bloc_cubits/address_cubit/address_cubit.dart';
import 'package:railway_alert/theme/app_shared_preferences_constant.dart';
import 'package:railway_alert/bloc_cubits/login_cubit/login_cubit.dart';
import 'package:railway_alert/storage/cache/secure_storage_helper.dart';
import 'package:background_location/background_location.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:railway_alert/routes/app_routes_names.dart';
import 'package:railway_alert/widgets/button_widget.dart';
import 'package:railway_alert/theme/app_dimension.dart';
import 'package:railway_alert/helper/dialog.helper.dart';
import 'package:railway_alert/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:telephony/telephony.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'dart:async';

final assetsAudioPlayer = AssetsAudioPlayer();

onBackgroundMessage(SmsMessage message) {
  debugPrint("onBackgroundMessage called $message");
  callRing(message);
}

void callRing(SmsMessage message) {
  if (message.body!.contains("SPARMV SUR Ordered")) {
    if (assetsAudioPlayer.isPlaying == true) {
      assetsAudioPlayer.stop();
    }
    playLocal();
  }
}

playLocal() async {
  await assetsAudioPlayer.open(Audio("assets/audios/song1.mp3"),
      autoStart: true);
  assetsAudioPlayer.play();
}

class EmployeeHomeScreen extends StatefulWidget {
  const EmployeeHomeScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<EmployeeHomeScreen> {
  String _message = "";
  final telephony = Telephony.instance;
  String latitude = 'waiting...';
  String longitude = 'waiting...';
  String time = 'waiting...';
  String? address;
  var id;
  bool start = false;
  List<Placemark>? newPlace;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
    getData();
  }

  setAddress() async {
    newPlace = await placemarkFromCoordinates(
        double.parse(latitude), double.parse(longitude));

    Placemark placeMark = newPlace![0];
    String? name = placeMark.name;
    String? subLocality = placeMark.subLocality;
    String? locality = placeMark.locality;
    String? administrativeArea = placeMark.administrativeArea;
    String? postalCode = placeMark.postalCode;
    String? country = placeMark.country;
    address =
        "${name}, ${subLocality}, ${locality}, ${administrativeArea} ${postalCode}, ${country}";
  }

  getData() async {
    id = await SecStore.getValue(keyVal: SharedPreferencesConstant.EMPLOYEEID);
  }

  onMessage(SmsMessage message) async {
    setState(() {
      _message = message.body ?? "Error reading message body.";
      callRing(message);
    });
  }

  void callRing(SmsMessage message) {
    if (message.body!.contains("SPARMV SUR Ordered")) {
      playLocal();
    }
  }

  Future<void> initPlatformState() async {
    final bool? result = await telephony.requestPhoneAndSmsPermissions;
    if (result != null && result) {
      telephony.listenIncomingSms(
          onNewMessage: onMessage, onBackgroundMessage: onBackgroundMessage);
    }
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        leading:
            const Icon(Icons.account_circle, color: Colors.white, size: 32),
        title: const Text(
          "EMPLOYEE",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
                iconSize: 24,
                onPressed: () {
                  context.read<LoginCubit>().logout();
                  VxNavigator.of(context).clearAndPush(Uri.parse(loginScreen));
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                )),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Center(
              child: ButtonWidget(
                key: const Key("buttonKey"),
                width: 210,
                height: DIMENSION_34,
                title: start == false ? "START" : "STOP",
                bgColor: start == false ? Colors.green : Colors.red,
                textColor: Colors.white,
                disabledBgColor: start == false ? Colors.green : Colors.red,
                disabledTextColor: Colors.white,
                bTitleSmaller: true,
                bTitleBold: true,
                borderRadius: DIMENSION_5,
                onClick: () async {
                  await BackgroundLocation.setAndroidConfiguration(1000);
                  await BackgroundLocation.startLocationService(
                      distanceFilter: 0);
                  BackgroundLocation.getLocationUpdates((location) {
                    setState(() {
                      latitude = location.latitude.toString();
                      longitude = location.longitude.toString();
                      time = DateTime.fromMillisecondsSinceEpoch(
                              location.time!.toInt())
                          .toString();
                      DialogHelper.showLoaderDialog(context);
                      isLoading = true;
                      if (isLoading == true) {
                        Navigator.pop(context);
                        getLocation(latitude, longitude, time);
                        setAddress();
                        isLoading = false;
                      }
                      Timer.periodic(const Duration(seconds: 180), (Timer t) {
                        if (latitude != null &&
                            longitude != null &&
                            time != null) {
                          getLocation(latitude, longitude, time);
                          setAddress();
                        }
                      });
                    });
                  });
                  setState(() {
                    start = true;
                  });
                },
              ),
            ),
          ),
          address != null
              ? Padding(
                  padding:
                      const EdgeInsets.only(top: 22.0, left: 12, right: 12),
                  child: Text(
                    "$address",
                    textAlign: TextAlign.center,
                  ),
                )
              : Container(),
          Center(
              child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              "Time : $time",
              textAlign: TextAlign.center,
            ),
          )),
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Center(
              child: ButtonWidget(
                key: const Key("buttonKey"),
                width: 210,
                height: DIMENSION_34,
                title: "SHOW RECEIVED SMS",
                bgColor: primaryColor,
                textColor: Colors.white,
                disabledBgColor: start == false ? Colors.green : Colors.red,
                disabledTextColor: Colors.white,
                bTitleSmaller: true,
                bTitleBold: true,
                borderRadius: DIMENSION_5,
                onClick: () async {
                  VxNavigator.of(context).push(Uri.parse(smsScreen));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getLocation(String latitude, String location, String time) {
    if (latitude != null && longitude != null) {
      print("latitude $latitude");
      print("longitude $longitude");
      print("time $time");
      getDataa(latitude, longitude, time);
    }
  }

  void getDataa(String latitude, String longitude, String time) {
    context
        .read<AddressCubit>()
        .addAddress(latitude, longitude, time, id)
        .then((value) {
      print("value $value");
    });
  }
}
