// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'package:dotted_border/dotted_border.dart';
import 'package:expense_tracker_app/constant/app_asset.dart';
import 'package:expense_tracker_app/pages/home_page/notification_page.dart';
import 'package:expense_tracker_app/pages/home_page/view_user_trans_page.dart';
import 'package:expense_tracker_app/pages/markets_page/add_tansation_page.dart';
import 'package:expense_tracker_app/pages/welcome_page.dart';
import 'package:expense_tracker_app/provider/theme_provider.dart';
import 'package:expense_tracker_app/provider/transation_provider.dart';
import 'package:expense_tracker_app/widget/app_button.dart';
import 'package:expense_tracker_app/widget/app_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import '../../constant/color_constant.dart';
import '../../modal/all_modal.dart';
import '../../provider/user_transaction_provider.dart';
import '../../widget/app_appbar.dart';
import '../../widget/app_image_assets.dart';
import '../markets_page/all_transation_page.dart';
import '../markets_page/transactions _page.dart';
import 'add_contact_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<SendMoneyItem> sendMoneyList = [
    SendMoneyItem(
        name: "Family", amount: "10,000", duration: "This week", type: "Sent"),
    SendMoneyItem(
        name: "Brother",
        amount: "40,000",
        duration: "This month",
        type: "Sent"),
  ];

  List<DepositsItem> depositsList = [
    DepositsItem(
        title: "City Bank Limited",
        subTitle: "\$ 200 Per Month",
        image: AppAsset.bankImg),
    DepositsItem(
        title: "City Bank Limited",
        subTitle: "\$ 200 Per Month",
        image: AppAsset.bankImg),
  ];

  getTransaction() async {
    TransactionProvider trans =
        Provider.of<TransactionProvider>(context, listen: false);
    await trans.getAllTransaction();
    await trans.getFilterValue(isChart: false);
    await trans.getAllReminder();
    UserTransactionProvider userTrans =
        Provider.of<UserTransactionProvider>(context, listen: false);
    userTrans.getUserTransaction();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTransaction();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3(builder: (context,
        TransactionProvider transactionProvider,
        ThemeProvider themeProvider,
        UserTransactionProvider userTransactionProvider,
        _) {
      return Scaffold(
        // backgroundColor: ColorConstant.appWhite,
        appBar: AppAppBar(
          appbarTitle: storeUserName,
          actions: [
            GestureDetector(
                onTap: () {
                  themeProvider.swapTheme();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: themeProvider.isDarkMode
                      ? const Icon(
                          Icons.dark_mode_outlined,
                          color: ColorConstant.appWhite,
                        )
                      : const Icon(
                          Icons.light_mode,
                          color: ColorConstant.appBlack,
                        ),
                )),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationPage()));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 5,right: 20),
                child: Icon(
                  Icons.notifications_outlined,
                  color: themeProvider.isDarkMode
                      ? ColorConstant.appWhite
                      : ColorConstant.appBlack,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              moneyManager(transactionProvider, themeProvider),
              sendMoney(transactionProvider),
              // bankBalance(),
              deposits(userTransactionProvider)
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: themeProvider.isDarkMode
              ? ColorConstant.appWhite
              : ColorConstant.appBlack,
          icon:  Icon(
            Icons.person_add_alt_1_rounded,
            color: themeProvider.isDarkMode
                ? ColorConstant.appBlack
                : ColorConstant.appWhite,
            size: 20,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddContactPage()));
          },
          label: AppText(
            text: "ADD USER",
            textColor: themeProvider.isDarkMode
                ? ColorConstant.appBlack
                : ColorConstant.appWhite,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    });
  }

  moneyManager(TransactionProvider transactionProvider, ThemeProvider themeProvider) {
    return Container(
      height: 160,
      margin: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: themeProvider.isDarkMode
              ? ColorConstant.appWhite
              : ColorConstant.appBlack),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                AppText(
                  text: "Money Manager ",
                  textColor: themeProvider.isDarkMode
                      ? ColorConstant.appBlack
                      : ColorConstant.appWhite,
                  fontWeight: FontWeight.w600,
                ),
                AppText(
                  text: ">  ${DateFormat("MMMM").format(DateTime.now())}",
                  textColor: ColorConstant.appOrange,
                  fontWeight: FontWeight.w600,
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  CircularPercentIndicator(
                    radius: 50.0,
                    lineWidth: 8.0,
                    percent: 0.8,
                    backgroundColor: Colors.grey,
                    center: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppImageAsset(
                                image: AppAsset.arrowUpIcon, height: 18,color:themeProvider.isDarkMode
                                ? ColorConstant.appBlack
                                : ColorConstant.appWhite,),
                            SizedBox(
                              width: 5,
                            ),
                            AppText(
                              text: "Spends",
                              textColor: themeProvider.isDarkMode
                                  ? ColorConstant.appBlack
                                  : ColorConstant.appWhite,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        AppText(
                          text: "₹ ${transactionProvider.totalExpense}",
                          textColor: themeProvider.isDarkMode
                              ? ColorConstant.appBlack
                              : ColorConstant.appWhite,
                        ),
                      ],
                    ),
                    progressColor: ColorConstant.appGreen,
                  ),
                  Expanded(
                      child: AppText(
                    text: "Recent Transactions",
                    textColor: themeProvider.isDarkMode
                        ? ColorConstant.appBlack
                        : ColorConstant.appWhite,
                    textAlign: TextAlign.center,
                  )),
                  CircularPercentIndicator(
                    radius: 50.0,
                    lineWidth: 8.0,
                    percent: 0.8,
                    backgroundColor: Colors.grey,
                    center: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppImageAsset(
                                image: AppAsset.arrowDownIcon, height: 18,color:themeProvider.isDarkMode
                                ? ColorConstant.appBlack
                                : ColorConstant.appWhite, ),
                            SizedBox(
                              width: 5,
                            ),
                            AppText(
                              text: "Income",
                              textColor: themeProvider.isDarkMode
                                  ? ColorConstant.appBlack
                                  : ColorConstant.appWhite,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        AppText(
                          text: "₹ ${transactionProvider.totalIncome}",
                          textColor: themeProvider.isDarkMode
                              ? ColorConstant.appBlack
                              : ColorConstant.appWhite,
                        ),
                      ],
                    ),
                    progressColor: ColorConstant.appThemeColor,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  sendMoney(TransactionProvider transactionProvider) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AppText(
                text: "Sent Money",
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              InkWell(
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AllTransactionPage()));
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: AppText(
                    text: "View All",
                    textColor: ColorConstant.appThemeColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
        transactionProvider.filterTransactionsList.isEmpty
            ? Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: AppImageAsset(
                      image: AppAsset.spendsImg,
                      height: 150,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: AppText(
                        text: "No any transaction added",
                        textAlign: TextAlign.center,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  addButton()
                ],
              )
            : ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount:
                    transactionProvider.filterTransactionsList.length <= 5
                        ? transactionProvider.filterTransactionsList.length + 1
                        : 6,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  int length =
                      transactionProvider.filterTransactionsList.length <= 5
                          ? transactionProvider.filterTransactionsList.length +
                              1
                          : 6;
                  if (index == length - 1) {
                    return addButton();
                  } else {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TransactionsPage(
                                    transItem:transactionProvider.filterTransactionsList[index])));
                      },
                      child: Container(
                        height: 80,
                        margin: const EdgeInsets.only(top: 15),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        // width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: transactionProvider
                                        .filterTransactionsList[index].type ==
                                    "Expense"
                                ? ColorConstant.appGreen
                                : ColorConstant.appThemeColor),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(12),
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: ColorConstant.appBlack.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              //list_alt_rounded
                              child: const AppImageAsset(
                                  image: AppAsset.pdfIcon,
                                  color: ColorConstant.appWhite),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                    text: transactionProvider
                                        .filterTransactionsList[index]
                                        .description,
                                    textColor: ColorConstant.appWhite,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    maxLines: 2,
                                  ),
                                  AppText(
                                    text: transactionProvider
                                        .filterTransactionsList[index].type,
                                    maxLines: 1,
                                    textColor: ColorConstant.appWhite,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: AppText(
                                          maxLines: 1,
                                          text:
                                              '₹ ${transactionProvider.filterTransactionsList[index].amount}',
                                          textColor: ColorConstant.appWhite,
                                        ),
                                      ),
                                      AppText(
                                        text: DateFormat.yMMMd().format(
                                            DateTime.parse(transactionProvider
                                                .filterTransactionsList[index]
                                                .datetime!)),
                                        textColor: ColorConstant.appWhite,
                                      ),
                                    ],
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
                  }
                },
              )
      ],
    );
  }

  addButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddTranslation()));
        },
        child: DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(5),
            dashPattern: const [4, 4],
            color: ColorConstant.appThemeColor,
            strokeWidth: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.add,
                    size: 25,
                  ),
                  AppText(
                    text: "Add",
                    fontSize: 15,
                  ),
                ],
              ),
            )),
      ),
    );
  }

