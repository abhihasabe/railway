import 'package:flutter_sms/flutter_sms.dart';
import 'package:rapid_response/bloc_cubits/home_cubit/home_cubit.dart';
import 'package:rapid_response/helper/dialog.helper.dart';
import 'package:rapid_response/routes/app_routes_names.dart';
import 'package:rapid_response/widgets/button_widget.dart';
import 'package:rapid_response/models/emp_resp_model.dart';
import 'package:rapid_response/theme/app_dimension.dart';
import 'package:rapid_response/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SuperAdminWidget extends StatefulWidget {
  SuperAdminWidget({Key? key, this.empData}) : super(key: key);
  List<EmpData>? empData;

  @override
  State<SuperAdminWidget> createState() => _AdminWidgetState();
}

class _AdminWidgetState extends State<SuperAdminWidget> {
  var brightness;
  List<bool>? isChecked;
  List<String> userChecked = [];
  bool isCheck = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    brightness = MediaQueryData.fromWindow(WidgetsBinding.instance.window)
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
                          title: Text(
                            widget.empData![index].name!,
                            style:
                                const TextStyle(color: textColor, fontSize: 16),
                          ),
                          trailing: widget.empData![index].activation != 0
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
                                      VxNavigator.of(context).push(
                                          Uri.parse(superAdminHomeScreen));
                                    });
                                  },
                                )
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
                                      VxNavigator.of(context).push(
                                          Uri.parse(superAdminHomeScreen));
                                    });
                                  },
                                )),
                      const Divider()
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
