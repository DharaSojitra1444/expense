import 'dart:convert';

import 'package:expense_tracker_app/constant/app_asset.dart';
import 'package:expense_tracker_app/constant/color_constant.dart';
import 'package:expense_tracker_app/modal/all_modal.dart';
import 'package:expense_tracker_app/pages/login_page/login_page.dart';
import 'package:expense_tracker_app/pages/shared_preference.dart';
import 'package:expense_tracker_app/widget/app_text.dart';
import 'package:flutter/material.dart';
import 'dashboard_page/dashboard_screen.dart';

String? storeUserId;
String? storeUserName;

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => WelcomePageState();
}

class WelcomePageState extends State<WelcomePage> {
  PageController pageController = PageController(initialPage: 0);
  int _i = 0;
 bool isLoading =false;
  Widget welcomeWidget1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AppAsset.welcome1, fit: BoxFit.fill),
        const Padding(
          padding: EdgeInsets.only(top: 20, bottom: 10),
          child: AppText(
            text: "Manage Your Finances \nEasily",
            fontSize: 22,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: AppText(
              text:
                  "type specimen book. It has survived not only five centuries, but also the leap",
              fontSize: 16,
              textColor: Colors.grey,
              letterSpacing: 1.1,
              textAlign: TextAlign.center),
        )
      ],
    );
  }

  Widget welcomeWidget2() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AppAsset.welcome2, fit: BoxFit.fill),
        const Padding(
          padding: EdgeInsets.only(top: 20, bottom: 10),
          child: AppText(
            text: "Manage Your Finances \nEasily",
            fontSize: 22,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: AppText(
              text:
              "type specimen book. It has survived not only five centuries, but also the leap",
              fontSize: 16,
              textColor: Colors.grey,
              letterSpacing: 1.1,
              textAlign: TextAlign.center),
        )
      ],
    );
  }

  Widget welcomeWidget3() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AppAsset.welcome3, fit: BoxFit.fill),
        const Padding(
          padding: EdgeInsets.only(top: 20, bottom: 10),
          child: AppText(
            text: "Manage Your Finances \nEasily",
            fontSize: 22,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: AppText(
              text:
              "type specimen book. It has survived not only five centuries, but also the leap",
              fontSize: 16,
              textColor: Colors.grey,
              letterSpacing: 1.1,
              textAlign: TextAlign.center),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: 3,
            onPageChanged: (int value) {
              setState(() {
                _i = value;
              });
            },
            itemBuilder: (BuildContext context, int index) {
             if(index == 0) {
               return welcomeWidget1();
             }else if(index == 1){
               return welcomeWidget2();
             }else{
               return welcomeWidget3();
             }
            },
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 30,
                    // decoration: BoxDecoration(
                    //     color: Colors.grey[400],
                    //     borderRadius: BorderRadius.circular(15)),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            for (int i = 0; i < 3; i++)
                              _i == i
                                  ? pageIndexIndicator(true)
                                  : pageIndexIndicator(false)
                          ],
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      pageController.animateToPage(++_i,
                          duration: const Duration(milliseconds: 10),
                          curve: Curves.easeIn);
                      if (_i == 3) {
                        print("--->loading ${isLoading}");
                        var userData = await getPrefStringValue(userKey);
                        if (userData != null) {
                          var userDetails = UserInformation.fromJson(jsonDecode(userData!));
                          storeUserId = userDetails.email;
                          storeUserName = userDetails.name;
                           Navigator.pushReplacement(
                              this.context,
                              MaterialPageRoute(
                                  builder: (context) => const DashBoardPage()));

                         } else {
                           Navigator.push(
                              this.context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                        }
                      }
                    },
                    child: Container(
                        height: 40,
                        width: 120,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(left: 10, right: 10,top: 5,bottom: 5),
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                            color: ColorConstant.appOrange,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Text(
                            "Next",
                            style: TextStyle(
                              color: ColorConstant.appWhite,
                            ))
                  ),
                  )
                ],
              ),
            ),
          )

        ],
      ),
    );
  }

  Widget pageIndexIndicator(bool isCurrentPage) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        height: isCurrentPage ? 8.0 : 8.0,
        width: isCurrentPage ? 8.0 : 8.0,
        decoration: BoxDecoration(
          color: isCurrentPage ? ColorConstant.appGreen : Colors.grey,
          borderRadius: BorderRadius.circular(12),
        ),
      );
}
