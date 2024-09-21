import 'package:expense_tracker_app/widget/app_appbar.dart';
import 'package:expense_tracker_app/widget/app_text.dart';
import 'package:flutter/material.dart';

import '../../constant/app_asset.dart';
import '../../constant/color_constant.dart';
import '../../widget/app_button.dart';
import '../../widget/app_doted_button.dart';
import '../../widget/app_image_assets.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  CalendarState createState() => CalendarState();
}

class CalendarState extends State<Calendar> {
  DateTime selectedDate = DateTime.now(); // TO tracking date

  int currentDateSelectedIndex = 0; //For Horizontal Date
  ScrollController scrollController =
  ScrollController(); //To Track Scroll of ListView

  List<String> listOfMonths = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  List<String> listOfDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.appWhite,
      appBar: AppAppBar(
        showProfile: false,
        showTitle: true,
        appbarTitle: "Family",
        actions: [
          AppIconButton(
            onTap: () {
            },
            iconColor: ColorConstant.appGreen,
            iconImage: Icons.filter_alt_outlined,
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //To Show Current Date
                // Container(
                //     height: 30,
                //     margin: EdgeInsets.only(left: 10),
                //     alignment: Alignment.centerLeft,
                //     child: Text(
                //       selectedDate.day.toString() +
                //           '-' +
                //           listOfMonths[selectedDate.month - 1] +
                //           ', ' +
                //           selectedDate.year.toString(),
                //       style: TextStyle(
                //           fontSize: 18,
                //           fontWeight: FontWeight.w800,
                //           color: Colors.indigo[700]),
                //     )),
                const SizedBox(height: 10),
                //To show Calendar Widget
                SizedBox(
                    height: 80,
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(width: 10);
                      },
                      itemCount: 365,
                      controller: scrollController,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              currentDateSelectedIndex = index;
                              selectedDate =
                                  DateTime.now().add(Duration(days: index));
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 2),
                            height: 80,
                            width: 60,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                // boxShadow: const [
                                //   BoxShadow(
                                //       color: Colors.grey,
                                //       offset: Offset(3, 3),
                                //       blurRadius: 5)
                                // ],
                                color: currentDateSelectedIndex == index
                                    ? ColorConstant.appGreen
                                        : ColorConstant.appBlack.withOpacity(0.1)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppText(text: listOfMonths[DateTime.now()
                                    .add(Duration(days: index))
                                    .month -
                                    1]
                                    .toString(),textColor: currentDateSelectedIndex == index
                                    ? Colors.white
                                    : Colors.grey,),
                                const SizedBox(
                                  height: 5,
                                ),
                                AppText(text:  DateTime.now()
                                    .add(Duration(days: index))
                                    .day
                                    .toString(),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  textColor: currentDateSelectedIndex == index
                                    ? Colors.white
                                    : Colors.grey,),
                                const SizedBox(
                                  height: 5,
                                ),
                                AppText(text: listOfDays[DateTime.now()
                                    .add(Duration(days: index))
                                    .weekday -
                                    1]
                                    .toString(),textColor: currentDateSelectedIndex == index
                                    ? Colors.white
                                    : Colors.grey,),
                              ],
                            ),
                          ),
                        );
                      },
                    )),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    alignment: Alignment.center,
                    height: 85,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: ColorConstant.appBlack),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            AppText(text: "Total Spent",textColor: ColorConstant.appWhite,fontWeight: FontWeight.w600,),
                            SizedBox(height: 10,),
                            AppText(text: "₹0",textColor: ColorConstant.appGreen,fontSize: 16,fontWeight: FontWeight.w600,)
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            AppText(text: "Total Income",textColor: ColorConstant.appWhite,fontWeight: FontWeight.w600,),
                            SizedBox(height: 10,),
                            AppText(text: "₹0",textColor: ColorConstant.appThemeColor,fontSize: 16,fontWeight: FontWeight.w600,)
                          ],
                        )
                      ],
                    ),
                  ),
                const SizedBox(
                  height: 10,
                ),
                const AppText(text: "Spends",textAlign: TextAlign.center,fontSize: 16,fontWeight: FontWeight.w600),
                const Center(
                  child: AppImageAsset(
                    image: AppAsset.spendsImg,
                    height: 170,
                  ),
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: AppText(text: "No Spends",textAlign: TextAlign.center,fontSize: 16,fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ),
          Row(
            children:   [
              Expanded(
                  child: AppWithoutBgButton(buttonText: "Sep ‘21",
                  textColor:ColorConstant.appBlack,
                  borderColor:ColorConstant.appThemeColor.withOpacity(0.1),
                  buttonColor:ColorConstant.appThemeColor.withOpacity(0.4),
                  showFirstIcon: true,
              )),
              Expanded(child: AppWithoutBgButton(buttonText: "Sep ‘02",
                textColor:ColorConstant.appBlack,
                borderColor:ColorConstant.appOrange.withOpacity(0.1),
                buttonColor:ColorConstant.appOrange.withOpacity(0.4),
                showLastIcon: true,
              )),
            ],
          )
        ],
      ),
    );
  }
}