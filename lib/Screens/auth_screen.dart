import 'package:railway_alert/theme/app_shared_preferences_constant.dart';
import 'package:railway_alert/storage/cache/secure_storage_helper.dart';
import 'package:railway_alert/routes/app_routes_names.dart';
import 'package:railway_alert/helper/dialog.helper.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';

class Auth extends StatelessWidget {
  const Auth({Key? key}) : super(key: key);

  callScreen(BuildContext context) async {
    dynamic depValue;
    await SecStore.getValue(keyVal: SharedPreferencesConstant.DEPTID)
        .then((deptId) {
      depValue = deptId;
      SecStore.getValue(keyVal: SharedPreferencesConstant.USERTYPEID)
          .then((userId) {
        SecStore.getValue(keyVal: SharedPreferencesConstant.ACTIVATION)
            .then((activation) {
          if (userId == "2" && activation == "1" && depValue == deptId) {
            VxNavigator.of(context).push(Uri.parse(empHomeScreen));
          } else if (userId == "2" && activation == "0" && depValue == deptId) {
            DialogHelper.showToasts(
                "Please Contact With admin for activate your Account");
            DialogHelper.dismissDialog(context);
          } else if (depValue == deptId) {
            SecStore.getValue(keyVal: SharedPreferencesConstant.DEPTID)
                .then((value) {
              VxNavigator.of(context).push(Uri.parse(adminHomeScreen));
            });
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    callScreen(context);
    return Scaffold(
      body: Container(
        child: DialogHelper.buildLoading(),
      ),
    );
  }
}
