import 'dart:math';
import 'package:dotted_border/dotted_border.dart';
import 'package:expense_tracker_app/pages/markets_page/add_tansation_page.dart';
import 'package:expense_tracker_app/pages/markets_page/all_transation_page.dart';
import 'package:expense_tracker_app/pages/markets_page/transactions%20_page.dart';
import 'package:expense_tracker_app/widget/app_image_assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../../constant/app_asset.dart';
import '../../constant/color_constant.dart';
import '../../provider/theme_provider.dart';
import '../../provider/transation_provider.dart';
import '../../sqflite_database/database.dart';
import '../../widget/app_appbar.dart';
import '../../widget/app_doted_button.dart';
import '../../widget/app_text.dart';
import '../welcome_page.dart';
import 'add_reminder_page.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  State<MarketPage> createState() => MarketPageState();
}

class MarketPageState extends State<MarketPage> {
  List<String> contentsList = ['Today', 'This Week', 'This Month'];
  int tappedIndex = 0;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //  // getTransaction();
  // }
  //
  // getTransaction() async {
  //   TransactionProvider trans =
  //       Provider.of<TransactionProvider>(context, listen: false);
  //   //await trans.getAllTransaction();
  //  // await trans. getAllReminder();
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer2(builder: (context, TransactionProvider transactionProvider,
        ThemeProvider themeProvider, _) {
      return Scaffold(
        appBar: AppAppBar(
          appbarTitle: storeUserName,
          actions: [
            // const AppIconButton(
            //   iconColor: ColorConstant.appOrange,
            //   iconImage: Icons.search,
            // ),
            AppIconButton(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddTranslation()));
              },
              iconColor: ColorConstant.appGreen,
              iconImage: Icons.add,
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              ClipRect(
                child: Align(
                  heightFactor: 0.5,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 10, left: 25, right: 25),
                    child: SfRadialGauge(axes: <RadialAxis>[
                      RadialAxis(
                          showAxisLine: false,
                          showLabels: false,
                          minimum: 0,
                          maximum: 150,
                          endAngle: 0,
                          radiusFactor: 0.9,
                          startAngle: 180,
                          canScaleToFit: true,
                          ranges: <GaugeRange>[
                            GaugeRange(
                                startValue: 0,
                                endValue: 50,
                                color: ColorConstant.appThemeColor,
                                startWidth: 20,
                                endWidth: 20),
                            GaugeRange(
                                startValue: 50,
                                endValue: 100,
                                color: ColorConstant.appOrange,
                                startWidth: 20,
                                endWidth: 20),
                            GaugeRange(
                                startValue: 100,
                                endValue: 150,
                                color: ColorConstant.appGrey,
                                startWidth: 20,
                                endWidth: 20),
                          ],
                          // pointers: <GaugePointer>[
                          //   NeedlePointer(value: 0)],
                          pointers: const <GaugePointer>[
                            RangePointer(
                              value: 0,
                              width: 0,
                              //     sizeUnit: GaugeSizeUnit.factor,
                              //     enableAnimation: true,
                              //     animationDuration: 100,
                              //     animationType: AnimationType.linear,
                              //     cornerStyle: CornerStyle.bothCurve
                            )
                          ],
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                                widget: Column(
                                  children: [
                                    const AppText(
                                      text: 'Balance',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    AppText(
                                      text: '₹ ${transactionProvider.balance}',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                                angle: 90,
                                positionFactor: 0.75)
                          ])
                    ]),
                  ),
                ),
              ),
              showChatInfo(),
              showTransactions(),
              // showButton(),
              showButton1(transactionProvider),
              showTransactionsList(transactionProvider),
              accounts(themeProvider),
              reminders(transactionProvider),
              // tags(),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      );
    });
  }

  showChatInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.only(right: 5, top: 5),
                height: 8,
                width: 8,
                decoration: const BoxDecoration(
                    color: ColorConstant.appThemeColor,
                    shape: BoxShape.circle)),
            const AppText(
                maxLines: 10,
                text: "Transfer",
                fontWeight: FontWeight.w500,
                fontSize: 16),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.only(right: 5, top: 5),
                height: 8,
                width: 8,
                decoration: const BoxDecoration(
                    color: ColorConstant.appOrange, shape: BoxShape.circle)),
            const AppText(
                maxLines: 10,
                text: "Payment",
                fontWeight: FontWeight.w500,
                fontSize: 15),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.only(right: 5, top: 5),
                height: 8,
                width: 8,
                decoration: const BoxDecoration(
                    color: ColorConstant.appGrey, shape: BoxShape.circle)),
            const AppText(
                maxLines: 10,
                text: "Other",
                fontWeight: FontWeight.w500,
                fontSize: 15),
          ],
        ),
      ],
    );
  }

  showTransactions() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AppText(
                text: "Transactions",
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AllTransactionPage()));
                },
                child: const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: AppText(
                    text: "See all",
                    textColor: ColorConstant.appThemeColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  showButton() {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(top: 5, bottom: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: contentsList.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              setState(() {
                tappedIndex = index;
              });
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: index == 0 ? 0 : 15.0),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: tappedIndex == index
                          ? ColorConstant.appThemeColor
                          : ColorConstant.appBlack,
                      width: 1.2),
                  // color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10.0)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: AppText(
                  text: contentsList[index],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  showButton1(TransactionProvider transactionProvider) {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(top: 5, bottom: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: contentsList.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              setState(() {
                tappedIndex = index;
                DatabaseProvider.getUserExpense();
                if (tappedIndex == 0) {
                  DatabaseProvider.getUserExpense();
                  transactionProvider.filterDate = DateTime.now();
                  transactionProvider.filterEndDate = DateTime.now();
                  transactionProvider.getChartDate(isChart: false);
                } else if (tappedIndex == 1) {
                  transactionProvider.filterDate =
                      DateTime.now().subtract(const Duration(days: 7));
                  transactionProvider.filterEndDate = DateTime.now();
                  transactionProvider.getChartDate(isChart: false);
                } else {
                  transactionProvider.filterDate = DateTime(
                      transactionProvider.filterDate!.year,
                      transactionProvider.filterDate!.month,
                      1);
                  transactionProvider.filterEndDate = DateTime(
                          transactionProvider.filterDate!.year,
                          transactionProvider.filterDate!.month + 1,
                          1)
                      .subtract(const Duration(days: 1));
                  transactionProvider.getChartDate(isChart: false);
                }
              });
            },
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 15.0),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: tappedIndex == index
                          ? ColorConstant.appThemeColor
                          : ColorConstant.appBlack,
                      width: 1.2),
                  // color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10.0)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: AppText(
                  text: contentsList[index],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  showTransactionsList(TransactionProvider transactionProvider) {
    return transactionProvider.filterTransactionsList.isEmpty
        ? const Padding(
            padding: EdgeInsets.all(8.0),
            child: AppText(text: "Transactions list is empty"),
          )
        : ListView.builder(
            itemCount: transactionProvider.filterTransactionsList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              // transactionProvider.filterTransactionsList
              //     .sort((a, b) => b.datetime!.compareTo(a.datetime!));
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TransactionsPage(
                                transItem: transactionProvider
                                    .filterTransactionsList[index],
                              )));
                },
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(12),
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: ColorConstant.colorList[Random()
                                    .nextInt(ColorConstant.colorList.length)]
                                .withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const AppImageAsset(
                              image: AppAsset.pdfIcon,
                              color: ColorConstant.appThemeColor),
                        ),
                        Expanded(
                          child: AppText(
                            text: transactionProvider
                                .filterTransactionsList[index].description,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            maxLines: 1,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Row(
                              children: [
                                AppText(
                                  text: DateFormat.MMMd().format(DateTime.parse(
                                      transactionProvider
                                          .filterTransactionsList[index]
                                          .datetime!)),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  maxLines: 1,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Icon(
                                    transactionProvider
                                                .filterTransactionsList[index]
                                                .type ==
                                            "Expense"
                                        ? CupertinoIcons.arrow_up_right
                                        : CupertinoIcons.arrow_down_left,
                                    size: 15,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 1),
                              child: AppText(
                                  text:
                                      '₹ ${transactionProvider.filterTransactionsList[index].amount}',
                                  fontWeight: FontWeight.w500,
                                  textColor: transactionProvider
                                              .filterTransactionsList[index]
                                              .type ==
                                          "Expense"
                                      ? ColorConstant.appGreen
                                      : ColorConstant.appThemeColor,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      height: 1,
                      decoration: BoxDecoration(
                        color: ColorConstant.colorList[Random()
                                .nextInt(ColorConstant.colorList.length)]
                            .withOpacity(0.5),
                      ),
                    )
                  ],
                ),
              );
            },
          );
  }

  accounts(ThemeProvider themeProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 20, bottom: 10),
          child: AppText(
            text: "Accounts",
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 80,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            itemCount: 2,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              if (index == 1) {
                return DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(10),
                    dashPattern: const [4, 4],
                    color: ColorConstant.appOrange,
                    strokeWidth: 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: const Center(
                        child: Icon(
                          Icons.add,
                          size: 30,
                        ),
                      ),
                    ));
              } else {
                return Container(
                  margin: const EdgeInsets.only(right: 15),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  width: 280,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: themeProvider.isDarkMode
                          ? ColorConstant.appDialogBlack
                          : ColorConstant.appBlack),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8),
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorConstant.appThemeColor.withOpacity(0.5),
                        ),
                        child: const Icon(Icons.insert_drive_file_outlined,
                            color: ColorConstant.appThemeColor),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const AppText(
                            text: "₹0 Spent",
                            textColor: ColorConstant.appWhite,
                          ),
                          Container(
                            color: ColorConstant.appWhite,
                            height: 1,
                            width: 100,
                          ),
                          const AppText(
                            text: "Balance ₹700",
                            textColor: ColorConstant.appWhite,
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorConstant.appThemeColor.withOpacity(0.5),
                        ),
                        child: const Icon(Icons.refresh_outlined,
                            color: ColorConstant.appThemeColor),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        )
      ],
    );
  }

  reminders(TransactionProvider transactionProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AppText(
                text: "Reminders",
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddReminderPage()));
                  },
                  child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(5),
                      dashPattern: const [2, 2],
                      color: ColorConstant.appThemeColor,
                      strokeWidth: 2,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        child: Center(
                          child: Row(
                            children: const [
                              Icon(
                                Icons.add,
                                size: 18,
                              ),
                              AppText(
                                text: "Add",
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                      ))

                  // const AppText(
                  //   text: "+ Add",
                  //   fontSize: 16,
                  //   fontWeight: FontWeight.w600,
                  // ),
                  ),
            ],
          ),
        ),
        transactionProvider.reminderList.isEmpty
            ? Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: const [
                      // Icon(Icons.alarm,size: 45,color: ColorConstant.appThemeColor,),
                      AppImageAsset(
                        image: AppAsset.reminderIcon,
                        height: 60,
                        width: 60,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      AppText(
                        text: "No bill Reminders!",
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      )
                    ],
                  ),
                ),
              )
            : ListView.builder(
                itemCount: transactionProvider.reminderList.length,
                physics: const NeverScrollableScrollPhysics(),
                // scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () async {
                      // await DatabaseProvider.deleteReminder(transactionProvider.reminderList[index].rid!);
                      // await DatabaseProvider.getReminder();
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 15),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorConstant.appOrange),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(8),
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorConstant.appBlack.withOpacity(0.2),
                            ),
                            child: const Icon(Icons.insert_drive_file_outlined,
                                color: ColorConstant.appWhite),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  text: transactionProvider
                                      .reminderList[index].reminderName,
                                  textColor: ColorConstant.appWhite,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                AppText(
                                  text:
                                      "₹ ${transactionProvider.reminderList[index].reminderAmt}",
                                  textColor: ColorConstant.appWhite,
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                AppText(
                                  text:
                                      "${transactionProvider.reminderList[index].reminderDate}",
                                  textColor: ColorConstant.appWhite,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(8),
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorConstant.appBlack.withOpacity(0.2),
                            ),
                            child: const Icon(Icons.check,
                                color: ColorConstant.appWhite),
                          ),
                        ],
                      ),
                    ),
                  );
                })
      ],
    );
  }

