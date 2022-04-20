import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railway_alert/Screens/Admin/detail_widget_screen.dart';
import 'package:railway_alert/bloc_cubits/home_cubit/home_cubit.dart';
import 'package:railway_alert/bloc_cubits/home_cubit/home_state.dart';
import 'package:railway_alert/helper/dialog.helper.dart';
import 'package:railway_alert/models/station_location_by_id_resp.dart';
import 'package:railway_alert/routes/app_routes_names.dart';
import 'package:railway_alert/storage/cache/secure_storage_helper.dart';
import 'package:railway_alert/theme/app_colors.dart';
import 'package:railway_alert/theme/app_shared_preferences_constant.dart';
import 'package:velocity_x/velocity_x.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({this.empId, Key? key}) : super(key: key);

  int? empId;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List<StationLocationData>? stationLocationByIdResp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.empId != null) {
      context.read<HomeCubit>().getUserLocation(widget.empId!);
      getUserData();
    }
  }

  getUserData() async {
    await SecStore.getValue(keyVal: SharedPreferencesConstant.DEPTID)
        .then((value) {
      context.read<HomeCubit>().getStationLocation(value).then((value) {
        print("object321 $value");
        stationLocationByIdResp = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: primaryColor,
            title: const Text(
              "Employee Detail",
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        body: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is HomeInitialState) {
                return DialogHelper.buildLoading();
              } else if (state is HomeLoading) {
                return DialogHelper.buildLoading();
              } else if (state is HomeDetailSuccess) {
                return state.countData != null
                    ? DetailWidgetScreen(
                        countData: state.countData,
                        stationLocationByIdResp: stationLocationByIdResp)
                    : Container();
              } else if (state is HomeFailure) {
                return Center(child: Text("${state.errorMessage}"));
              }
              return DialogHelper.buildLoading();
            }),
      ),
    );
  }

  _onWillPop() async {
    return await VxNavigator.of(context)
        .clearAndPush(Uri.parse(adminHomeScreen));
  }
}
