import 'package:rapid_response/theme/app_font_size.dart' as dimens;
import 'package:rapid_response/theme/app_constant.dart';
import 'package:rapid_response/theme/app_colors.dart';
import 'package:flutter/material.dart';

class InputTextFormFieldWidget extends StatefulWidget {
  final TextInputType? textInputType;
  final String? hintText;
  final String? errorMessage;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? showSuffixIcon;
  final String? defaultText;
  final FocusNode? focusNode;
  final bool? obscureText;
  final TextEditingController? controller;
  final Function? functionValidate;
  final String? parametersValidate;
  final TextInputAction? actionKeyboard;
  final Function? onSubmitField;
  final Function? onFieldTap;
  final TextCapitalization? textCapitalization;
  final int? maxLine;
  final Function(dynamic)? onChange;
  final AutovalidateMode? autoValidateMode;
  final bool? readOnly;
  final Color? cursorColor;

  const InputTextFormFieldWidget(
      {Key? key,
      this.hintText,
      this.autoValidateMode,
      this.errorMessage,
      this.focusNode,
      this.textInputType,
      this.defaultText,
      this.onChange,
      this.obscureText = false,
      this.showSuffixIcon = false,
      this.controller,
      this.functionValidate,
      this.parametersValidate,
      this.actionKeyboard = TextInputAction.next,
      this.onSubmitField,
      this.onFieldTap,
      this.prefixIcon,
      this.maxLine,
      this.suffixIcon,
      this.textCapitalization,
      this.readOnly,
      this.cursorColor})
      : super(key: key);

  @override
  _InputTextFormFieldWidgetState createState() =>
      _InputTextFormFieldWidgetState();
}

class _InputTextFormFieldWidgetState extends State<InputTextFormFieldWidget> {
  double bottomPaddingToError = dimens.FONT_12;
  bool? _obSecure;
  int inputLength = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _obSecure = widget.obscureText!;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: const Key('textField'),
      readOnly: widget.readOnly == null ? false : widget.readOnly!,
      autovalidateMode: widget.autoValidateMode,
      cursorColor: cursorColor,
      obscureText: _obSecure!,
      textCapitalization: widget.textCapitalization!,
      keyboardType: widget.textInputType,
      textInputAction: widget.actionKeyboard,
      focusNode: widget.focusNode,
      maxLines: widget.maxLine,
      style: TextStyle(
          color: textColor,
          fontSize: dimens.fontTitle,
          fontWeight: FontWeight.normal),
      initialValue: widget.defaultText,
      decoration: InputDecoration(
        errorText: widget.errorMessage,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.showSuffixIcon!
            ? (_obSecure!
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _obSecure = false;
                      });
                    },
                    icon:
                        Icon(Icons.visibility_off, size: 18, color: hoverColor))
                : IconButton(
                    onPressed: () {
                      setState(() {
                        _obSecure = true;
                      });
                    },
                    icon: Icon(Icons.visibility, size: 18, color: hoverColor)))
            : null,
        label: Text(
          "${widget.hintText}",
          style: TextStyle(
              fontSize: dimens.fontInputWidget, color: labelColor, fontWeight: FontWeight.normal),
        ),
        hintText: widget.hintText,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: enableBorderColor)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: focusedBorderColor)),
        hintStyle: const TextStyle(
            color: textColor,
            fontSize: dimens.fontInputWidget,
            fontWeight: FontWeight.normal),
        contentPadding: EdgeInsets.only(
            top: dimens.FONT_12,
            bottom: bottomPaddingToError,
            left: 8.0,
            right: 8.0),
        isDense: true,
        errorStyle: const TextStyle(
          color: errorColor,
          fontSize: 12.0,
          fontStyle: FontStyle.normal,
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: errorColor),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: errorColor),
        ),
      ),
      onChanged: (String value) {
        _onChanged(value);
      },
      controller: widget.controller,
      validator: (value) {
        if (widget.functionValidate != null) {
          String resultValidate =
              widget.functionValidate!(value, widget.parametersValidate);
          if (resultValidate != null) {
            return resultValidate;
          }
        }
        return null;
      },
      onFieldSubmitted: (value) {
        if (widget.onSubmitField != null) widget.onSubmitField!();
      },
      onTap: () {
        if (widget.onFieldTap != null) widget.onFieldTap!();
      },
    );
  }

  void _setInputLength(int length) {
    setState(() {
      inputLength = length;
    });
  }

  _onChanged(String value) {
    _setInputLength(value != AppStrings.emptyString ? value.length : 0);
    if (widget.onChange != null) widget.onChange!(value);
  }
}

commonValidation(String value, String messageError) {
  var required = requiredValidator(value, messageError);
  if (required != null) {
    return required;
  }
  return null;
}

String? requiredValidator(value, messageError) {
  if (value.isEmpty) {
    return messageError;
  }
  return null;
}

void changeFocus(BuildContext context, FocusNode currentFocus,
    FocusNode passwordFocus, FocusNode confirmPasswordFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(passwordFocus);
}
