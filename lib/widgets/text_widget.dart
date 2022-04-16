import 'package:railway_alert/theme/app_font_size.dart' as dimens;
import 'package:railway_alert/theme/app_colors.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String? text;
  final bool? title;
  final bool? bold;
  final bool? big;
  final bool? medium;
  final bool? smaller;
  final bool? small;
  final bool? center;
  final bool? white;
  final bool? dark;
  final bool? accent;
  final bool? primary;
  final Color? textColor;
  final int? maxLines;
  final bool? underline;
  final TextAlign? align;

  const TextWidget({Key? key, this.align, this.underline, this.text, this.title, this.bold, this.big, this.medium, this.small ,this.smaller , this.center, this.white, this.dark, this.accent, this.primary, this.textColor, this.maxLines}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dynamic isBold = bold == true ? FontWeight.bold : FontWeight.normal;

    final String textValue = text ?? "";

    final double fontSize = title == true ? dimens.fontTextTitle
        : big == true ? dimens.fontTextBig
        : medium == true ? dimens.fontTextMedium
        : small == true ? dimens.fontTextSmall
        : smaller == true ? dimens.fontTextSmaller
        : dimens.fontTextMedium;

    final Color customColor = primary == true ? primaryColor : white == true ? Colors.white : accent == true
        ? accentColor : primaryColor;
    return Text(
        textValue,
        maxLines: maxLines,
        textAlign: center == true ? TextAlign.center : align,
        style: TextStyle(
            decoration: underline == true ? TextDecoration.underline : TextDecoration.none,
            fontSize: fontSize, fontFamily: 'Roboto',
            color: textColor, fontWeight: isBold
        )
    );
  }
}