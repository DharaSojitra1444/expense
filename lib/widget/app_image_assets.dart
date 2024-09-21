import 'package:flutter/material.dart';

class AppImageAsset extends StatelessWidget {
  final String? image;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit? fit;

  const AppImageAsset(
      {Key? key,
      @required this.image,
      this.fit,
      this.height,
      this.width,
      this.color,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
                image!,
                fit: fit,
                height: height,
                width: width,
                color: color,
              );

  }
}
