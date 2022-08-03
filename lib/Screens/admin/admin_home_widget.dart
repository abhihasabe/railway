import 'package:flutter_sms/flutter_sms.dart';
import 'package:rapid_response/bloc_cubits/home_cubit/home_cubit.dart';
import 'package:rapid_response/helper/dialog.helper.dart';
import 'package:rapid_response/network/network.dart';
import 'package:rapid_response/routes/app_routes_names.dart';
import 'package:rapid_response/widgets/button_widget.dart';
import 'package:rapid_response/models/emp_resp_model.dart';
import 'package:rapid_response/theme/app_dimension.dart';
import 'package:rapid_response/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminWidget extends StatefulWidget {
  AdminWidget({Key? key, this.empData}) : super(key: key);
  List<EmpData>? empData;

  @override
  State<AdminWidget> createState() => _AdminWidgetState();
}

class _AdminWidgetState extends State<AdminWidget> {
  var brightness;
  List<bool>? isChecked;
  List<String> userChecked = [];
  bool isCheck = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    brightness = MediaQueryData.fromWindow(WidgetsBinding.instance!.window)
        .platformBrightness;
    isChecked = List.generate(widget.empData!.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: widget.empData?.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      ListTile(
                          leading: Checkbox(
                            value: isChecked![index],
                            onChanged: (checked) {
                              setState(
                                () {
                                  isChecked![index] = checked!;
                                  _onSelected(checked, widget.empData![index]);
                                },
                              );
                            },
                          ),
                          title: InkWell(
                            child: Text(
                              widget.empData![index].name!,
                              style: const TextStyle(
                                  color: textColor, fontSize: 16),
                            ),
                            onTap: () {
                              VxNavigator.of(context).push(Uri(
                                  path: adminDetailScreen,
                                  queryParameters: {
                                    "id": widget.empData![index].id!.toString()
                                  }));
                            },
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              widget.empData![index].activation != 0
                                  ? ButtonWidget(
                                      key: const Key("buttonKey"),
                                      width: 120,
                                      height: DIMENSION_24,
                                      title: "Activated",
                                      bgColor: Colors.green,
                                      textColor: Colors.white,
                                      disabledBgColor: Colors.green,
                                      disabledTextColor: Colors.white,
                                      bTitleSmaller: true,
                                      bTitleBold: true,
                                      borderRadius: DIMENSION_5,
                                      onClick: () {
                                        setState(() {});
                                        context
                                            .read<HomeCubit>()
                                            .dUpdateActivation(
                                                widget.empData![index].id!)
                                            .then((value) {
                                          VxNavigator.of(context)
                                              .push(Uri.parse(adminHomeScreen));
                                        });
                                      })
                                  : ButtonWidget(
                                      key: const Key("buttonKey"),
                                      title: "Deactivated",
                                      width: 120,
                                      height: DIMENSION_24,
                                      bTitleSmaller: true,
                                      bTitleBold: true,
                                      bgColor: Colors.red,
                                      textColor: Colors.white,
                                      disabledBgColor: Colors.red,
                                      disabledTextColor: Colors.white,
                                      borderRadius: DIMENSION_5,
                                      onClick: () {
                                        setState(() {});
                                        context
                                            .read<HomeCubit>()
                                            .updateActivation(
                                                widget.empData![index].id!)
                                            .then((value) {
                                          VxNavigator.of(context)
                                              .push(Uri.parse(adminHomeScreen));
                                        });
                                      },
                                    ),
                              SizedBox(width: 12),
                              InkWell(
                                child: Icon(Icons.arrow_forward_ios_sharp),
                                onTap: () {
                                  VxNavigator.of(context).push(Uri(
                                      path: adminDetailScreen,
                                      queryParameters: {
                                        "id": widget.empData![index].id!
                                            .toString()
                                      }));
                                },
                              ),
                            ],
                          )),
                      const Divider()
                    ],
                  );
                }),
          ),
          Container(
            color: Colors.black12,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(
                  child: isCheck == false
                      ? const Padding(
                          padding: EdgeInsets.only(left: 38.0),
                          child: Text(
                            "CHECK ALL",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                                fontSize: 16),
                          ),
                        )
                      : const Padding(
                          padding: EdgeInsets.only(left: 38.0),
                          child: Text(
                            "UNCHECK ALL",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: secondaryColor,
                                fontSize: 16),
                          ),
                        ),
                  onPressed: () {
                    if (isCheck == false) {
                      setState(() {
                        for (var i = 0; i < widget.empData!.length; i++) {
                          if (widget.empData![i].activation == 1) {
                            isChecked![i] = true;
                            _onSelected(isChecked![i], widget.empData![i]);
                          }
                        }
                        setState(() {
                          isCheck = true;
                        });
                      });
                    } else {
                      setState(() {
                        for (var i = 0; i < widget.empData!.length; i++) {
                          isChecked![i] = false;
                        }
                        userChecked.clear();
                        setState(() {
                          isCheck = false;
                        });
                      });
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 18.0),
                  child: ButtonWidget(
                    key: const Key("buttonKey"),
                    width: 160,
                    height: DIMENSION_34,
                    title: "Send Message",
                    bgColor: primaryColor,
                    textColor: Colors.white,
                    disabledBgColor: primaryColor,
                    disabledTextColor: Colors.white,
                    bTitleSmaller: true,
                    bTitleBold: true,
                    borderRadius: DIMENSION_5,
                    onClick: () {
                      if (userChecked.isNotEmpty) {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text(
                              "Are you sure you want to send SMS?",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              FlatButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                  Network().check().then((intenet) {
                                    if (intenet != null && intenet) {
                                      DialogHelper.buildLoading();
                                      _sendOnlineSMS("Brakedown Train Ordered",
                                          userChecked);
                                    } else {
                                      _sendOfflineSMS("Brakedown Train Ordered",
                                          userChecked);
                                    }
                                  });
                                },
                                child: Text(
                                  "Send",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        DialogHelper.showToasts("Please select Employee");
                      }
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _onSelected(bool selected, EmpData empData) {
    if (selected == true) {
      setState(() {
        userChecked.add(empData.phone!);
        print("userChecked $userChecked");
      });
    } else {
      setState(() {
        userChecked.remove(empData.phone!);
        print("userChecked $userChecked");
      });
    }
  }

  void _sendOfflineSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
  }

  void _sendOnlineSMS(String message, List<String> recipents) async {
    var url =
        "http://websms.textidea.com/app/smsapi/index.php?key=4626BC02A8CFD8&campaign=8448&routeid=18&type=text&contacts=${recipents.join(",")}&senderid=TEXTIT&msg=$message";
    context.read<HomeCubit>().callSMSAPI(url).then((value) {
      DialogHelper.dismissDialog(context);
      setState(() {});
      DialogHelper.showToasts("SMS Send Successfully");
      VxNavigator.of(context).push(Uri.parse(adminHomeScreen));
      print("SMSResp  $value");
    });
  }
}
