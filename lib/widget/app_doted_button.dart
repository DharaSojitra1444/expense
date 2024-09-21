import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  final IconData? iconImage;
  final Color? iconColor;
  final GestureTapCallback? onTap;

  const AppIconButton({
    Key? key,
    this.onTap,
    this.iconImage,
    this.iconColor,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 10,bottom: 10,right: 15),
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(10),
          dashPattern: const [2, 2],
          color: iconColor!,
          strokeWidth: 1,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: iconImage != null ? Icon(iconImage,color :iconColor!,): const SizedBox(width: 24,)
          ),
        ),
      ),
    );
  }
}