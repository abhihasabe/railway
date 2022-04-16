import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railway_alert/Screens/admin/EmployeeWidget.dart';
import 'package:railway_alert/bloc_cubits/home_cubit/home_cubit.dart';
import 'package:railway_alert/bloc_cubits/home_cubit/home_state.dart';
import 'package:railway_alert/helper/dialog.helper.dart';
import 'package:railway_alert/storage/cache/secure_storage_helper.dart';
import 'package:railway_alert/theme/app_shared_preferences_constant.dart';

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
    await SecStore.getValue(keyVal: SharedPreferencesConstant.DEPTTYPE)
        .then((value) {
      context.read<HomeCubit>().getUser(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is HomeInitialState) {
              return DialogHelper.buildLoading();
            } else if (state is HomeLoading) {
              return DialogHelper.buildLoading();
            } else if (state is HomeSuccess) {
              return state.countData != null
                  ? EmployeeWidget(empData: state.countData!)
                  : Container();
            } else if (state is HomeFailure) {
              return Center(child: Text("${state.errorMessage}"));
            }
            return DialogHelper.buildLoading();
          }),
    );
  }
}
