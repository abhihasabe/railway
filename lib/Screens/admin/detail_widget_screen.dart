import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:rapid_response/models/address_resp_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'package:rapid_response/models/station_location_by_id_resp.dart';
import 'package:rapid_response/storage/cache/secure_storage_helper.dart';
import 'package:rapid_response/theme/app_shared_preferences_constant.dart';

class DetailWidgetScreen extends StatefulWidget {
  DetailWidgetScreen({Key? key, this.countData, this.stationLocationByIdResp})
      : super(key: key);
  List<AddressData>? countData;
  List<StationLocationData>? stationLocationByIdResp;

  @override
  State<DetailWidgetScreen> createState() => _DetailWidgetScreenState();
}

class _DetailWidgetScreenState extends State<DetailWidgetScreen> {
  List<Placemark>? newPlace;
  String? address;
  double? distance;

  bool isPresent = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.countData != null && widget.countData!.length > 0) setAddress();
  }

  setAddress() async {
    newPlace = await placemarkFromCoordinates(
        double.parse(widget.countData![widget.countData!.length - 1].latitude!),
        double.parse(
            widget.countData![widget.countData!.length - 1].longitude!));
    Placemark placeMark = newPlace![0];
    String? name = placeMark.name;
    String? subLocality = placeMark.subLocality;
    String? locality = placeMark.locality;
    String? administrativeArea = placeMark.administrativeArea;
    String? postalCode = placeMark.postalCode;
    String? country = placeMark.country;
    setState(() {
      address =
          "${name}, ${subLocality}, ${locality}, ${administrativeArea} ${postalCode}, ${country}";
    });

    if (widget.stationLocationByIdResp != null && widget.countData != null) {
      distance = Geolocator.distanceBetween(
          double.parse(widget.stationLocationByIdResp![0].deptLocationLat!),
          double.parse(widget.stationLocationByIdResp![0].deptLocationLong!),
          double.parse(
              widget.countData![widget.countData!.length - 1].latitude!),
          double.parse(
              widget.countData![widget.countData!.length - 1].longitude!));

      setState(() {
        distance;
      });

      String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

      if (widget.countData![widget.countData!.length - 1].time
                  ?.substring(0, 10)
                  ?.contains(formattedDate) ==
              true &&
          distance! <= 100.0 &&
          SecStore.getValue(keyVal: SharedPreferencesConstant.ISPRESENT) ==
              "") {
        setState(() {
          SecStore.setValue(
              keyVal: SharedPreferencesConstant.ISPRESENT, value: "true");
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const SizedBox(height: 30),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Attendance : ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(
                SecStore.getValue(
                            keyVal: SharedPreferencesConstant.ISPRESENT) ==
                        "true"
                    ? "Available"
                    : "Unavailable",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: SecStore.getValue(
                                keyVal: SharedPreferencesConstant.ISPRESENT) ==
                            "true"
                        ? Colors.green
                        : Colors.red)),
          ],
        ),
        const SizedBox(height: 30),
        const Text("Employee Current Location :",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Text(
          address != null ? "$address" : "Data Not Found",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          "Employee Current Location in KM : ",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        distance != null
            ? Text(
                "${(distance! / 1000).toStringAsFixed(2)} Km",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              )
            : Text(
                "0 Km",
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              )
      ]),
    );
  }
}
