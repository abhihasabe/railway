import 'package:rapid_response/widgets/text_widget.dart';
import 'package:rapid_response/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'logo_widget.dart';

class ToolbarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  final VoidCallback? onClick;
  final Widget? leading;
  final String? title;
  final List<Widget>? actions;
  final Color? color;
  final double? elevation;
  final bool? logoWidget;
  final bool? hideBackArrow;

  const ToolbarWidget(
      {Key? key,
      this.onClick,
      this.hideBackArrow,
      this.logoWidget,
      this.leading,
      this.title,
      this.actions,
      this.color,
      this.elevation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQueryData.fromWindow(WidgetsBinding.instance!.window)
        .platformBrightness;
    return AppBar(
        backgroundColor:
            (brightness == Brightness.dark) ? appBarDarkColor : appBarColor,
        automaticallyImplyLeading: hideBackArrow == true ? false : true,
        title: logoWidget == true
            ? const Center(child: LogoWidget(header: true, small: true))
            : TextWidget(
                text: title,
                title: true,
                bold: true,
                textColor: (brightness == Brightness.dark)
                    ? appBarTextDarkColor
                    : appBarTextColor,
              ),
        leading: InkWell(child: leading, onTap: onClick),
        actions: actions,
        elevation: elevation ?? 0.0);
  }
}
