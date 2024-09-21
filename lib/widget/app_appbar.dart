
import 'package:expense_tracker_app/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constant/app_asset.dart';
import '../constant/color_constant.dart';
import 'app_image_assets.dart';
import 'app_text.dart';

// ignore: must_be_immutable
class AppAppBar extends PreferredSize {
  final String? appbarTitle;
  final String? text;
  final List<Widget>? actions;
  bool showProfile;
  bool showTitle;
  bool isBackButton;

  AppAppBar({
    Key? key,
    this.appbarTitle,
    this.text,
    this.actions,
    this.showProfile =true,
    this.showTitle =true,
    this.isBackButton =true,
    Size? preferredSize,
  }) : super(
    key: key,
    child: Container(),
    preferredSize: const Size.fromHeight(65),
  );

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context,ThemeProvider themeProvider,_) {
        return AppBar(
            elevation: 0.0,
            titleSpacing: 0,
            actions: actions,
            backgroundColor:themeProvider.isDarkMode ? ColorConstant.appBlack:ColorConstant.appWhite,
            leadingWidth: 60,
            toolbarHeight: 250,
            leading: showProfile ?
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: AppImageAsset(image: AppAsset.profile),
            ): isBackButton ?
             BackButton(
                color:themeProvider.isDarkMode ? ColorConstant.appWhite:ColorConstant.appBlack,) :const SizedBox(),
            title: showTitle ? !showProfile ? AppText(
               text: appbarTitle,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ) :
            Padding(
              padding: const EdgeInsets.only(left :8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AppText(
                    text: "Hello",
                    fontSize: 12,
                  ),
                  AppText(
                    text: appbarTitle,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ],
              ),
            ):const SizedBox());
      }
    );
  }
}
