import 'package:rapid_response/Screens/super_admin/super_admin_home_screen.dart';
import 'package:rapid_response/Screens/authentication/forgot_password.dart';
import 'package:rapid_response/Screens/employee/Emoloyee_home_screen.dart';
import 'package:rapid_response/bloc_cubits/login_cubit/login_cubit.dart';
import 'package:rapid_response/Screens/authentication/login_screen.dart';
import 'package:rapid_response/Screens/authentication/auth_screen.dart';
import 'package:rapid_response/Screens/authentication/reg_screen.dart';
import 'package:rapid_response/Screens/Admin/admin_home_screen.dart';
import 'package:rapid_response/Screens/Admin/detail_screen.dart';
import 'package:rapid_response/Screens/employee/sms_screen.dart';
import 'package:rapid_response/controllers/MenuController.dart';
import 'package:rapid_response/repository/auth_repository.dart';
import 'package:rapid_response/routes/app_routes_names.dart';
import 'package:rapid_response/Screens/user_profile.dart';
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
    userProfileScreen: (uri, params) {
      return VxRoutePage(pageName: "userProfile", child: const UserProfile());
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
    forgetPasswordScreen: (uri, params) {
      return VxRoutePage(
          pageName: "Forget Password", child: const ForgotPassword());
    },
    smsScreen: (uri, params) {
      return VxRoutePage(pageName: "Employee Home", child: const SMSInbox());
    },
    registerScreen: (uri, params) {
      return VxRoutePage(pageName: "reg", child: const RegScreen());
    },
  });
}
