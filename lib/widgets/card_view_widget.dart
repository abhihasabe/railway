import 'package:flutter/material.dart';

class CardViewWidget extends StatelessWidget {
  final Alignment? alignment;
  final double? width;
  final double? height;
  final EdgeInsets? margin;
  final double? elevation;
  final Widget? child;
  final Color? backgroundColor;
  final double? borderRadius;
  final bool? autoHeight;

  const CardViewWidget(
      {Key? key,
      this.alignment,
      this.width,
      this.height,
      this.margin,
      this.elevation,
      this.backgroundColor,
      this.borderRadius =0,
      this.autoHeight,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: autoHeight == true ? null : height ?? 100,
        width: width,
        margin: margin,
        alignment: alignment,
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: borderRadius == 0
                ? BorderRadius.circular(0)
                : BorderRadius.circular(borderRadius!),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: elevation == null ? 6.0 : elevation!,
                offset: const Offset(0.0, 1.0),
              )
            ]),
        child: child);
  }
}
