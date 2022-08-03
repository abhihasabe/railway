import 'package:rapid_response/routes/app_routes.dart'as route;
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:rapid_response/theme/app_colors.dart';
import 'package:flutter/material.dart';

class FloatingButton {
  static SpeedDial buildSpeedDial(
      var userType, Brightness brightness, BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.add_event,
      elevation: 0,
      animatedIconTheme: const IconThemeData(size: 28.0),
      backgroundColor: (brightness == Brightness.dark)
          ? floatingActionButtonThemeDarkColor
          : floatingActionButtonColor,
      foregroundColor: (brightness == Brightness.dark)
          ? floatingActionButtonThemeDarkIconColor
          : floatingActionButtonIconColor,
      visible: true,
      curve: Curves.bounceInOut,
      children: [
        if (userType != "Patient")
          SpeedDialChild(
            child: const Icon(Icons.airline_seat_flat, color: Colors.white),
            backgroundColor: (brightness == Brightness.dark)
                ? floatingActionButtonThemeDarkColor
                : floatingActionButtonColor,
            onTap: () {
              //Navigator.of(context).pushNamed(route.addPatientScreen);
            },
            label: 'Add Patient',
            labelStyle: const TextStyle(
                fontWeight: FontWeight.w500, color: Colors.white),
            labelBackgroundColor: Colors.black,
          ),
        SpeedDialChild(
          child:
              const Icon(Icons.medical_services_outlined, color: Colors.white),
          backgroundColor: (brightness == Brightness.dark)
              ? floatingActionButtonThemeDarkColor
              : floatingActionButtonColor,
          onTap: () {
            //Navigator.of(context).pushNamed(route.addMedicineScreen);
          },
          label: 'Add Medicine',
          labelStyle:
              const TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          labelBackgroundColor: Colors.black,
        ),
        SpeedDialChild(
          child: const Icon(Icons.book, color: Colors.white),
          backgroundColor: (brightness == Brightness.dark)
              ? floatingActionButtonThemeDarkColor
              : floatingActionButtonColor,
          onTap: () {
            //Navigator.of(context).pushNamed(route.addMeasureScreen);
          },
          label: 'Add Measure',
          labelStyle:
              const TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          labelBackgroundColor: Colors.black,
        )
      ],
    );
  }
}
