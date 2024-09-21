import 'package:expense_tracker_app/constant/app_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../constant/color_constant.dart';
import '../pages/shared_preference.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkMode = false;
  ThemeData? selectedThemeData;

  ThemeData lightTheme = ThemeData(
      fontFamily: AppAsset.defaultFont,
      dividerColor: ColorConstant.appBlack,
      scaffoldBackgroundColor: ColorConstant.appWhite,
      textTheme: const TextTheme(
        headline1: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: ColorConstant.appBlack),
        headline2: TextStyle(
          color: ColorConstant.appBlack,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
        headline3: TextStyle(
          color: ColorConstant.appBlack,
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
        headline4: TextStyle(
          color: ColorConstant.appBlack,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
        headline5: TextStyle(
            color: ColorConstant.appBlack,
            fontSize: 14,
            fontWeight: FontWeight.w500),
        subtitle1: TextStyle(
          color: ColorConstant.appBlack,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
        subtitle2: TextStyle(
          color: ColorConstant.appBlack,
          fontWeight: FontWeight.w600,
          fontSize: 9,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
        ),
      ),
       // dialogBackgroundColor: ColorConstant.appBlack,
       drawerTheme:
          const DrawerThemeData(backgroundColor: ColorConstant.appBlack),
       primaryIconTheme: const IconThemeData(color: ColorConstant.appBlack, size: 22),

       iconTheme: const IconThemeData(color: ColorConstant.appBlack, size: 22));

  ThemeData darkTheme = ThemeData(
    fontFamily: AppAsset.defaultFont,
    dividerColor: ColorConstant.appWhite,
    scaffoldBackgroundColor: ColorConstant.appBlack,
    textTheme: TextTheme(
      headline1: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: ColorConstant.appWhite,
      ),
      headline2: const TextStyle(
        color: ColorConstant.appWhite,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
      headline3: const TextStyle(
        color: ColorConstant.appWhite,
        fontWeight: FontWeight.w500,
        fontSize: 15,
      ),
      headline4: const TextStyle(
        color:ColorConstant.appWhite,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
      headline5: const TextStyle(
          color: Colors.white30,
          fontSize: 14,
          fontWeight: FontWeight.w500),
      subtitle1: const TextStyle(
        color: ColorConstant.appBlack,
        fontSize: 11,
        fontWeight: FontWeight.w700,
      ),
      subtitle2: TextStyle(
        color: ColorConstant.appBlack.withOpacity(0.8),
        fontWeight: FontWeight.w700,
        fontSize: 9,
      ),
    ),
    drawerTheme:
        const DrawerThemeData(backgroundColor: ColorConstant.appBlack),
    iconTheme: const IconThemeData(color: ColorConstant.appWhite, size: 22),
    // dialogBackgroundColor: ColorConstant.appDialogBlack,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        // backgroundColor: MaterialStateProperty.all(ColorConstant.appRed),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        shadowColor: MaterialStateProperty.all(Colors.transparent),
      ),
    ),
  );

  ThemeProvider() {
    Brightness brightness = SchedulerBinding.instance.window.platformBrightness;
    isDarkMode = brightness == Brightness.dark;
    selectedThemeData = isDarkMode ? darkTheme : lightTheme;
    checkTheme();
  }

  void swapTheme() async {
    selectedThemeData = selectedThemeData == lightTheme ? darkTheme : lightTheme;
    isDarkMode = selectedThemeData == lightTheme ? false : true;
    setPrefBoolValue(isTheme, isDarkMode);
    notifyListeners();
  }
  //
  // void swapTheme({int? value}) async {
  //   selectedThemeData = value == 1 ? darkTheme : lightTheme;
  //   isDarkMode = selectedThemeData == lightTheme ? false : true;
  //   setPrefBoolValue(isTheme, isDarkMode);
  //   notifyListeners();
  // }


  void checkTheme() async {
    if (await checkPrefKey(isTheme)) {
      isDarkMode = await getPrefBoolValue(isTheme);
      selectedThemeData = isDarkMode ? darkTheme : lightTheme;
      notifyListeners();
    }
  }

  checkThemeReturn() async {
    if (await checkPrefKey(isTheme)) {
      isDarkMode = await getPrefBoolValue(isTheme);
      selectedThemeData = isDarkMode ? darkTheme : lightTheme;
      if(selectedThemeData == lightTheme){
        return 0;
      } else{
        return 1;
      }
    }
  }
}
