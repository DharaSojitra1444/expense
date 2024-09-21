import 'dart:convert';

import 'package:expense_tracker_app/constant/app_asset.dart';
import 'package:expense_tracker_app/constant/color_constant.dart';
import 'package:expense_tracker_app/pages/shared_preference.dart';
import 'package:expense_tracker_app/pages/welcome_page.dart';
import 'package:expense_tracker_app/provider/theme_provider.dart';
import 'package:expense_tracker_app/widget/app_button.dart';
import 'package:expense_tracker_app/widget/app_text.dart';
import 'package:expense_tracker_app/widget/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../modal/all_modal.dart';
import '../../sqflite_database/database.dart';
import '../dashboard_page/dashboard_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context,ThemeProvider themeProvider,_) {
        return Scaffold(
          // backgroundColor: ColorConstant.appWhite,
          body: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Image.asset(AppAsset.welcome2, fit: BoxFit.fill),
                const Padding(
                  padding: EdgeInsets.only(top: 15, left: 10),
                  child: AppText(
                    text: "Login",
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                    textColor: ColorConstant.appThemeColor,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15, top: 15, bottom: 10),
                  child: AppText(
                    text: "Name",
                    textColor: ColorConstant.appGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                AppTextField(
                    controller: nameController,
                    isUnderLine: false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter name';
                      }
                      if (value.length <=5) {
                        return 'Please enter a more then 5 character';
                      }
                      return null;
                    },
                    textColor: themeProvider.isDarkMode ? ColorConstant.appWhite:ColorConstant.appBlack,
                    borderColor: ColorConstant.appThemeColor,
                    focusedColor: ColorConstant.appThemeColor,
                    enabledColor: ColorConstant.appThemeColor,
                    errorColor: Colors.red,
                    hintTextColor: ColorConstant.appThemeColor,
                    hint: 'Enter name'),
                const Padding(
                  padding: EdgeInsets.only(left: 15, top: 15, bottom: 10),
                  child: AppText(
                    text: "Email",
                    textColor: ColorConstant.appGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                AppTextField(
                    textColor: themeProvider.isDarkMode ? ColorConstant.appWhite:ColorConstant.appBlack,
                    controller: emailController,
                    isUnderLine: false,
                    validator: (value) {
                      String emailPattern =
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                      if (value!.isEmpty) {
                        return 'Please enter email';
                      }
                      if (!RegExp(emailPattern).hasMatch(value)) {
                        return 'Please enter a valid Email';
                      }
                      return null;
                    },
                    borderColor: ColorConstant.appThemeColor,
                    focusedColor: ColorConstant.appThemeColor,
                    enabledColor: ColorConstant.appThemeColor,
                    errorColor: Colors.red,
                    hintTextColor: ColorConstant.appThemeColor,
                    hint: 'Enter email'),
                AppWithoutBgButton(
                    padding: const EdgeInsets.all(20),
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        List<UserInformation> userInfo =
                            await DatabaseProvider.queryAll();
                        bool exists = userInfo.any((UserInformation file) =>
                            file.email == emailController.text.trim());
                        debugPrint("--->exists $exists");
                        if (!exists) {
                          Map<String, dynamic> userInf0 = {
                            'name': nameController.text,
                            'email': emailController.text.trim(),
                          };
                          await DatabaseProvider.addUserInformation(userInf0);
                          await setPrefStringValue(userKey, jsonEncode(userInf0));
                          var userData = await getPrefStringValue(userKey);
                          if (userData != null) {
                            var userInfo1 =
                                UserInformation.fromJson(jsonDecode(userData!));
                            storeUserId = userInfo1.email;
                            storeUserName = userInfo1.name;
                            Navigator.pushReplacement(
                                this.context,
                                MaterialPageRoute(
                                    builder: (context) => const DashBoardPage()));
                          }
                        } else {
                          UserInformation save =
                              await DatabaseProvider.getLoginRecord(
                                  emailController.text.trim());
                          await setPrefStringValue(userKey, jsonEncode(save));
                          var userData = await getPrefStringValue(userKey);
                          if (userData != null) {
                            var userInfo1 =
                                UserInformation.fromJson(jsonDecode(userData!));
                            storeUserId = userInfo1.email;
                            storeUserName = userInfo1.name;
                            Navigator.pushReplacement(
                                this.context,
                                MaterialPageRoute(
                                    builder: (context) => const DashBoardPage()));
                          }
                        }
                      }
                    },
                    buttonText: "Get Started",
                    buttonColor: ColorConstant.appGreen,
                    borderColor: ColorConstant.appGreen,
                    textColor: ColorConstant.appWhite),
              ],
            ),
          ),
        );
      }
    );
  }

}
