import 'package:rapid_response/theme/app_shared_preferences_constant.dart';
import 'package:rapid_response/storage/cache/secure_storage_helper.dart';
import 'package:rapid_response/models/station_location_by_id_resp.dart';
import 'package:rapid_response/Screens/Admin/detail_widget_screen.dart';
import 'package:rapid_response/bloc_cubits/home_cubit/home_state.dart';
import 'package:rapid_response/bloc_cubits/home_cubit/home_cubit.dart';
import 'package:rapid_response/routes/app_routes_names.dart';
import 'package:rapid_response/helper/dialog.helper.dart';
import 'package:rapid_response/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';
import 'dart:async';

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
      onWillPop: () => onWillPop(),
      child: RefreshIndicator(
        displacement: 250,
        backgroundColor: primaryColor,
        color: Colors.white,
        strokeWidth: 3,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 2));
          if (widget.empId != null) {
            context.read<HomeCubit>().getUserLocation(widget.empId!);
            getUserData();
          }
        },
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
      ),
    );
  }

  onWillPop() async {
    return await VxNavigator.of(context)
        .clearAndPush(Uri.parse(adminHomeScreen));
  }
}
