import 'package:rapid_response/bloc_cubits/address_cubit/address_cubit.dart';
import 'package:rapid_response/theme/app_shared_preferences_constant.dart';
import 'package:rapid_response/bloc_cubits/login_cubit/login_cubit.dart';
import 'package:rapid_response/storage/cache/secure_storage_helper.dart';
import 'package:background_location/background_location.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:rapid_response/routes/app_routes_names.dart';
import 'package:rapid_response/widgets/button_widget.dart';
import 'package:rapid_response/theme/app_dimension.dart';
import 'package:rapid_response/helper/dialog.helper.dart';
import 'package:rapid_response/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:telephony/telephony.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'dart:async';

final assetsAudioPlayer = AssetsAudioPlayer();

onBackgroundMessage(SmsMessage message) {
  callRing(message);
}

void callRing(SmsMessage message) {
  if (message.body!.contains("Brakedown Train Ordered")) {
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
  var empId;
  bool start = false;
  List<Placemark>? newPlace;
  bool isLoading = false;
  var appTitle = "EMPLOYEE";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserName();
    initPlatformState();
    getData();
  }

  getUserName() async {
    await SecStore.getValue(keyVal: SharedPreferencesConstant.USERNAME)
        .then((value) {
      setState(() {
        appTitle = value;
      });
    });
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
    empId =
        await SecStore.getValue(keyVal: SharedPreferencesConstant.EMPLOYEEID);
  }

  onMessage(SmsMessage message) async {
    setState(() {
      _message = message.body ?? "Error reading message body.";
      callRing(message);
    });
  }

  void callRing(SmsMessage message) {
    if (message.body!.contains("Brakedown Train Ordered")) {
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
        leading: IconButton(
            icon: Icon(Icons.account_circle),
            color: Colors.white,
            iconSize: 32,
            onPressed: () {
              VxNavigator.of(context).push(Uri.parse(userProfileScreen));
            }),
        title: Text(
          appTitle,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
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
      body: RefreshIndicator(
        displacement: 250,
        backgroundColor: primaryColor,
        color: Colors.white,
        strokeWidth: 3,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 2));
          getData();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Card(
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: Center(
                        child: ButtonWidget(
                          key: const Key("buttonKey"),
                          width: 210,
                          height: DIMENSION_34,
                          title: start == false
                              ? "START LOCATION"
                              : "STOP LOCATION",
                          bgColor: start == false ? Colors.green : Colors.red,
                          textColor: Colors.white,
                          disabledBgColor:
                              start == false ? Colors.green : Colors.red,
                          disabledTextColor: Colors.white,
                          bTitleSmaller: true,
                          bTitleBold: true,
                          borderRadius: DIMENSION_5,
                          onClick: () async {
                            if (start == false) {
                              await BackgroundLocation.setAndroidConfiguration(
                                  1000);
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
                                    setLocation(latitude, longitude, time);
                                    setAddress();
                                    isLoading = false;
                                  }
                                  Timer.periodic(const Duration(seconds: 180),
                                      (Timer t) {
                                    if (latitude != null &&
                                        longitude != null &&
                                        time != null) {
                                      //getLocation(latitude, longitude, time);
                                      setAddress();
                                    }
                                  });
                                });
                              });
                            }
                            setState(() {
                              start == false ? start = true : start = false;
                            });
                          },
                        ),
                      ),
                    ),
                    address != null
                        ? Padding(
                            padding: const EdgeInsets.only(
                                top: 22.0, left: 12, right: 12),
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
                    const SizedBox(
                      height: 5,
                    ),
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
                          disabledBgColor:
                              start == false ? Colors.green : Colors.red,
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
                    const SizedBox(
                      height: 5,
                    ),
                  ]),
                )),
          ],
        ),
      ),
    );
  }

  void setLocation(String latitude, String location, String time) {
    if (latitude != null && longitude != null) {
      context.read<AddressCubit>().addAddress(latitude, longitude, time, empId);
    }
  }
}
