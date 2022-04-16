import 'package:flutter/material.dart';
import 'package:railway_alert/theme/app_colors.dart' as colors;
import '../widgets/text_widget.dart';

class CustomWidgets {
  CustomWidgets._();

  static buildErrorSnackbar(
      {required BuildContext context,
      required String message,
      required Color color}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }
}

/*CustomWidgets.buildErrorSnackbar(
              context: context,
              message: "Login Successful",
              color: Colors.green);*/