import 'dart:math';

import 'package:expense_tracker_app/constant/app_asset.dart';
import 'package:expense_tracker_app/widget/app_appbar.dart';
import 'package:expense_tracker_app/widget/app_image_assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant/color_constant.dart';
import '../../provider/transation_provider.dart';
import '../../widget/app_text.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => NotificationPageState();
}

class NotificationPageState extends State<NotificationPage> {
  int? lisLength;

  @override
  Widget build(BuildContext context) {
     lisLength = 0;
    return Consumer(
      builder: (context,TransactionProvider transactionProvider,_) {
        return Scaffold(
          // backgroundColor: ColorConstant.appWhite,
          appBar: AppAppBar(
            showProfile: false,
            showTitle: true,
            appbarTitle: "Notification",
            // actions: [
            //   Container(
            //     alignment: Alignment.center,
            //     margin: const EdgeInsets.only(right: 10),
            //     padding: const EdgeInsets.all(15),
            //     decoration: BoxDecoration(
            //         shape: BoxShape.circle,
            //         color: ColorConstant.appThemeColor.withOpacity(0.2)),
            //     child: const AppText(
            //       text: "3",
            //     ),
            //   )
            // ],
          ),
          body: transactionProvider.reminderList.isEmpty ?
          Align(
            alignment: Alignment.center,
            child: Column(
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: AppImageAsset(
                    image: AppAsset.spendsImg,
                    height: 150,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: AppText(
                      text: "No any notification found ",
                      textAlign: TextAlign.center,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),

              ],
            ),
          ):
          ListView.builder(
              itemCount: transactionProvider.reminderList.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                DateTime dateSchedule=  DateTime.parse(transactionProvider.reminderList[index].reminderDate!);
                if(dateSchedule.isBefore(DateTime.now())) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                        leading: const AppImageAsset(
                          image: AppAsset.profile,
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                                text: transactionProvider
                                    .reminderList[index].reminderName
                              //  'Contrary to popular belief, Lorem Ipsum is not simply random text.',
                            ),
                            AppText(
                                text: transactionProvider
                                    .reminderList[index].reminderDate
                              //  'Contrary to popular belief, Lorem Ipsum is not simply random text.',
                            ),
                          ],
                        ),
                        trailing: Container(
                            margin: const EdgeInsets.only(right: 10),
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorConstant.colorList[Random()
                                    .nextInt(
                                    ColorConstant.colorList.length)]))
                    ),
                  );
                }else{
                  lisLength = (lisLength!+1);
                  return lisLength == transactionProvider.reminderList.length ?
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: AppImageAsset(
                            image: AppAsset.spendsImg,
                            height: 150,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: AppText(
                              text: "No notification found",
                              textAlign: TextAlign.center,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),

                      ],
                    ),
                  ) : Container();
                }
              }),
        );
      }
    );
  }
}
