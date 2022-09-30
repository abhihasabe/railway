import 'package:rapid_response/bloc_cubits/forget_password_cubit/forget_password_cubit.dart';
import 'package:rapid_response/bloc_cubits/address_cubit/address_cubit.dart';
import 'package:rapid_response/bloc_cubits/login_cubit/login_cubit.dart';
import 'package:rapid_response/bloc_cubits/auth_cubit/auth_cubit.dart';
import 'package:rapid_response/bloc_cubits/home_cubit/home_cubit.dart';
import 'package:rapid_response/bloc_cubits/reg_cubit/reg_cubit.dart';
import 'package:rapid_response/repository/address_repository.dart';
import 'package:rapid_response/repository/forget_repository.dart';
import 'package:rapid_response/repository/home_repository.dart';
import 'package:rapid_response/repository/auth_repository.dart';
import 'package:rapid_response/routes/app_routes.dart';
import 'package:rapid_response/theme/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  ForgetPasswordCubit(ForgetPasswordRepository())),
          BlocProvider(create: (context) => AddressCubit(AddressRepository())),
          BlocProvider(create: (context) => LoginCubit(AuthRepository())),
          BlocProvider(create: (context) => HomeCubit(HomeRepository())),
          BlocProvider(create: (context) => RegCubit(AuthRepository())),
          BlocProvider(create: (context) => AuthCubit()..isSignedIn()),
        ],
        child: MaterialApp.router(
          title: 'Rapid Response For BD&DM',
          debugShowCheckedModeBanner: false,
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          routeInformationParser: VxInformationParser(),
          routerDelegate: Routes.routerDelegate,
        ),
      ),
    );
  }
}
