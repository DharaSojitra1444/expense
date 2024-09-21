import 'package:flutter/material.dart';
import '../constant/color_constant.dart';

class AppWithoutBgButton extends StatelessWidget {
  final String? buttonText;
  final GestureTapCallback? onTap;
  final EdgeInsets? padding;
  final  Color? borderColor;
  final  Color? buttonColor;
  final  Color? textColor;
  final  double? borderRadius;
  final  double? fontSize;
  final  FontWeight? fontWeight;
  final bool showFirstIcon;
  final bool showLastIcon;
  const AppWithoutBgButton(
      {Key? key,
        this.buttonText,
        this.onTap,
        this.padding,
        this.borderColor,
        this.buttonColor,
        this.textColor,
        this.borderRadius =8.0,
        this.fontSize =15.0,
        this.fontWeight =FontWeight.w400,
        this.showFirstIcon =false,
      this.showLastIcon =false
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: padding ?? const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20),
          child: Container(
            height: 45.0,
            width: 150,
            decoration: BoxDecoration(
              color: buttonColor ?? Colors.transparent,
              borderRadius: BorderRadius.circular(borderRadius!),
              border: Border.all(color: borderColor ?? const Color(0xFF0500a0),width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if(showFirstIcon)const Icon(Icons.keyboard_arrow_left_outlined,color: ColorConstant.appBlack,),
                Text(
                  buttonText!,
                  style:  TextStyle(
                      color: textColor ??  ColorConstant.appThemeColor,
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                        letterSpacing: 0.9),
                ),
                if(showLastIcon)const Icon(Icons.keyboard_arrow_right_rounded,color: ColorConstant.appBlack,),
              ],
            ),
          ),
        ));
  }
}