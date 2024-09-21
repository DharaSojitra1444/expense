import 'package:expense_tracker_app/pages/user_profile/privacy_policy_page.dart';
import 'package:expense_tracker_app/widget/app_appbar.dart';
import 'package:expense_tracker_app/widget/app_text.dart';
import 'package:flutter/material.dart';
import '../../constant/color_constant.dart';
import 'edit_account_page.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      // backgroundColor: ColorConstant.appWhite,
      appBar: AppAppBar(
        showProfile: false,
        showTitle: true,
        appbarTitle: "My Account",
      ),
      body: Column(
        children: [
          myTile(title: "Account",onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const EditAccountPage()));
          }),
          myTile(title: "Transactions"
              ,onTap: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>const PrivacyPolicyPage()));
                   }
          ),
          myTile(title: "Notifications & Reminders"),
          myTile(title: "Backup"),
          myTile(title: "Security"),
        ],
      ),
    );

  }

myTile({String? title, GestureTapCallback? onTap}){
    return  ListTile(
      onTap: onTap,
      title: AppText(text: title,fontWeight: FontWeight.w500),  visualDensity: const VisualDensity(horizontal: 0, vertical: -3),);
}

}
