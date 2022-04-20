
import 'package:railway_alert/Screens/Admin/admin_home_widget.dart';
import 'package:railway_alert/theme/app_shared_preferences_constant.dart';
import 'package:railway_alert/storage/cache/secure_storage_helper.dart';
import 'package:railway_alert/bloc_cubits/login_cubit/login_cubit.dart';
import 'package:railway_alert/bloc_cubits/home_cubit/home_cubit.dart';
import 'package:railway_alert/bloc_cubits/home_cubit/home_state.dart';
import 'package:railway_alert/routes/app_routes_names.dart';
import 'package:railway_alert/helper/dialog.helper.dart';
import 'package:railway_alert/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  getUserData() async {
    await SecStore.getValue(keyVal: SharedPreferencesConstant.DEPTID)
        .then((value) {
      context.read<HomeCubit>().getUser(value);
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
      body: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is HomeInitialState) {
              return DialogHelper.buildLoading();
            } else if (state is HomeLoading) {
              return DialogHelper.buildLoading();
            } else if (state is HomeSuccess) {
              return state.countData != null
                  ? AdminWidget(empData: state.countData!)
                  : Container();
            } else if (state is HomeFailure) {
              return Center(child: Text("${state.errorMessage}"));
            }
            return DialogHelper.buildLoading();
          }),
    );
  }
}
