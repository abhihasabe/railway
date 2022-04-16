import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class DialogHelper {
  /*static Future<void> launchURL(String url) async{
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Couldn't launch URL";
    }
  }*/

  static Future<void> showLoadingDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  static showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void dismissDialog(BuildContext context) {
    Navigator?.of(context, rootNavigator: true).pop();
  }

  static Widget showSnackbars(String text) {
    return SnackBar(
      content: Text(
        '$text',
        style: const TextStyle(),
        textAlign: TextAlign.center,
      ),
    );
  }

  static ToastFuture showToasts(String title) {
    return showToast(
      title,
      duration: const Duration(seconds: 2),
      position: ToastPosition.bottom,
      backgroundColor: Colors.white,
      radius: 5.0,
      textStyle: const TextStyle(fontSize: 16.0, color: Colors.black),
    );
  }

  static void dismissKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void _onLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CircularProgressIndicator(),
              Text("Loading"),
            ],
          ),
        );
      },
    );
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pop(context); //pop dialog
    });
  }

  static Future showScaleAlertBox({
    BuildContext? context,
    Widget? yourWidget,
//    Widget icon,
    Widget? title,
    Widget? firstButton,
    Widget? secondButton,
  }) {
    assert(context != null, "context is null!!");
    assert(yourWidget != null, "yourWidget is null!!");
    assert(firstButton != null, "button is null!!");
    return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.7),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                title: title,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
//                    icon,
                    yourWidget!
                  ],
                ),
                actions: <Widget>[
                  firstButton!,
                  secondButton!,
                ],
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 250),
        barrierDismissible: false,
        barrierLabel: '',
        context: context!,
        pageBuilder: (context, animation1, animation2) {
          return yourWidget!;
        });
  }

  static buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

//DialogHelper.dismissDialog(context);
//DialogHelper.showDialog(context);
