import 'package:geolocator/geolocator.dart';
import 'package:railway_alert/models/address_resp_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'package:railway_alert/models/station_location_by_id_resp.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.countData != null) setAddress();
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

    distance = Geolocator.distanceBetween(
        double.parse(widget.stationLocationByIdResp![0].deptLocationLat!),
        double.parse(widget.stationLocationByIdResp![0].deptLocationLong!),
        double.parse(widget.countData![widget.countData!.length - 1].latitude!),
        double.parse(
            widget.countData![widget.countData!.length - 1].latitude!));

    print("distance ${distance!.roundToDouble()}");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const SizedBox(height: 30),
        const Text("Current Location :", style: TextStyle(fontSize: 16)),
        const SizedBox(height: 10),
        Text(
          address != null ? "$address" : "No Data Found",
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(
          height: 30,
        ),
        Text("Distance Between Current Location & Actual Location :",
            textAlign: TextAlign.center),
        distance != null
            ? Text(
                "${distance!.roundToDouble()}",
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              )
            : Text(
                "No Data Found",
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              )
      ]),
    );
  }
}
