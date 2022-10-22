import 'package:rapid_response/bloc_cubits/reg_cubit/reg_cubit.dart';
import 'package:rapid_response/bloc_cubits/reg_cubit/reg_state.dart';
import 'package:rapid_response/models/railway_resp_model.dart';
import 'package:rapid_response/widgets/input_field_widget.dart';
import 'package:rapid_response/widgets/dropdown_widget.dart';
import 'package:rapid_response/routes/app_routes_names.dart';
import 'package:rapid_response/models/dept_resp_model.dart';
import 'package:rapid_response/widgets/button_widget.dart';
import 'package:rapid_response/helper/dialog.helper.dart';
import 'package:rapid_response/models/division_resp.dart';
import 'package:rapid_response/theme/app_dimension.dart';
import 'package:rapid_response/widgets/text_widget.dart';
import 'package:rapid_response/models/zone_resp.dart';
import 'package:rapid_response/theme/app_colors.dart';
import 'package:rapid_response/network/network.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:formz/formz.dart';

class RegScreen extends StatefulWidget {
  const RegScreen({Key? key}) : super(key: key);

  @override
  _RegScreenState createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  var brightness;
  List? railwayTypesResp = [];
  List? zoneTypesResp = [];
  List? divisionTypesResp = [];
  List? deptTypesResp = [];
  List<DeptData>? deptData;
  ZoneData? zoneResp;
  List<DivisionData>? divisionData;
  List<ZoneData>? zoneData;
  List<RailwayData>? railwayData;
  String? _railwayType = "",
      _zoneType = "",
      _divisionType = "",
      _companyType = "",
      _userType = "";
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool showValue = false;

  bool get isPopulated =>
      _userNameController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _confirmPasswordController.text.isNotEmpty &&
      showValue == true;

  List<String> users = ["Admin", "Employee"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    brightness = Brightness.light;
    getRailwayData();
  }

  getRailwayData() {
    context.read<RegCubit>().getRailwayType().then((value) {
      railwayData = value;
      value.forEach((element) {
        railwayTypesResp?.add(element.rname!);
      });
      setState(() {});
    });
  }

  getZoneData(selectedId) {
    context.read<RegCubit>().getZoneType(selectedId).then((value) {
      zoneData = value;
      value.forEach((element) {
        zoneResp = element;
        zoneTypesResp?.add(element.zname!);
      });
      setState(() {});
    });
  }

  getDivisionData(selectedId) {
    /*List<ZoneData> outputList =
        zoneData!.where((element) => element.zname == selectedId).toList();*/
    context.read<RegCubit>().getDivision(selectedId).then((value) {
      divisionData = value;
      value.forEach((element) {
        divisionTypesResp?.add(element.dname!);
      });
      setState(() {});
    });
  }

