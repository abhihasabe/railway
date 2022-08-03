import 'package:rapid_response/theme/app_shared_preferences_constant.dart';
import 'package:rapid_response/bloc_cubits/login_cubit/login_cubit.dart';
import 'package:rapid_response/bloc_cubits/login_cubit/login_state.dart';
import 'package:rapid_response/storage/cache/secure_storage_helper.dart';
import 'package:rapid_response/localization/app_localization.dart';
import 'package:rapid_response/widgets/input_field_widget.dart';
import 'package:rapid_response/routes/app_routes_names.dart';
import 'package:rapid_response/widgets/button_widget.dart';
import 'package:rapid_response/helper/dialog.helper.dart';
import 'package:rapid_response/theme/app_dimension.dart';
import 'package:rapid_response/widgets/text_widget.dart';
import 'package:rapid_response/widgets/logo_widget.dart';
import 'package:rapid_response/theme/app_colors.dart';
import 'package:rapid_response/network/network.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:formz/formz.dart';

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
              Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildLogo(),
                      const SizedBox(
                        height: 20,
                      ),
                      _buildContainer(state),
                    ],
                  ),
                ),
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
            height: MediaQuery.of(context).size.height * 0.47,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: SingleChildScrollView(
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
                                }
                                else {
                                  showToast(
                                    "Please Check Internet Connection",
                                    duration: const Duration(seconds: 3),
                                    position: ToastPosition.bottom,
                                    backgroundColor:
                                        Colors.black.withOpacity(0.8),
                                    radius: 13.0,
                                    textStyle: const TextStyle(fontSize: 14.0),
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
    dynamic depValue;
    await SecStore.getValue(keyVal: SharedPreferencesConstant.DEPTID)
        .then((deptId) {
      depValue = deptId;
      SecStore.getValue(keyVal: SharedPreferencesConstant.USERTYPEID)
          .then((userId) {
        SecStore.getValue(keyVal: SharedPreferencesConstant.ACTIVATION)
            .then((activation) {
          if (userId == "2" && activation == "1" && depValue == deptId) {
            VxNavigator.of(context).clearAndPush(Uri.parse(empHomeScreen));
          } else if (userId == "2" && activation == "0" && depValue == deptId) {
            DialogHelper.showToasts(
                "Please contact with admin for activate your Account");
            DialogHelper.dismissDialog(context);
          } else if (userId == "1" && activation == "1" && depValue == deptId) {
            SecStore.getValue(keyVal: SharedPreferencesConstant.DEPTID)
                .then((value) {
              VxNavigator.of(context).clearAndPush(Uri.parse(adminHomeScreen));
            });
          } else if (userId == "1" && activation == "0" && depValue == deptId) {
            DialogHelper.showToasts(
                "Please contact with super admin for activate your Account");
            DialogHelper.dismissDialog(context);
          } else if (userId == "0" && depValue == deptId) {
            SecStore.getValue(keyVal: SharedPreferencesConstant.DEPTID)
                .then((value) {
              VxNavigator.of(context)
                  .clearAndPush(Uri.parse(superAdminHomeScreen));
            });
          }
        });
      });
    });
  }
}
