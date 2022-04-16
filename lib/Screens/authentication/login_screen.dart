import 'package:railway_alert/bloc_cubits/login_cubit/login_cubit.dart';
import 'package:railway_alert/bloc_cubits/login_cubit/login_state.dart';
import 'package:railway_alert/localization/app_localization.dart';
import 'package:railway_alert/network/network.dart';
import 'package:railway_alert/routes/app_routes.dart' as route;
import 'package:railway_alert/routes/app_routes.dart';
import 'package:railway_alert/routes/app_routes_names.dart';
import 'package:railway_alert/storage/cache/secure_storage_helper.dart';
import 'package:railway_alert/theme/app_shared_preferences_constant.dart';
import 'package:railway_alert/widgets/input_field_widget.dart';
import 'package:railway_alert/helper/snackbar_helper.dart';
import 'package:railway_alert/widgets/logo_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railway_alert/widgets/button_widget.dart';
import 'package:railway_alert/helper/dialog.helper.dart';
import 'package:railway_alert/theme/app_dimension.dart';
import 'package:railway_alert/widgets/text_widget.dart';
import 'package:railway_alert/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:oktoast/oktoast.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var brightness;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    brightness = MediaQueryData.fromWindow(WidgetsBinding.instance!.window)
        .platformBrightness;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xfff2f3f7),
        body: BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            DialogHelper.showToasts(state.exceptionError);
            DialogHelper.dismissDialog(context);
          } else if (state.status.isSubmissionSuccess) {
            DialogHelper.showToasts("Login Successfully");
            callScreen();
          } else if (state.status.isSubmissionInProgress) {
            DialogHelper.showLoaderDialog(context);
          }
        }, builder: (context, state) {
          return Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xff2470c7),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLogo(),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildContainer(state),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }

  _buildSignUpText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextWidget(
          text: AppLocalization.of(context)?.translate('dnhaa'),
          small: true,
          textColor:
              (brightness == Brightness.dark) ? textDarkColor : textColor,
        ),
        const SizedBox(width: DIMENSION_5),
        InkWell(
          onTap: () {
            VxNavigator.of(context).push(Uri.parse(registerScreen));
          },
          child: TextWidget(
            text: AppLocalization.of(context)?.translate('signup'),
            small: true,
            bold: true,
            textColor: (brightness == Brightness.dark)
                ? primaryDarkColor
                : primaryColor,
          ),
        ),
      ],
    );
  }

  _buildTitleWidget() {
    return TextWidget(
      key: const Key("titleKey"),
      text: AppLocalization.of(context)?.translate('signin'),
      big: true,
      bold: true,
      textColor:
          (brightness == Brightness.dark) ? primaryDarkColor : primaryColor,
    );
  }

  Widget _buildContainer(LoginState state) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.55,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildTitleWidget(),
                  const SizedBox(height: DIMENSION_30),
                  InputTextFormFieldWidget(
                    key: const Key("emailKey"),
                    maxLine: ONE,
                    controller: _emailController,
                    hintText: AppLocalization.of(context)?.translate('email'),
                    textCapitalization: TextCapitalization.sentences,
                    textInputType: TextInputType.emailAddress,
                    actionKeyboard: TextInputAction.next,
                    prefixIcon: const Icon(
                      Icons.email,
                      color: hoverColorDarkColor,
                    ),
                    errorMessage: state.email.invalid
                        ? AppLocalization.of(context)?.translate('peveid')
                        : null,
                    onChange: (name) =>
                        context.read<LoginCubit>().emailChanged(name),
                    parametersValidate:
                        AppLocalization.of(context)?.translate('peeid'),
                  ),
                  const SizedBox(height: DIMENSION_12),
                  InputTextFormFieldWidget(
                    key: const Key("passwordKey"),
                    controller: _passwordController,
                    hintText:
                        AppLocalization.of(context)?.translate('password'),
                    textCapitalization: TextCapitalization.sentences,
                    textInputType: TextInputType.text,
                    actionKeyboard: TextInputAction.done,
                    obscureText: true,
                    showSuffixIcon: true,
                    maxLine: ONE,
                    suffixIcon: const Icon(Icons.visibility,
                        color: hoverColorDarkColor),
                    prefixIcon:
                        const Icon(Icons.lock, color: hoverColorDarkColor),
                    errorMessage: state.password.invalid
                        ? AppLocalization.of(context)?.translate('pepass')
                        : null,
                    onChange: (name) =>
                        context.read<LoginCubit>().passwordChanged(name),
                    parametersValidate:
                        AppLocalization.of(context)?.translate('pepass'),
                  ),
                  const SizedBox(height: DIMENSION_25),
                  ButtonWidget(
                    key: const Key("buttonKey"),
                    width: double.infinity,
                    title: AppLocalization.of(context)?.translate('signin'),
                    height: DIMENSION_42,
                    bTitleBold: true,
                    bgColor: (brightness == Brightness.dark)
                        ? buttonDarkColor
                        : buttonColor,
                    textColor: (brightness == Brightness.dark)
                        ? buttonDarkTextColor
                        : buttonTextColor,
                    disabledBgColor: (brightness == Brightness.dark)
                        ? disabledDarkColor
                        : disabledColor,
                    disabledTextColor: (brightness == Brightness.dark)
                        ? disabledTextDarkColor
                        : disabledTextColor,
                    bTitleS: true,
                    borderRadius: DIMENSION_5,
                    onClick: isPopulated && state.status.isValidated
                        ? () {
                            Network().check().then((intenet) {
                              if (intenet != null && intenet) {
                                context.read<LoginCubit>().userLogin();
                              } else {
                                showToast(
                                  "Please Check Internet Connection",
                                  duration: const Duration(seconds: 3),
                                  position: ToastPosition.bottom,
                                  backgroundColor:
                                      Colors.black.withOpacity(0.8),
                                  radius: 13.0,
                                  textStyle: const TextStyle(fontSize: 18.0),
                                );
                              }
                            });
                          }
                        : null,
                  ),
                  const SizedBox(
                    height: DIMENSION_10,
                  ),
                  _buildSignUpText()
                ],
              ),
            ),
          ))
    ]);
  }

  _buildLogo() {
    return const LogoWidget(
      header: false,
      challenge: false,
      small: true,
    );
  }

  callScreen() async {
    await SecStore.getValue(keyVal: SharedPreferencesConstant.USERTYPEID)
        .then((userType) {
      SecStore.getValue(keyVal: SharedPreferencesConstant.ACTIVATION)
          .then((activation) {
        if (userType == "1" && activation == "1") {
          VxNavigator.of(context).push(Uri.parse(adminHomeScreen));
        } else if (userType == "1" && activation == "0") {
          DialogHelper.showToasts(
              "Please Contact With Admin for activate your Account");
        } else {
          VxNavigator.of(context).push(Uri.parse(empHomeScreen));
        }
      });
    });
  }
}
