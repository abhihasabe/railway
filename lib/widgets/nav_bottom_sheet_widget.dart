import 'package:flutter/material.dart';
import 'package:rapid_response/theme/app_colors.dart' as colors;
import 'card_view_widget.dart';
import 'text_widget.dart';

class NavBottomSheetWidget extends StatelessWidget {
  final String? buttonLeft;
  final String? buttonRight;
  final Function? actionButtonLeft;
  final Widget? pageToCall;

  const NavBottomSheetWidget(
      {Key? key,
      this.buttonLeft,
      this.buttonRight,
      this.actionButtonLeft,
      this.pageToCall})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CardViewWidget(
          width: double.infinity,
          height: 63,
          child: ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: GestureDetector(
                onTap: () => actionButtonLeft!(context),
                child: TextWidget(
                  text: buttonLeft,
                ),
              ),
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => pageToCall!));
                  },
                  child:
                      TextWidget(textColor: colors.accentColor, text: buttonRight)),
            ),
          )),
    );
  }
}