// bankBalance() {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       const Padding(
//         padding: EdgeInsets.only(top: 20, bottom: 10),
//         child: AppText(
//           text: "Bank Balance",
//           fontSize: 16,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//       Container(
//         height: 120,
//         width: MediaQuery.of(context).size.width,
//         child: ListView.builder(
//           itemCount: 2,
//           scrollDirection: Axis.horizontal,
//           shrinkWrap: true,
//           itemBuilder: (BuildContext context, int index) {
//             if (index == 1) {
//               return addButton();
//             } else {
//               return Container(
//                 margin: EdgeInsets.only(right: 15),
//                 padding: EdgeInsets.symmetric(horizontal: 8),
//                 width: 280,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: ColorConstant.appBlack),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: const [
//                         AppText(
//                           text: "\$1,200",
//                           fontSize: 18,
//                           textColor: ColorConstant.appWhite,
//                         ),
//                         AppText(
//                           text: "Visa",
//                           fontSize: 18,
//                           textColor: ColorConstant.appWhite,
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: const [
//                         Padding(
//                           padding: EdgeInsets.only(left: 5),
//                           child: AppText(
//                             text: "4225  xxxx  xxxx  xxxx",
//                             textColor: ColorConstant.appWhite,
//                             fontSize: 18,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: const [
//                         AppText(
//                           text: "Debit Card",
//                           textColor: ColorConstant.appWhite,
//                         ),
//                         AppText(
//                           text: "09/24",
//                           textColor: ColorConstant.appWhite,
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               );
//             }
//           },
//         ),
//       )
//     ],
//   );
// }
//
  deposits(UserTransactionProvider userTransactionProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              AppText(
                text: "Customers",
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              // InkWell(
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => AddContactPage()));
              //   },
              //   child:
              //   // Text(
              //   //   "Add User",
              //   //   style: TextStyle(
              //   //     shadows: [
              //   //       Shadow(
              //   //           color: Colors.black,
              //   //           offset: Offset(0, -5))
              //   //     ],
              //   //     color: Colors.transparent,
              //   //     decoration:
              //   //     TextDecoration.underline,
              //   //     decorationColor: Colors.deepPurple,
              //   //     decorationThickness: 1,
              //   //     decorationStyle:
              //   //     TextDecorationStyle.dashed,
              //   //   ),
              //   // )
              //   AppText(
              //     text: "Add Customer",
              //     textColor: ColorConstant.appThemeColor,
              //     decoration: TextDecoration.underline,
              //   ),
              // ),
            ],
          ),
        ),
        ListView.builder(
            itemCount: userTransactionProvider.userTransList.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              userTransactionProvider.userTransList
                  .sort((a, b) => b.userDate!.compareTo(a.userDate!));
              return InkWell(
                onTap: () {
                  // UserTransactionProvider userTrans =
                  // Provider.of<UserTransactionProvider>(context,
                  //     listen: false);
                  // userTrans.deleteUserTransaction(deleteId: userTransactionProvider.userTransList[index].eid);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewUserTransPage(
                              userTransList: userTransactionProvider
                                  .userTransList[index])));
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: index % 2 == 0
                          ? ColorConstant.appOrange
                          : ColorConstant.appThemeColor),
                  child: ListTile(
                    leading: CircleAvatar(
                        radius: 25,
                        backgroundColor:
                            ColorConstant.appBlack.withOpacity(0.2),
                        child: userTransactionProvider
                                .userTransList[index].userName!.isNotEmpty
                            ? AppText(
                                text: userTransactionProvider
                                    .userTransList[index].userName![0],
                                textColor: ColorConstant.appWhite,
                                fontSize: 16)
                            : const Icon(Icons.person,
                                color: ColorConstant.appWhite)),
                    // const AppImageAsset(
                    //   image: AppAsset.bankImg,
                    // ),
                    title: AppText(
                      text:
                          userTransactionProvider.userTransList[index].userName,
                      fontSize: 16,
                      textColor: index % 2 == 0
                          ? ColorConstant.appBlack
                          : ColorConstant.appWhite,
                    ),
                    subtitle: AppText(
                      text:
                          userTransactionProvider.userTransList[index].phoneNo,
                      fontSize: 12,
                      textColor: index % 2 == 0
                          ? ColorConstant.appBlack
                          : ColorConstant.appWhite,
                    ),
                  ),
                ),
              );
            }),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
