import 'package:railway_alert/bloc_cubits/reg_cubit/reg_cubit.dart';
import 'package:railway_alert/bloc_cubits/reg_cubit/reg_state.dart';
import 'package:railway_alert/localization/app_localization.dart';
import 'package:railway_alert/network/network.dart';
import 'package:railway_alert/utils/age_data.dart';
import 'package:railway_alert/widgets/dropdown_widget.dart';
import 'package:railway_alert/widgets/input_field_widget.dart';
import 'package:railway_alert/routes/app_routes_names.dart';
import 'package:railway_alert/helper/snackbar_helper.dart';
import 'package:railway_alert/widgets/button_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railway_alert/helper/dialog.helper.dart';
import 'package:railway_alert/widgets/logo_widget.dart';
import 'package:railway_alert/theme/app_dimension.dart';
import 'package:railway_alert/widgets/text_widget.dart';
import 'package:oktoast/oktoast.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:railway_alert/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

class RegScreen extends StatefulWidget {
  const RegScreen({Key? key}) : super(key: key);

  @override
  _RegScreenState createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  var brightness;
  List<String>? deptTypesResp = [];
  String? _companyType = "", _userType = "";
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool showValue = false;

  bool get isPopulated =>
      _userNameController.text.isNotEmpty &&
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _confirmPasswordController.text.isNotEmpty &&
      showValue == true;

  getUserType(BuildContext context) {
    return medicineType = [
      AppLocalization.of(context)!.translate('liquid')!,
      AppLocalization.of(context)!.translate('tablet')!
    ];
  }

  List<String> users = ["admin", "Employee"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    brightness = MediaQueryData.fromWindow(WidgetsBinding.instance!.window)
        .platformBrightness;
    getData();
  }

