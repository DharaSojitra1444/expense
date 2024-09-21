import 'package:expense_tracker_app/widget/app_doted_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../../constant/app_asset.dart';
import '../../constant/color_constant.dart';
import '../../modal/all_modal.dart';
import '../../widget/app_appbar.dart';
import '../../widget/app_button.dart';
import '../../widget/app_image_assets.dart';
import '../../widget/app_text.dart';

class UcoPage extends StatefulWidget {
  const UcoPage({Key? key}) : super(key: key);

  @override
  State<UcoPage> createState() => _UcoPageState();
}

class _UcoPageState extends State<UcoPage> {
  List<TransactionsItem> transactionsList = [
    TransactionsItem(
        name: 'Upi Funds Transfer',
        amount: "\$ 44",
        date: DateTime.now(),
        isExpense: true),
    TransactionsItem(
        name: 'Upi Funds Transfer',
        amount: "\$ 44",
        date: DateTime.now(),
        isExpense: true),
  ];
  int? selectedRadioTile;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: ColorConstant.appWhite,
        appBar: AppAppBar(
          showProfile: false,
          showTitle: true,
          appbarTitle: "UCO 123",
          actions: [
            AppIconButton(
              onTap: () {
                menuDialog();
              },
              iconColor: ColorConstant.appThemeColor,
              iconImage: CupertinoIcons.ellipsis_vertical,
            ),
            AppIconButton(
              onTap: () {
                filterDialog();
              },
              iconColor: ColorConstant.appOrange,
              iconImage: Icons.filter_alt_outlined,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                alignment: Alignment.center,
                height: 85,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorConstant.appBlack),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        AppText(
                          text: "Income",
                          textColor: ColorConstant.appWhite,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        AppText(
                          text: "₹0",
                          textColor: ColorConstant.appThemeColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        AppText(
                          text: "Spends",
                          textColor: ColorConstant.appWhite,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        AppText(
                          text: "₹1850",
                          textColor: ColorConstant.appGreen,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        AppText(
                          text: "Balance",
                          textColor: ColorConstant.appWhite,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        AppText(
                          text: "₹1",
                          textColor: ColorConstant.appOrange,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 35,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    // indicatorPadding: const EdgeInsets.symmetric(horizontal: 25),
                    physics: NeverScrollableScrollPhysics(),
                    indicatorColor: ColorConstant.appGreen,
                    unselectedLabelColor: Colors.black,
                    labelColor: Colors.black,
                    tabs: [
                      Tab(
                          icon: Text(
                        "Transactions",
                      )),
                      Tab(
                          icon: Text(
                        "Categories",
                      )),
                      Tab(
                          icon: Text(
                        "Merchants",
                      )),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    showTransactionsList(),
                    categoryList(),
                    marchant(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showTransactionsList() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Column(
          children: [
            ListView.separated(
              itemCount: transactionsList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(12),
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: ColorConstant.appThemeColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const AppImageAsset(
                          image: AppAsset.pdfIcon,
                          color: ColorConstant.appThemeColor),
                    ),
                    Expanded(
                      child: AppText(
                        text: transactionsList[index].name,
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
                              text: DateFormat.MMMd()
                                  .format(transactionsList[index].date!),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              maxLines: 1,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Icon(
                                transactionsList[index].isExpense == true
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
                              text: transactionsList[index].amount,
                              fontWeight: FontWeight.w500,
                              textColor:
                                  transactionsList[index].isExpense == true
                                      ? ColorConstant.appGreen
                                      : ColorConstant.appThemeColor,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return Container(
                  height: 1,
                  decoration: BoxDecoration(
                    color: ColorConstant.appThemeColor.withOpacity(0.5),
                  ),
                );
              },
            ),
            Container(
              height: 1,
              decoration: BoxDecoration(
                color: ColorConstant.appThemeColor.withOpacity(0.5),
              ),
            )
          ],
        ),
        Row(
          children: [
            Expanded(
                child: AppWithoutBgButton(
              buttonText: "Sep ‘21",
              textColor: ColorConstant.appBlack,
              borderColor: ColorConstant.appThemeColor.withOpacity(0.1),
              buttonColor: ColorConstant.appThemeColor.withOpacity(0.4),
              showFirstIcon: true,
            )),
            Expanded(
                child: AppWithoutBgButton(
              buttonText: "Sep ‘02",
              textColor: ColorConstant.appBlack,
              borderColor: ColorConstant.appOrange.withOpacity(0.1),
              buttonColor: ColorConstant.appOrange.withOpacity(0.4),
              showLastIcon: true,
            )),
          ],
        )
      ],
    );
  }

  categoryList() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRect(
            child: Align(
              heightFactor: 0.45,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SfRadialGauge(axes: <RadialAxis>[
                  RadialAxis(
                      showAxisLine: false,
                      showLabels: false,
                      minimum: 0,
                      maximum: 100,
                      endAngle: 0,
                      radiusFactor: 0.9,
                      startAngle: 180,
                      canScaleToFit: true,
                      ranges: <GaugeRange>[
                        GaugeRange(
                            startValue: 0,
                            endValue: 30,
                            color: ColorConstant.appThemeColor,
                            startWidth: 20,
                            endWidth: 20),
                        GaugeRange(
                            startValue: 30,
                            endValue: 100,
                            color: ColorConstant.appBlack,
                            startWidth: 20,
                            endWidth: 20),
                      ],
                      // pointers: <GaugePointer>[
                      //   NeedlePointer(value: 0)],
                      pointers: const <GaugePointer>[
                        RangePointer(
                          value: 0,
                          width: 0,
                        )
                      ],
                      annotations: <GaugeAnnotation>[
                        GaugeAnnotation(
                            widget: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.only(
                                            right: 5, top: 5),
                                        height: 8,
                                        width: 8,
                                        decoration: const BoxDecoration(
                                            color: ColorConstant.appBlack,
                                            shape: BoxShape.circle)),
                                    const AppText(
                                        maxLines: 10,
                                        text: "Unknown 97.3 %",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.only(
                                            right: 5, top: 5),
                                        height: 8,
                                        width: 8,
                                        decoration: const BoxDecoration(
                                            color: ColorConstant.appThemeColor,
                                            shape: BoxShape.circle)),
                                    const AppText(
                                        maxLines: 10,
                                        text: "Bills 2.7%",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ],
                                ),
                              ],
                            ),
                            angle: 90,
                            positionFactor: 0.7)
                      ])
                ]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: AppText(
              text: "Non - Budgeted categories",
              fontSize: 16,
              textColor: ColorConstant.appBlack.withOpacity(0.5),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 15,),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 170,
                  decoration: BoxDecoration(
                    color: ColorConstant.appThemeColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Align(
                        alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 15,top: 10),
                            child: AppText(text: "Unknown",fontWeight: FontWeight.w600,),
                          )),
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: Icon(
                            Icons.error_outline_outlined,
                            size: 30,
                            color: ColorConstant.appThemeColor),
                      ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: AppText(text: "₹1,800",fontWeight: FontWeight.w600,),)
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 15,),
              Expanded(
                child: Container(
                  height: 170,
                  decoration: BoxDecoration(
                    color: ColorConstant.appOrange.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 15,top: 10),
                            child: AppText(text: "Bills",fontWeight: FontWeight.w600,),
                          )),
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: AppImageAsset(
                            image: AppAsset.pdfIcon,
                            color: ColorConstant.appThemeColor),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: AppText(text: "₹100",fontWeight: FontWeight.w600,),)
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  marchant() {
    return Column(
      children: const [
        SizedBox(
          height: 10,
        ),
        Center(
          child: AppImageAsset(
            image: AppAsset.spendsImg,
            height: 170,
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.only(top: 15),
            child: AppText(
                text: "No Spends",
                textAlign: TextAlign.center,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }

  menuDialog() async {
    await showDialog(
        context: context,
        builder: (_) =>
            StatefulBuilder(builder: (context, setState) {
              return Dialog(
                backgroundColor: ColorConstant.appBlack,
                child:
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: const [
                         ListTile(
                           dense:true,
                           title: AppText(text: 'Link Account',textColor: ColorConstant.appWhite)),
                         ListTile( dense:true,
                           title: AppText(text: 'Settings',textColor: ColorConstant.appWhite),),
                         ListTile(
                           dense:true,title: AppText(text: 'Add Spend',textColor: ColorConstant.appWhite),),
                      ],
                    ),
                  ),
                )
                ,);
            })
    );
  }

  filterDialog() async {
    await showDialog(
        context: context,
        builder: (_) =>
            StatefulBuilder(builder: (context, setState) {
              return Dialog(
                backgroundColor: ColorConstant.appBlack,
                child:
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children:  [
                        Theme(
                          data: Theme.of(context).copyWith(
                              unselectedWidgetColor: ColorConstant.appThemeColor,
                          ),
                          child: RadioListTile(
                            contentPadding: EdgeInsets.zero,
                            value: 1,
                            title:Transform.translate(
                              offset: const Offset(-15, 0),
                              child: const AppText(text: 'Custom Date',textColor: ColorConstant.appWhite,),
                              ),
                            onChanged: (value) {
                              setState(() {
                                selectedRadioTile = value as int;
                              });
                            },
                            activeColor: ColorConstant.appOrange,
                            groupValue: selectedRadioTile,
                          ),
                        ),
                        selectedRadioTile == 1 ?
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(children: [
                                const Icon(Icons.calendar_today_rounded,color: ColorConstant.appGreen),
                                const SizedBox(width: 10,),
                                Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  AppText(text: "Start Date",textColor: ColorConstant.appWhite.withOpacity(0.4),), const SizedBox(height: 2,),
                                  const AppText(text: "01 October 2022",textColor: ColorConstant.appWhite,)
                                ],)
                              ],),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0,top: 20),
                              child: Row(children: [
                                const Icon(Icons.calendar_today_rounded,color: ColorConstant.appOrange),
                                const SizedBox(width: 10,),
                                Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(text: "End Date",textColor: ColorConstant.appWhite.withOpacity(0.4),), const SizedBox(height: 2,),
                                    const AppText(text: "31 October 2022",textColor: ColorConstant.appWhite,)
                                  ],)
                              ],),
                            )
                          ],
                        )
                            :const SizedBox(),
                        Theme(
                          data: Theme.of(context).copyWith(
                            unselectedWidgetColor: ColorConstant.appThemeColor,
                          ),
                          child: RadioListTile(
                            contentPadding: EdgeInsets.zero,
                            value: 2,
                            title:Transform.translate(
                              offset: const Offset(-15, 0),
                              child: const AppText(text: 'Last 3 Months',textColor: ColorConstant.appWhite,),
                            ),
                            onChanged: (value) {
                              setState(() {
                                selectedRadioTile = value as int;
                              });
                            },
                            activeColor: ColorConstant.appOrange,
                            groupValue: selectedRadioTile,
                          ),
                        ),
                        Theme(
                          data: Theme.of(context).copyWith(
                            unselectedWidgetColor: ColorConstant.appThemeColor,
                          ),
                          child: RadioListTile(
                            contentPadding: EdgeInsets.zero,
                            value: 3,
                            title:Transform.translate(
                              offset: const Offset(-15, 0),
                              child: const AppText(text: 'All Time',textColor: ColorConstant.appWhite,),
                            ),
                            onChanged: (value) {
                              setState(() {
                                selectedRadioTile = value as int;
                              });
                            },
                            activeColor: ColorConstant.appOrange,
                            groupValue: selectedRadioTile,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children:  [
                            Expanded(child: AppWithoutBgButton(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              buttonText: "Export",borderColor:ColorConstant.appOrange,textColor:ColorConstant.appOrange,)),
                            Expanded(
                                child: AppWithoutBgButton(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  buttonText: "Apply",
                                  buttonColor:ColorConstant.appGreen.withOpacity(0.2) ,
                                  borderColor:ColorConstant.appGreen.withOpacity(0.0),textColor:ColorConstant.appGreen)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ));
            })
    );
  }
}

