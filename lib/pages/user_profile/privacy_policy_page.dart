import 'package:expense_tracker_app/widget/app_text.dart';
import 'package:flutter/material.dart';
import '../../constant/color_constant.dart';
import '../../widget/app_appbar.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ColorConstant.appWhite,
      appBar: AppAppBar(
        showProfile: false,
        showTitle: true,
        appbarTitle: "Privacy Policy",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: AppText(
                text: "Contrary to popular",
                fontWeight: FontWeight.w500,
              ),
            ),
            AppText(
              text:
                  "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has",
              fontWeight: FontWeight.w500,
              textColor: ColorConstant.appGrey,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: AppText(
                text: "Contrary to popular",
                fontWeight: FontWeight.w500,
              ),
            ),
            AppText(
              text:
                  "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised",
              fontWeight: FontWeight.w500,
              textColor:  ColorConstant.appGrey,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: AppText(
                text: "Contrary to popular",
                fontWeight: FontWeight.w500,
              ),
            ),
            AppText(
              text:
                  "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has",
              fontWeight: FontWeight.w500,
              textColor:  ColorConstant.appGrey,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: AppText(
                text: "Contrary to popular",
                fontWeight: FontWeight.w500,
              ),
            ),
            AppText(
              text:
                  "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised",
              fontWeight: FontWeight.w500,
              textColor:  ColorConstant.appGrey,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: AppText(
                text: "Contrary to popular",
                fontWeight: FontWeight.w500,
              ),
            ),
            AppText(
              text:
                  "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised",
              fontWeight: FontWeight.w500,
              textColor:  ColorConstant.appGrey,
            ),
          ],
        ),
      ),
    );
  }
}
