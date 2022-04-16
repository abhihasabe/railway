import 'package:railway_alert/Screens/authentication/auth_screen.dart';
import 'package:railway_alert/Screens/authentication/login_screen.dart';
import 'package:railway_alert/Screens/authentication/reg_screen.dart';
import 'package:railway_alert/Screens/admin/admin_home_screen.dart';
import 'package:railway_alert/Screens/employee/Emoloyee_home_screen.dart';
import 'package:railway_alert/Screens/localization_screen/lang_screen.dart';
import 'package:railway_alert/Screens/profile_screen.dart';
import 'package:railway_alert/bloc_cubits/login_cubit/login_cubit.dart';
import 'package:railway_alert/controllers/MenuController.dart';
import 'package:railway_alert/repository/auth_repository.dart';
import 'package:railway_alert/routes/app_routes_names.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:provider/provider.dart';

class Routes {
  static VxNavigator routerDelegate = VxNavigator(routes: {
    initialScreen: (uri, params) {
      return VxRoutePage(pageName: "auth", child: const AuthScreen());
    },
    loginScreen: (uri, params) {
      return VxRoutePage(pageName: "login", child: const LoginScreen());
    },
    adminHomeScreen: (uri, params) {
      return VxRoutePage(
          pageName: "Admin Home", child: const AdminHomeScreen());
    },
    empHomeScreen: (uri, params) {
      return VxRoutePage(
          pageName: "Employee Home", child: const EmployeeHomeScreen());
    },
    registerScreen: (uri, params) {
      return VxRoutePage(pageName: "reg", child: const RegScreen());
    },
    chooseLangScreen: (uri, params) {
      return VxRoutePage(pageName: "Languages", child: const LangScreen());
    },
    settingScreen: (uri, params) {
      return VxRoutePage(
          pageName: "Auth",
          child: BlocProvider<LoginCubit>(
              create: (context) => LoginCubit(AuthRepository()),
              child: const ProfileScreen()));
    },
    langScreen: (uri, params) {
      return VxRoutePage(
          pageName: "lang",
          child: ChangeNotifierProvider(
              create: (context) => MenuController(),
              child: const LangScreen()));
    },
  });
}