  getData() {
    context.read<RegCubit>().getDeptType().then((value) {
      value.forEach((element) {
        deptTypesResp?.add(element.name!);
      });
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<RegCubit, RegState>(listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            DialogHelper.showToasts(state.exceptionError);
            DialogHelper.dismissDialog(context);
          } else if (state.status.isSubmissionSuccess) {
            DialogHelper.showToasts("Registration Successfully");
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
              Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //_buildLogo(),
                      const SizedBox(height: 20),
                      _buildContainer(state)
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

  _buildLogo() {
    return const LogoWidget(
      header: false,
      challenge: false,
      small: true,
    );
  }

  Widget _buildContainer(RegState state) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.93,
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
                    const SizedBox(height: DIMENSION_20),
                    InputTextFormFieldWidget(
                      controller: _userNameController,
                      hintText: AppLocalization.of(context)!.translate('uname'),
                      textCapitalization: TextCapitalization.sentences,
                      textInputType: TextInputType.name,
                      actionKeyboard: TextInputAction.next,
                      prefixIcon: const Icon(
                        Icons.person,
                        color: hoverColorDarkColor,
                      ),
                      errorMessage: state.name.invalid
                          ? AppLocalization.of(context)!.translate('peuname')
                          : null,
                      onChange: (name) =>
                          context.read<RegCubit>().nameChanged(name),
                      parametersValidate:
                          AppLocalization.of(context)!.translate('peuname'),
                    ),
                    const SizedBox(height: DIMENSION_10),
                    InputTextFormFieldWidget(
                      controller: _emailController,
                      hintText: AppLocalization.of(context)!.translate('email'),
                      textCapitalization: TextCapitalization.sentences,
                      textInputType: TextInputType.emailAddress,
                      actionKeyboard: TextInputAction.next,
                      prefixIcon: const Icon(
                        Icons.email,
                        color: hoverColorDarkColor,
                      ),
                      errorMessage: state.email.invalid
                          ? AppLocalization.of(context)!.translate('peeid')
                          : null,
                      onChange: (name) =>
                          context.read<RegCubit>().emailChanged(name),
                      parametersValidate:
                          AppLocalization.of(context)!.translate('peeid'),
                    ),
                    const SizedBox(height: DIMENSION_10),
                    InputTextFormFieldWidget(
                      controller: _mobileNumberController,
                      hintText: AppLocalization.of(context)!.translate('pno'),
                      textCapitalization: TextCapitalization.sentences,
                      textInputType: TextInputType.number,
                      actionKeyboard: TextInputAction.next,
                      prefixIcon: const Icon(
                        Icons.call,
                        color: hoverColorDarkColor,
                      ),
                      errorMessage: state.number.invalid
                          ? AppLocalization.of(context)!.translate('peno')
                          : null,
                      onChange: (name) =>
                          context.read<RegCubit>().numberChanged(name),
                      parametersValidate:
                          AppLocalization.of(context)!.translate('peno'),
                    ),
                    const SizedBox(height: DIMENSION_10),
                    DropdownWidget(
                      context: context,
                      hintText: AppLocalization.of(context)!.translate('dpty'),
                      label: AppLocalization.of(context)!.translate('dpty'),
                      prefixIcon: const Icon(
                        Icons.account_balance,
                        color: hoverColorDarkColor,
                      ),
                      items: deptTypesResp,
                      value: _companyType,
                      onChoose: (newValue, index) {
                        setState(() {
                          _companyType = newValue;
                          FocusScope.of(context).requestFocus(FocusNode());
                          context.read<RegCubit>().deptChanged(index + 1);
                        });
                      },
                      errorMessage: state.dept.invalid
                          ? AppLocalization.of(context)!.translate('psd')!
                          : null,
                    ),
                    const SizedBox(height: DIMENSION_20),
                    DropdownWidget(
                      context: context,
                      hintText: AppLocalization.of(context)!.translate('uty'),
                      label: AppLocalization.of(context)!.translate('uty'),
                      prefixIcon: const Icon(
                        Icons.account_balance,
                        color: hoverColorDarkColor,
                      ),
                      items: users,
                      value: _userType,
                      onChoose: (newValue, index) {
                        setState(() {
                          _userType = newValue;
                          FocusScope.of(context).requestFocus(FocusNode());
                          context.read<RegCubit>().userTypeChanged(index + 1);
                        });
                      },
                      errorMessage: state.dept.invalid
                          ? AppLocalization.of(context)!.translate('peut')!
                          : null,
                    ),
                    const SizedBox(height: DIMENSION_20),
                    InputTextFormFieldWidget(
                      controller: _passwordController,
                      hintText:
                          AppLocalization.of(context)!.translate('password'),
                      textCapitalization: TextCapitalization.sentences,
                      textInputType: TextInputType.text,
                      actionKeyboard: TextInputAction.next,
                      obscureText: true,
                      showSuffixIcon: true,
                      maxLine: ONE,
                      suffixIcon: const Icon(Icons.visibility,
                          color: hoverColorDarkColor),
                      prefixIcon:
                          const Icon(Icons.lock, color: hoverColorDarkColor),
                      errorMessage: state.password.invalid
                          ? AppLocalization.of(context)!.translate('pepass')
                          : null,
                      onChange: (name) =>
                          context.read<RegCubit>().passwordChanged(name),
                      parametersValidate:
                          AppLocalization.of(context)!.translate('pepass'),
                    ),
                    const SizedBox(height: DIMENSION_10),
                    InputTextFormFieldWidget(
                      controller: _confirmPasswordController,
                      hintText: AppLocalization.of(context)!.translate('cpass'),
                      textCapitalization: TextCapitalization.sentences,
                      textInputType: TextInputType.text,
                      actionKeyboard: TextInputAction.done,
                      obscureText: false,
                      showSuffixIcon: false,
                      maxLine: ONE,
                      suffixIcon: const Icon(Icons.visibility,
                          color: hoverColorDarkColor),
                      prefixIcon:
                          const Icon(Icons.lock, color: hoverColorDarkColor),
                      errorMessage: state.confirmPassword.invalid
                          ? AppLocalization.of(context)!.translate('pecpass')
                          : null,
                      onChange: (name) => context
                          .read<RegCubit>()
                          .confirmPassword(name, _passwordController.text),
                      parametersValidate:
                          AppLocalization.of(context)!.translate('pecpass'),
                    ),
                    const SizedBox(height: DIMENSION_10),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Checkbox(
                        value: showValue,
                        onChanged: (value) async {
                          setState(() {
                            showValue = value!;
                            print("object $showValue");
                          });
                        },
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 18.0),
                                child: Text("Terms & Condition"),
                              ),
                              content: SingleChildScrollView(
                                child: Text(
                                    "1) The siron sound ringing in Mobile is depend on text message ring. If mobile didnot have network then there may be delay for siron sound.\n\n"
                                    "2) Always alerted for breakdown duties never depend on mobile phone siron.\n\n"
                                    "3) If you are in no network zone then inform it to your concern supervisor.\n\n"
                                    "4) Never switch off your mobile phone, it may lead to no siron sound from mobile.\n\n"
                                    "5) Always give all necessary permission required to app. If you denied permission then it will malfunction app or no siron sound from mobile.\n\n"
                                    "6) This app is developed for additional alerting system. Donot completely depend on this app."),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: Text("okay"),
                                ),
                              ],
                            ),
                          );
                        },
                        child: TextWidget(
                          text: "Agree to Terms & Conditions",
                          small: true,
                        ),
                      )
                    ]),
                    const SizedBox(height: DIMENSION_20),
                    ButtonWidget(
                      width: double.infinity,
                      title: AppLocalization.of(context)!.translate('signup'),
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
                                  context.read<RegCubit>().userReg();
                                } else {
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
                    _buildSignUpText(brightness)
                  ],
                ),
              ),
            ),
          ))
    ]);
  }

  _buildSignUpText(brightness) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextWidget(
          text: AppLocalization.of(context)!.translate('ahaacc'),
          small: true,
          textColor:
              (brightness == Brightness.dark) ? textDarkColor : textColor,
        ),
        const SizedBox(width: DIMENSION_5),
        InkWell(
          onTap: () {
            VxNavigator.of(context).push(Uri.parse(loginScreen));
          },
          child: TextWidget(
            text: AppLocalization.of(context)!.translate('signin'),
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
      text: AppLocalization.of(context)!.translate('signup'),
      big: true,
      bold: true,
      textColor:
          (brightness == Brightness.dark) ? primaryDarkColor : primaryColor,
    );
  }
}
