import 'package:rapid_response/PlatformService.dart';
import 'package:rapid_response/theme/app_font_size.dart' as dimens;
import 'package:rapid_response/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'modal_widget.dart';
import 'text_widget.dart';

class DropdownWidget extends StatelessWidget {
  final BuildContext? context;
  final String? value;
  final String? hintText;
  final Function? onChoose;
  final Widget? prefixIcon;
  final String? label;
  final List? items;
  final String? errorMessage;
  final FocusNode? autofocus;
  final TextInputAction? actionKeyboard;

  const DropdownWidget(
      {Key? key,
      @required this.context,
      this.autofocus,
      this.value,
      this.onChoose,
      this.label,
      this.items,
      this.hintText,
      this.prefixIcon,
      this.errorMessage,
      this.actionKeyboard = TextInputAction.next})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();
    List<Widget> options = [];

    if (value != null) _controller.text = value!;

    if (items != null && items!.length > 0) {
      items!.asMap().entries.map((
        i,
      ) {
        options.add(SizedBox(
          width: PlatFormServices.isMobile(context)
              ? MediaQuery.of(context).size.width
              : MediaQuery.of(context).size.width - 350,
          child: ListTile(
            onTap: () {
              _controller.text = i.value;
              if (onChoose != null) onChoose!(i.value, i.key);
              Navigator.pop(context);
            },
            //status: _controller.text == i ? true : false,
            title: TextWidget(text: i.value),
          ),
        ));
      }).toList();
    } else {
      options.add(SizedBox(
        width: PlatFormServices.isMobile(context)
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.width - 350,
        child: const ListTile(title: TextWidget(text: "Data Not Found")),
      ));
    }

    return TextFormField(
        focusNode: autofocus,
        textInputAction: actionKeyboard,
        controller: _controller,
        onChanged: (value) => null,
        enableInteractiveSelection: false,
        cursorColor: cursorColor,
        onTap: () {
          ModalWidget.show(context,
              title: label == null ? "" : label!.toUpperCase(),
              body: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[...options]));
        },
        textCapitalization: TextCapitalization.none,
        readOnly: true,
        style: TextStyle(
          color: textColor,
          fontSize: dimens.fontTitle,
            fontWeight: FontWeight.normal
        ),
        decoration: InputDecoration(
          errorText: errorMessage,
          prefixIcon: prefixIcon,
          suffixIcon: IconButton(
            icon: Icon(Icons.arrow_drop_down, size: 18, color: hoverColor),
            onPressed: () {},
          ),
          label: Text(
            hintText!,
            style: TextStyle(fontSize: 16, color: labelColor, fontWeight: FontWeight.normal),
          ),
          hintText: hintText ?? "",
          border: OutlineInputBorder(
              borderSide: BorderSide(color: enableBorderColor)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: enableBorderColor)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: focusedBorderColor)),
          hintStyle: const TextStyle(
              fontSize: dimens.fontInputWidget,
              color: backgroundDarkColor,
              fontWeight: FontWeight.normal),
          isDense: true,
          contentPadding: const EdgeInsets.only(
              top: dimens.FONT_12,
              bottom: dimens.FONT_12,
              left: 8.0,
              right: 8.0),
          errorStyle: const TextStyle(
            color: errorColor,
            fontSize: 12.0,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.normal,
            letterSpacing: 1.2,
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: errorColor),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: errorColor),
          ),
        ));
  }
}
