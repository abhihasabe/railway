import 'package:rapid_response/bloc_cubits/forget_password_cubit/forget_password_state.dart';
import 'package:rapid_response/bloc_cubits/forget_password_cubit/forget_password_cubit.dart';
import 'package:rapid_response/routes/app_routes_names.dart';
import 'package:rapid_response/widgets/input_field_widget.dart';
import 'package:rapid_response/helper/dialog.helper.dart';
import 'package:rapid_response/widgets/logo_widget.dart';
import 'package:rapid_response/widgets/text_widget.dart';
import 'package:rapid_response/theme/app_dimension.dart';
import 'package:rapid_response/theme/app_colors.dart';
import 'package:rapid_response/network/network.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../widgets/button_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:formz/formz.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _newsPasswordController = TextEditingController();

  bool get isPopulated =>
      _phoneNoController.text.isNotEmpty &&
      _newPasswordController.text.isNotEmpty &&
      _newsPasswordController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
            listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            DialogHelper.showToasts(state.exceptionError);
            DialogHelper.dismissDialog(context);
          } else if (state.status.isSubmissionSuccess) {
            DialogHelper.dismissDialog(context);
            DialogHelper.showToasts("Password Update Successfully");
            VxNavigator.of(context).clearAndPush(Uri.parse(loginScreen));
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
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _buildLogo(),
                          const SizedBox(height: 20),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.45,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(22.0),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(height: 10),
                                              Align(
                                                alignment: Alignment.center,
                                                child: TextWidget(
                                                  text: "FORGOT YOUR PASSWORD",
                                                  big: true,
                                                  bold: true,
                                                  textColor: primaryColor,
                                                ),
                                              ),
                                              SizedBox(height: 30),
                                              InputTextFormFieldWidget(
                                                key: const Key("mobileKey"),
                                                maxLine: ONE,
                                                controller: _phoneNoController,
                                                hintText: "Phone No*",
                                                textCapitalization:
                                                    TextCapitalization
                                                        .sentences,
                                                textInputType:
                                                    TextInputType.emailAddress,
                                                actionKeyboard:
                                                    TextInputAction.next,
                                                prefixIcon: const Icon(
                                                  Icons.phone_android,
                                                  color: hoverColorDarkColor,
                                                ),
                                                errorMessage: state
                                                        .number.invalid
                                                    ? "Please Enter Phone Number"
                                                    : null,
                                                onChange: (name) => context
                                                    .read<ForgetPasswordCubit>()
                                                    .mobileChanged(name),
                                                parametersValidate:
                                                    "Please Enter Phone Number",
                                              ),
                                              const SizedBox(
                                                  height: DIMENSION_12),
                                              InputTextFormFieldWidget(
                                                key:
                                                    const Key("newPasswordKey"),
                                                maxLine: ONE,
                                                controller:
                                                    _newPasswordController,
                                                hintText: "NEW PASSWORD*",
                                                textCapitalization:
                                                    TextCapitalization
                                                        .sentences,
                                                textInputType:
                                                    TextInputType.emailAddress,
                                                actionKeyboard:
                                                    TextInputAction.next,
                                                prefixIcon: const Icon(
                                                  Icons.lock,
                                                  color: hoverColorDarkColor,
                                                ),
                                                errorMessage: state
                                                        .nPassword.invalid
                                                    ? "Please Enter Valid Password"
                                                    : null,
                                                onChange: (name) => context
                                                    .read<ForgetPasswordCubit>()
                                                    .newPasswordChanged(name),
                                                parametersValidate:
                                                    "Please Enter Valid Password",
                                              ),
                                              const SizedBox(
                                                  height: DIMENSION_12),
                                              InputTextFormFieldWidget(
                                                key: const Key(
                                                    "newsPasswordKey"),
                                                maxLine: ONE,
                                                controller:
                                                    _newsPasswordController,
                                                hintText: "Confirm Password*",
                                                textCapitalization:
                                                    TextCapitalization
                                                        .sentences,
                                                textInputType:
                                                    TextInputType.emailAddress,
                                                actionKeyboard:
                                                    TextInputAction.done,
                                                prefixIcon: const Icon(
                                                  Icons.lock,
                                                  color: hoverColorDarkColor,
                                                ),
                                                errorMessage: state
                                                        .nsPassword.invalid
                                                    ? "Please Enter Valid Password"
                                                    : null,
                                                onChange: (name) => context
                                                    .read<ForgetPasswordCubit>()
                                                    .confirmPasswordChanged(name),
                                                parametersValidate:
                                                    "Please Enter Valid Password",
                                              ),
                                              const SizedBox(
                                                  height: DIMENSION_20),
                                              ButtonWidget(
                                                key: const Key("buttonKey"),
                                                width: double.infinity,
                                                title: "CHANGE PASSWORD",
                                                height: DIMENSION_42,
                                                bTitleBold: true,
                                                bgColor: buttonColor,
                                                textColor: buttonTextColor,
                                                disabledBgColor: disabledColor,
                                                disabledTextColor:
                                                    disabledTextColor,
                                                bTitleS: true,
                                                borderRadius: DIMENSION_5,
                                                onClick: isPopulated &&
                                                        state.status.isValidated
                                                    ? () {
                                                        Network()
                                                            .check()
                                                            .then((intenet) {
                                                          if (intenet != null &&
                                                              intenet) {
                                                            context
                                                                .read<
                                                                    ForgetPasswordCubit>()
                                                                .changePassword();
                                                          } else {
                                                            showToast(
                                                              "Please Check Internet Connection",
                                                              duration:
                                                                  const Duration(
                                                                      seconds:
                                                                          3),
                                                              position:
                                                                  ToastPosition
                                                                      .bottom,
                                                              backgroundColor:
                                                                  Colors.black
                                                                      .withOpacity(
                                                                          0.8),
                                                              radius: 13.0,
                                                              textStyle:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          14.0),
                                                            );
                                                          }
                                                        });
                                                      }
                                                    : null,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ))
                              ]),
                        ]),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

_buildLogo() {
  return const LogoWidget(
    header: false,
    challenge: false,
    small: true,
  );
}