  getDeptData(selectedId) {
    context.read<RegCubit>().getDeptType(selectedId).then((value) {
      deptData = value;
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

  Widget _buildContainer(RegState state) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.93,
            width: MediaQuery.of(context).size.width * 0.9,
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
                      hintText: "Name*",
                      textCapitalization: TextCapitalization.sentences,
                      textInputType: TextInputType.name,
                      actionKeyboard: TextInputAction.next,
                      prefixIcon: const Icon(
                        Icons.person,
                        color: hoverColorDarkColor,
                      ),
                      errorMessage:
                          state.name.invalid ? "Please Enter Name" : null,
                      onChange: (name) =>
                          context.read<RegCubit>().nameChanged(name),
                      parametersValidate: "Please Enter Name",
                    ),
                    const SizedBox(height: DIMENSION_10),
                    InputTextFormFieldWidget(
                      controller: _emailController,
                      hintText: "Email",
                      textCapitalization: TextCapitalization.sentences,
                      textInputType: TextInputType.emailAddress,
                      actionKeyboard: TextInputAction.next,
                      prefixIcon: const Icon(
                        Icons.email,
                        color: hoverColorDarkColor,
                      ),
                      errorMessage:
                          state.email.invalid ? "Please Enter Email Id" : null,
                      onChange: (name) =>
                          context.read<RegCubit>().emailChanged(name),
                      parametersValidate: "Please Enter Email Id",
                    ),
                    const SizedBox(height: DIMENSION_10),
                    InputTextFormFieldWidget(
                      controller: _mobileNumberController,
                      hintText: "Phone No*",
                      textCapitalization: TextCapitalization.sentences,
                      textInputType: TextInputType.number,
                      actionKeyboard: TextInputAction.next,
                      prefixIcon: const Icon(
                        Icons.call,
                        color: hoverColorDarkColor,
                      ),
                      errorMessage:
                          state.number.invalid ? "Please Enter Number" : null,
                      onChange: (name) =>
                          context.read<RegCubit>().numberChanged(name),
                      parametersValidate: "Please Enter Number",
                    ),
                    const SizedBox(height: DIMENSION_10),
                    DropdownWidget(
                        context: context,
                        hintText: "Railway",
                        label: "Railway",
                        prefixIcon: const Icon(
                          Icons.account_balance,
                          color: hoverColorDarkColor,
                        ),
                        items: railwayTypesResp,
                        value: _railwayType,
                        onChoose: (newValue, index) {
                          setState(() {
                            _railwayType = newValue;
                            railwayData!.forEach((element) {
                              if (element.rname!.contains(newValue)) {
                                getZoneData(element.rId);
                              }
                            });
                            FocusScope.of(context).requestFocus(FocusNode());
                            context.read<RegCubit>().railwayChanged(index + 1);
                          });
                        },
                        errorMessage: state.dept.invalid
                            ? "Please Select Railway"
                            : null),
                    const SizedBox(height: DIMENSION_10),
                    DropdownWidget(
                      context: context,
                      hintText: "Zone",
                      label: "Zone",
                      prefixIcon: const Icon(
                        Icons.account_balance,
                        color: hoverColorDarkColor,
                      ),
                      items: zoneTypesResp,
                      value: _zoneType,
                      onChoose: (newValue, index) {
                        setState(() {
                          _zoneType = newValue;
                          zoneData!.forEach((element) {
                            if (element.zname!.contains(newValue)) {
                              getDivisionData(element.zid);
                            }
                          });
                          FocusScope.of(context).requestFocus(FocusNode());
                          context.read<RegCubit>().zoneChanged(index + 1);
                        });
                      },
                      errorMessage:
                          state.dept.invalid ? "Please Select Zone" : null,
                    ),
                    const SizedBox(height: DIMENSION_10),
                    DropdownWidget(
                      context: context,
                      hintText: "Division",
                      label: "Division",
                      prefixIcon: const Icon(
                        Icons.account_balance,
                        color: hoverColorDarkColor,
                      ),
                      items: divisionTypesResp,
                      value: _divisionType,
                      onChoose: (newValue, index) {
                        setState(() {
                          _divisionType = newValue;
                          divisionData!.forEach((element) {
                            if (element.dname!.contains(newValue)) {
                              getDeptData(element.dId);
                            }
                          });
                          FocusScope.of(context).requestFocus(FocusNode());
                          context.read<RegCubit>().divisionChanged(index + 1);
                        });
                      },
                      errorMessage:
                          state.dept.invalid ? "Please Select Division" : null,
                    ),
                    const SizedBox(height: DIMENSION_10),
                    DropdownWidget(
                      context: context,
                      hintText: "ART/ARME/SPART",
                      label: "ART/ARME/SPART",
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
                          deptData!.forEach((element) {
                            if (element.name!.contains(newValue)) {
                              context
                                  .read<RegCubit>()
                                  .deptChanged(element.id!.toInt());
                            }
                          });
                        });
                      },
                      errorMessage: state.dept.invalid
                          ? "Please Select ART/ARME/SPART"
                          : null,
                    ),
                    const SizedBox(height: DIMENSION_10),
                    DropdownWidget(
                      context: context,
                      hintText: "User Type*",
                      label: "User Type*",
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
                      errorMessage:
                          state.dept.invalid ? "Please Enter User Type." : null,
                    ),
                    const SizedBox(height: DIMENSION_10),
                    InputTextFormFieldWidget(
                      controller: _passwordController,
                      hintText: "Password*",
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
                          ? "Please Enter Password"
                          : null,
                      onChange: (name) =>
                          context.read<RegCubit>().passwordChanged(name),
                      parametersValidate: "Please Enter Password",
                    ),
                    const SizedBox(height: DIMENSION_10),
                    InputTextFormFieldWidget(
                      controller: _confirmPasswordController,
                      hintText: "Confirm Password*",
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
                          ? "Please Enter Confirm Password"
                          : null,
                      onChange: (name) => context
                          .read<RegCubit>()
                          .confirmPassword(name, _passwordController.text),
                      parametersValidate: "Please Enter Confirm Password",
                    ),
                    const SizedBox(height: DIMENSION_6),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: showValue,
                            onChanged: (value) async {
                              setState(() {
                                showValue = value!;
                              });
                            },
                          ),
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 18.0),
                                    child: Text("Terms & Condition"),
                                  ),
                                  content: SingleChildScrollView(
                                      child: Text(
                                          "1. The siron sound ringing in Mobile is depend on text message ring. If mobile didnot have network then there may be delay for siron sound.\n\n"
                                          "2. Always alerted for breakdown duties never depend on mobile phone siron.\n\n"
                                          "3. If you are in no network zone then inform it to your concern supervisor.\n\n"
                                          "4. Never switch off your mobile phone, it may lead to no siron sound from mobile.\n\n"
                                          "5. Always give all necessary permission required to app. If you denied permission then it will malfunction app or no siron sound from mobile.\n\n"
                                          "6. This app is developed for additional alerting system. Don't completely depend on this app.\n\n"
                                          "7. In order to use the Rapid Response APP for BD&DM, you must first agree to the terms and Condition. You may not use the Rapid Response App for BD&DM  if you do not accept the terms and conditions\n\n."
                                          "8. By clicking to accept and/or using this Rapid Response app for BD&DM, you hereby agree to the terms of the terms and conditions.\n\n"
                                          "9. During Downtime the Rapid Response App for BD&DM may malfunction or may not work.\n\n"
                                          "10. The Rapid Response App for BD&DM should update to latest version of App.\n\n"
                                          "11. App developer has rights to change or update terms and conditions.\n\n"
                                          "12. In order to use the Rapid Response APP for BD&DM, you must first agree to the terms and Condition. You may not use the Rapid Response App for BD&DM  if you do not accept the terms and conditions.\n\n"
                                          "13. By clicking to accept and/or using this Rapid Response app for BD&DM, you hereby agree to the terms of the terms and Conditions.\n\n"
                                          "14. The update may be provided either free or paid.")),
                                  actions: <Widget>[
                                    ElevatedButton(
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
                    const SizedBox(height: DIMENSION_6),
                    ButtonWidget(
                      width: double.infinity,
                      title: "SIGN UP",
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
                    const SizedBox(height: DIMENSION_10),
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
          text: "Already have an account?",
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
            text: "SIGN IN",
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
      text: "SIGN UP",
      big: true,
      bold: true,
      textColor:
          (brightness == Brightness.dark) ? primaryDarkColor : primaryColor,
    );
  }
}
