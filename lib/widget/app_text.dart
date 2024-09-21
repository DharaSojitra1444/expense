import 'package:expense_tracker_app/constant/app_asset.dart';
import 'package:expense_tracker_app/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constant/color_constant.dart';

class AppText extends StatelessWidget {
  final String? text;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextDecoration? decoration;
  final TextStyle? textStyle;
  final Color? textColor;
  final double? fontSize;
  final double? letterSpacing;
  final FontWeight? fontWeight;

  const AppText({
    Key? key,
    this.text,
    this.textAlign,
    this.maxLines,
    this.decoration = TextDecoration.none,
    this.textStyle,
    this.textColor,
    this.fontSize = 14,
    this.fontWeight,
    this.letterSpacing
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Consumer(
       builder: (context,ThemeProvider themeProvider,_) {
         return Text('$text',
            textAlign: textAlign,
            maxLines: maxLines,
            style: textStyle ??
                TextStyle(
                   fontFamily: AppAsset.defaultFont,
                    color: textColor ?? (themeProvider.isDarkMode ? ColorConstant.appWhite: ColorConstant.appBlack),
                    fontSize: fontSize,
                    fontWeight: fontWeight ?? FontWeight.w400,
                    letterSpacing:letterSpacing,
                    decoration: decoration));
       }
     );
  }
}
