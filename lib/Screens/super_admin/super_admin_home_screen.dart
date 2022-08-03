import 'package:oktoast/oktoast.dart';
import 'package:rapid_response/Screens/Admin/admin_home_widget.dart';
import 'package:rapid_response/Screens/super_admin/super_admin_home_widget.dart';
import 'package:rapid_response/network/network.dart';
import 'package:rapid_response/theme/app_shared_preferences_constant.dart';
import 'package:rapid_response/storage/cache/secure_storage_helper.dart';
import 'package:rapid_response/bloc_cubits/login_cubit/login_cubit.dart';
import 'package:rapid_response/bloc_cubits/home_cubit/home_cubit.dart';
import 'package:rapid_response/bloc_cubits/home_cubit/home_state.dart';
import 'package:rapid_response/routes/app_routes_names.dart';
import 'package:rapid_response/helper/dialog.helper.dart';
import 'package:rapid_response/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';

class SuperAdminHomeScreen extends StatefulWidget {
  const SuperAdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<SuperAdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<SuperAdminHomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Network().check().then((intenet) {
      if (intenet != null && intenet) {
        getUserData();
      } else {
        showToast(
          "Please Check Internet Connection",
          duration: const Duration(seconds: 3),
          position: ToastPosition.bottom,
          backgroundColor: Colors.black.withOpacity(0.8),
          radius: 13.0,
          textStyle: const TextStyle(fontSize: 14.0),
        );
      }
    });
  }

  getUserData() async {
    await SecStore.getValue(keyVal: SharedPreferencesConstant.DEPTID)
        .then((value) {
      context.read<HomeCubit>().getAdminUser(value);
    });
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
          "HOME",
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
      body: RefreshIndicator(
        displacement: 250,
        backgroundColor: primaryColor,
        color: Colors.white,
        strokeWidth: 3,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 2));
          Network().check().then((intenet) {
            if (intenet != null && intenet) {
              getUserData();
            } else {
              showToast(
                "Please Check Internet Connection",
                duration: const Duration(seconds: 3),
                position: ToastPosition.bottom,
                backgroundColor: Colors.black.withOpacity(0.8),
                radius: 13.0,
                textStyle: const TextStyle(fontSize: 14.0),
              );
            }
          });
        },
        child: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is HomeInitialState) {
                return DialogHelper.buildLoading();
              } else if (state is HomeLoading) {
                return DialogHelper.buildLoading();
              } else if (state is HomeSuccess) {
                return state.countData != null
                    ? SuperAdminWidget(empData: state.countData!)
                    : Container();
              } else if (state is HomeFailure) {
                return Center(child: Text("${state.errorMessage}"));
              }
              return Container();
            }),
      ),
    );
  }
}
