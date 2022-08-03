import 'package:rapid_response/Screens/Admin/detail_screen.dart';
import 'package:rapid_response/Screens/localization_screen/lang_screen.dart';
import 'package:rapid_response/Screens/employee/Emoloyee_home_screen.dart';
import 'package:rapid_response/Screens/super_admin/super_admin_home_screen.dart';
import 'package:rapid_response/bloc_cubits/login_cubit/login_cubit.dart';
import 'package:rapid_response/Screens/authentication/login_screen.dart';
import 'package:rapid_response/Screens/authentication/auth_screen.dart';
import 'package:rapid_response/Screens/authentication/reg_screen.dart';
import 'package:rapid_response/Screens/Admin/admin_home_screen.dart';
import 'package:rapid_response/Screens/employee/sms_screen.dart';
import 'package:rapid_response/controllers/MenuController.dart';
import 'package:rapid_response/repository/auth_repository.dart';
import 'package:rapid_response/routes/app_routes_names.dart';
import 'package:rapid_response/Screens/profile_screen.dart';
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
          pageName: "admin Home", child: const AdminHomeScreen());
    },
    superAdminHomeScreen: (uri, params) {
      return VxRoutePage(
          pageName: "super admin Home", child: const SuperAdminHomeScreen());
    },
    adminDetailScreen: (uri, params) {
      final empId = int.parse(uri.queryParameters['id'] ?? "1");
      return VxRoutePage(
          pageName: "admin Home", child: DetailScreen(empId: empId));
    },
    empHomeScreen: (uri, params) {
      return VxRoutePage(
          pageName: "Employee Home", child: const EmployeeHomeScreen());
    },
    smsScreen: (uri, params) {
      return VxRoutePage(pageName: "Employee Home", child: const SMSInbox());
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
