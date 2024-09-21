import 'package:expense_tracker_app/pages/login_page/login_page.dart';
import 'package:expense_tracker_app/pages/welcome_page.dart';
import 'package:expense_tracker_app/widget/app_appbar.dart';
import 'package:expense_tracker_app/widget/app_button.dart';
import 'package:expense_tracker_app/widget/app_image_assets.dart';
import 'package:expense_tracker_app/widget/app_text.dart';
import 'package:flutter/material.dart';

import '../../constant/app_asset.dart';
import '../../constant/color_constant.dart';
import '../../widget/app_doted_button.dart';
import '../shared_preference.dart';
import 'my_account_page.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ColorConstant.appWhite,
        appBar: AppAppBar(
          showProfile: false,
          showTitle: false,
          isBackButton: false,
          appbarTitle: "Cart",
          actions: [
            AppIconButton(
              onTap: () async {
              await logOutDialog();
              },
              iconColor: ColorConstant.appThemeColor,
              iconImage: Icons.logout_outlined,
            ),
          ],
        ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const AppImageAsset(image: AppAsset.profile),
             Padding(
              padding: EdgeInsets.only(top: 15,bottom: 5),
              child: AppText(
                text: storeUserName,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            listTileWidget(title: "+91 123456789",bgColor: ColorConstant.appGreen,icon: Icons.phone_android_rounded),
            listTileWidget(title: "My Account",bgColor: ColorConstant.appThemeColor,icon: Icons.settings_outlined,onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const MyAccount()));
            }),
            listTileWidget(title: "Biz Messages",bgColor: ColorConstant.appOrange,icon: Icons.chat_bubble_outline_sharp),
            listTileWidget(title: "Email Statements",bgColor: ColorConstant.appGrey,icon: Icons.email_outlined),
            listTileWidget(title: "Help & FAQ",bgColor: ColorConstant.appOrange,icon: Icons.info_outlined),
            listTileWidget(title: "Rate Us",bgColor: ColorConstant.appThemeColor,icon: Icons.star_rate_outlined),
            listTileWidget(title: "Invite Friends & Family",bgColor: ColorConstant.appGreen,icon: Icons.person_add_alt_1_sharp),
            listTileWidget(title: "About",bgColor: ColorConstant.appGrey,icon: Icons.info_outlined),
          ],
        ),
      ),
    );
  }


  listTileWidget({
    String? title,
    Color? bgColor,
    IconData? icon,
    GestureTapCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: bgColor!.withOpacity(0.2)),
        child: Row(
          children: [
            Icon(icon,color: bgColor,size: 30,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: AppText(
                    text: title,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
            ),
            const Icon(Icons.arrow_forward_ios,size: 22,)
          ],
        ),
      ),
    );
  }

  logOutDialog(){
    return showDialog(
        context: context,
        builder: (_) => StatefulBuilder(builder: (context, setState) {
          return  Dialog(
          backgroundColor: ColorConstant.appLightBlack,
          shape: const RoundedRectangleBorder(
            borderRadius:
            BorderRadius.all(Radius.circular(10.0)),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                    padding: EdgeInsets.only(
                        bottom: 10, left: 15, right: 15,top: 10),
                    child: AppText(
                      text: "Logout",
                      textColor: ColorConstant.appWhite,
                      textAlign: TextAlign.center,
                      fontSize: 18,
                    )),
                const Padding(
                    padding: EdgeInsets.only(
                        bottom: 10, left: 15, right: 15,top: 10),
                    child: AppText(
                      text: "Are you sure want logout?",
                      textColor: ColorConstant.appWhite,
                      textAlign: TextAlign.center,
                    )),
                const SizedBox(height: 10),
                Row(
                  children:  [
                    Expanded(child: AppWithoutBgButton(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      buttonText: "No",borderColor:ColorConstant.appOrange,textColor:ColorConstant.appOrange)),
                    Expanded(
                        child: AppWithoutBgButton(
                            onTap: () async {
                              Navigator.pop(context);
                              await removePrefValue(userKey);
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pushAndRemoveUntil(
                                                    MaterialPageRoute(builder: (c) => const LoginPage()),
                                                        (route) => false);
                            },
                            buttonText: "Yes",
                            buttonColor:ColorConstant.appGreen.withOpacity(0.2) ,
                            borderColor:ColorConstant.appGreen.withOpacity(0.0),textColor:ColorConstant.appGreen)),
                  ],
                ),
              ],
            ),
          ),
        );

        })
      //     AppDialog(
      //   titleMsg: diaLogTitle ?? S.of(context).alert,
      //   alertWidget: Padding(
      //     padding: const EdgeInsets.only(bottom: 10.0),
      //     child: Column(
      //       children: [
      //         AppText(
      //           text: errorMsg,
      //           maxLines: 10,
      //         ),
      //         const SizedBox(height: 15,),
      //         SizedBox(
      //           width: 150,
      //           child: AppButton(
      //             buttonText:S.of(context).ok,
      //             onTap: () async {
      //               final tasks = await FlutterDownloader.loadTasks();
      //               tasks?.forEach((element) async {
      //                 await FlutterDownloader.remove(
      //                   taskId: element.taskId,
      //                   shouldDeleteContent: true,
      //                 );
      //               });
      //               await removePrefValue(userKey);
      //               await removePrefValue(downloadList);
      //               myVideo.clear();
      //               await GoogleSignIn().signOut();
      //               await FacebookAuth.instance.logOut();
      //               await FirebaseAuth.instance.signOut();
      //               Navigator.of(context).pushAndRemoveUntil(
      //                   MaterialPageRoute(builder: (c) => const IntroPage()),
      //                       (route) => false);
      //             },
      //           ),
      //         )
      //       ],
      //     ),
      //   ),
      // )
    );
  }

}
