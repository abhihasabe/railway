import 'package:rapid_response/theme/app_shared_preferences_constant.dart';
import 'package:rapid_response/storage/cache/secure_storage_helper.dart';
import 'package:rapid_response/bloc_cubits/login_cubit/login_cubit.dart';
import 'package:rapid_response/bloc_cubits/home_cubit/home_cubit.dart';
import 'package:rapid_response/bloc_cubits/home_cubit/home_state.dart';
import 'package:rapid_response/Screens/Admin/admin_home_widget.dart';
import 'package:rapid_response/routes/app_routes_names.dart';
import 'package:rapid_response/helper/dialog.helper.dart';
import 'package:rapid_response/theme/app_colors.dart';
import 'package:rapid_response/network/network.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapid_response/widgets/internet_connection_widget.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  var appTitle = "ADMIN";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserName();
    getUserData();
  }

  getUserName() async {
    await SecStore.getValue(keyVal: SharedPreferencesConstant.USERNAME)
        .then((value) {
      setState(() {
        appTitle = value;
      });
    });
  }

  getUserData() {
    Network().check().then((intenet) async {
      if (intenet != null && intenet) {
        await SecStore.getValue(keyVal: SharedPreferencesConstant.DEPTID)
            .then((value) {
          context.read<HomeCubit>().getUser(value);
        });
      } else {
        showToast(
          "Please Check Internet Connection",
          duration: const Duration(seconds: 3),
          position: ToastPosition.bottom,
          backgroundColor: Colors.black.withOpacity(0.8),
          radius: 13.0,
          textStyle: const TextStyle(fontSize: 14.0),
        );
        InternetConnection();
      }
    });
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
          getUserData();
        },
        child: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is HomeInitialState) {
                return Container();
              } else if (state is HomeLoading) {
                return DialogHelper.buildLoading();
              } else if (state is HomeSuccess) {
                return state.countData != null
                    ? AdminWidget(empData: state.countData!)
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
