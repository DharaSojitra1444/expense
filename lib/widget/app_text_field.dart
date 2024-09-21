import 'dart:math';

import 'package:expense_tracker_app/provider/theme_provider.dart';
import 'package:expense_tracker_app/widget/app_image_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../constant/app_asset.dart';
import '../constant/color_constant.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;

  final TextInputType keyboardType;
  final String? hint;
  final String? label;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final bool readOnly;
  final bool enableInteractiveSelection;
  final GestureTapCallback? onTap;
  final int maxLines;
  final EdgeInsetsGeometry margin;
  final bool autofocus;
  final Widget? suffix;
  final bool isUnderLine;
  final Color? borderColor;
  final Color? enabledColor;
  final Color? disabledBorderColor;
  final Color? errorColor;
  final Color? focusedColor;
  final Color? textColor;
  final Color? hintTextColor;

  const AppTextField(
      {Key? key,
      this.controller,
      this.keyboardType = TextInputType.text,
      @required this.hint,
      this.label,
      this.inputFormatters,
      this.validator,
      this.obscureText = false,
      this.readOnly = false,
      this.onTap,
      this.enableInteractiveSelection = true,
      this.maxLines = 1,
      this.margin = const EdgeInsets.only(left: 15, right: 15),
      this.autofocus = false,
      this.suffix,
      this.isUnderLine = true,
      this.borderColor,
      this.enabledColor,
      this.disabledBorderColor,
      this.errorColor,
      this.focusedColor,
      this.textColor,
      this.hintTextColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context,ThemeProvider themeProvider,_) {
        return Container(
          margin: margin,
          child: TextFormField(
            autofocus: autofocus,
            enableInteractiveSelection: enableInteractiveSelection,
            onTap: onTap,
            obscureText: obscureText,
            readOnly: readOnly,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validator,
            controller: controller,
            keyboardType: keyboardType,
            cursorColor: ColorConstant.appThemeColor,
            cursorWidth: 1,
            inputFormatters: inputFormatters,
            maxLines: maxLines,
            style: TextStyle(
                fontSize: 15,
                color: textColor ?? ColorConstant.appWhite,
                fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              suffixIcon: suffix,
              labelText: label,
              hintText: hint,
              labelStyle: const TextStyle(
                  // fontSize: 15,
                  color: ColorConstant.appGrey),
              hintStyle: TextStyle(
                  // fontSize: 15,
                  color: hintTextColor ?? ColorConstant.appGreen,
                  fontFamily: AppAsset.defaultFont,
                  fontWeight: FontWeight.w400),
              // filled: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              border: isUnderLine
                  ? appUnderlineInputBorder(color: borderColor)
                  : appOutlineInputBorder(color: borderColor),
              disabledBorder: isUnderLine
                  ? appUnderlineInputBorder(color: disabledBorderColor)
                  : appOutlineInputBorder(color: disabledBorderColor),
              enabledBorder: isUnderLine
                  ? appUnderlineInputBorder(color: enabledColor)
                  : appOutlineInputBorder(color: enabledColor),
              errorBorder: isUnderLine
                  ? appUnderlineInputBorder(color: errorColor)
                  : appOutlineInputBorder(color: errorColor),
              focusedBorder: isUnderLine
                  ? appUnderlineInputBorder(color: focusedColor)
                  : appOutlineInputBorder(color: focusedColor),
            ),
          ),
        );
      }
    );
  }

  static UnderlineInputBorder appUnderlineInputBorder({Color? color}) =>
      UnderlineInputBorder(
        borderSide:
            BorderSide(color: color ?? ColorConstant.appThemeColor, width: 1),
      );

  static OutlineInputBorder appOutlineInputBorder({Color? color}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide:
            BorderSide(color: color ?? ColorConstant.appGreen, width: 1),
      );
}

class AppText2Field extends StatelessWidget {
  final TextEditingController? controller;

  final TextInputType keyboardType;
  final String? hint;
  final String? label;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final bool readOnly;
  final bool enableInteractiveSelection;
  final GestureTapCallback? onTap;
  final int maxLines;
  final EdgeInsetsGeometry? margin;
  final bool autofocus;
  // final Color? fillColor;
  final Widget? suffix;
  final Color? textColor;
  final Color? hintTextColor;


  const AppText2Field(
      {Key? key,
      this.controller,
      this.keyboardType = TextInputType.text,
      @required this.hint,
      this.label,
      this.inputFormatters,
      this.validator,
      this.obscureText = false,
      this.readOnly = false,
      this.onTap,
      this.enableInteractiveSelection = true,
      this.maxLines = 1,
      this.margin,
      this.autofocus = false,
      // this.fillColor,
      this.suffix,
      this.textColor,
      this.hintTextColor
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context,ThemeProvider themeProvider,_) {
        return Container(
          margin: margin ?? const EdgeInsets.only(bottom: 10),
          child: TextFormField(
            autofocus: autofocus,
            enableInteractiveSelection: enableInteractiveSelection,
            onTap: onTap,
            obscureText: obscureText,
            readOnly: readOnly,
            validator: validator,
            controller: controller,
            keyboardType: keyboardType,
            cursorColor: ColorConstant.appThemeColor,
            cursorWidth: 1,
            inputFormatters: inputFormatters,
            maxLines: maxLines,
            style: TextStyle(
                fontSize: 15,
                color: textColor ?? (themeProvider.isDarkMode ? ColorConstant.appWhite: ColorConstant.appBlack),
                fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              prefixIcon: Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 8,right: 10,left: 10),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: ColorConstant
                      .colorList[Random().nextInt(ColorConstant.colorList.length)]
                      .withOpacity(0.5),
                  // ColorConstant.appThemeColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                //list_alt_rounded
                child: const AppImageAsset(
                    image: AppAsset.pdfIcon, color: ColorConstant.appThemeColor),
              ),
              suffix: suffix,
              labelText: label,
              hintText: hint,
              labelStyle: const TextStyle(
                  fontSize: 15, color: ColorConstant.appGrey),
              hintStyle: TextStyle(
                  fontSize: 15,
                  color: hintTextColor ?? ColorConstant.appGrey,
                  fontFamily: AppAsset.defaultFont,
                  fontWeight: FontWeight.w400),
              // filled: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              border: appUnderlineInputBorder(),
              disabledBorder: appUnderlineInputBorder(),
              enabledBorder: appUnderlineInputBorder(),
              errorBorder: appUnderlineInputBorder(color: Colors.red),
              focusedBorder: appUnderlineInputBorder(),
            ),
          ),
        );
      }
    );
  }

  static UnderlineInputBorder appUnderlineInputBorder({Color? color}) =>
      UnderlineInputBorder(
        borderSide:
            BorderSide(color: color ?? ColorConstant.appGreen, width: 1),
      );
}