// tags() {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       const Padding(
//         padding: EdgeInsets.only(top: 20, bottom: 10),
//         child: AppText(
//           text: "Reminders",
//           fontSize: 16,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//       ListView.builder(
//           itemCount: 1,
//           physics: NeverScrollableScrollPhysics(),
//           // scrollDirection: Axis.horizontal,
//           shrinkWrap: true,
//           itemBuilder: (BuildContext context, int index) {
//             return Container(
//               margin: EdgeInsets.only(top: 15),
//               padding: EdgeInsets.symmetric(horizontal: 8),
//               width: 280,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: ColorConstant.appThemeColor),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     alignment: Alignment.center,
//                     margin: const EdgeInsets.all(8),
//                     height: 50,
//                     width: 50,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: ColorConstant.appBlack.withOpacity(0.2),
//                     ),
//                     child: const AppText(
//                       text: "#",
//                       textColor: ColorConstant.appWhite,
//                       fontSize: 30,
//                     ),
//                   ),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: const [
//                         AppText(
//                           text: "Floyd Miles",
//                           textColor: ColorConstant.appWhite,
//                         ),
//                         SizedBox(
//                           height: 8,
//                         ),
//                         AppText(
//                           text: "₹ 220",
//                           textColor: ColorConstant.appWhite,
//                         ),
//                       ],
//                     ),
//                   ),
//                   const AppText(
//                     text: "Transaction:220",
//                     textColor: ColorConstant.appWhite,
//                   ),
//                 ],
//               ),
//             );
//           })
//     ],
//   );
// }
}
