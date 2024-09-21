// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, duplicate_ignore, depend_on_referenced_packages, use_build_context_synchronously

import 'dart:math';
import 'package:expense_tracker_app/pages/markets_page/bill_review_page.dart';
import 'package:expense_tracker_app/pages/markets_page/transactions%20_page.dart';
import 'package:expense_tracker_app/provider/theme_provider.dart';
import 'package:expense_tracker_app/widget/app_doted_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../constant/app_asset.dart';
import '../../constant/color_constant.dart';
import '../../provider/transation_provider.dart';
import '../../widget/app_button.dart';
import '../../widget/app_image_assets.dart';
import '../../widget/app_text.dart';

class AllTransactionPage extends StatefulWidget {
  const AllTransactionPage({Key? key}) : super(key: key);

  @override
  State<AllTransactionPage> createState() => AllTransactionPageState();
}

class AllTransactionPageState extends State<AllTransactionPage> {
  bool isSearch = false;
  bool showFilter = false;
  List<ChartData> chartData = [];
  DateFormat dateFormat = DateFormat("d MMM''yy" );
  DateFormat dateFormat2 = DateFormat("MMM" );
  int? selectedRadioTile;

  showButton(TransactionProvider transactionProvider,ThemeProvider themeProvider) {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(right: 10,bottom: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: transactionProvider.month!.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
               setState(() {
                transactionProvider.tappedIndex = index;
                transactionProvider.filterDate = transactionProvider.month![index];
                transactionProvider.filterEndDate = DateTime(transactionProvider.filterDate!.year, transactionProvider.filterDate!.month+1, 1).subtract( const Duration(days: 1));
                transactionProvider.getChartDate();
              });
            },
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 15.0),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: transactionProvider.tappedIndex == index
                          ? ColorConstant.appThemeColor
                          : themeProvider.isDarkMode ? ColorConstant.appGrey: ColorConstant.appBlack,
                      width: 1.2),
                  // color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10.0)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: AppText(
                  text: dateFormat2.format(transactionProvider.month![index]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    TransactionProvider trans =
    Provider.of<TransactionProvider>(context, listen: false);
    trans.getFilterValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2(
        builder: (context, TransactionProvider transactionProvider,ThemeProvider themeProvider ,_) {
      return WillPopScope(
        onWillPop: () async {
          transactionProvider.searchController.clear();
          transactionProvider.searchTransactionsList.clear();
          if(transactionProvider.filterTransactionsList.isEmpty){
            transactionProvider.getFilterValue(isChart: false);
            transactionProvider.notifyListeners();
          }
          return true;
        },
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
              backgroundColor: themeProvider.isDarkMode ? ColorConstant.appBlack:ColorConstant.appWhite,

              appBar: AppBar(
                toolbarHeight: 60,
                elevation: 0.0,
                leading:  BackButton(
                  onPressed: (){
                    if(transactionProvider.filterTransactionsList.isEmpty){
                      transactionProvider.getFilterValue(isChart: false);
                      transactionProvider.notifyListeners();
                    }
                    Navigator.pop(context);
                  },
                  color:themeProvider.isDarkMode ? ColorConstant.appWhite:ColorConstant.appBlack,) ,
                automaticallyImplyLeading: true,
                iconTheme:  IconThemeData(
                  color:themeProvider.isDarkMode ? ColorConstant.appWhite:ColorConstant.appBlack,
                ),
                titleSpacing: -10,
                backgroundColor: themeProvider.isDarkMode ? ColorConstant.appBlack:ColorConstant.appWhite,
                title: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: "${dateFormat.format(transactionProvider.filterDate!)} - ${dateFormat.format(transactionProvider.filterEndDate!)}",
                          fontWeight: FontWeight.w600,
                        ),
                        const AppText(
                          text: "All transaction",
                          fontSize: 12,
                          textColor: ColorConstant.appThemeColor,
                          // fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    showFilter
                        ? GestureDetector(
                            onTap: () {
                              showFilter = !showFilter;
                              setState(() {});
                            },
                            child:  Padding(
                              padding: const EdgeInsets.only(left: 5,right: 5,bottom: 12,top: 2),
                              child: Icon(Icons.keyboard_arrow_up_outlined,color: themeProvider.isDarkMode ? ColorConstant.appWhite:ColorConstant.appBlack),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              showFilter = !showFilter;
                              setState(() {});
                            },
                             child: Padding(
                               padding: const EdgeInsets.only(left: 5,right: 5,bottom: 12,top: 2),
                              child: Icon(Icons.keyboard_arrow_down,color: themeProvider.isDarkMode ? ColorConstant.appWhite:ColorConstant.appBlack),
                            ),
                          )
                  ],
                ),
                actions: [
                  AppIconButton(
                    onTap: () {
                      filterDialog(transactionProvider,themeProvider);
                    },
                    iconColor: ColorConstant.appGreen,
                    iconImage: Icons.filter_alt_outlined,
                  ),
                ],
              ),
              body: Column(
                children: [
                  showFilter ? showButton(transactionProvider,themeProvider) : const SizedBox(),
                  SizedBox(
                    height: 35,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: TabBar(
                        onTap: (value) {},
                        indicatorSize: TabBarIndicatorSize.label,
                        physics: const NeverScrollableScrollPhysics(),
                        indicatorColor: ColorConstant.appGreen,
                        unselectedLabelColor: Colors.black,
                        labelColor: Colors.black,
                        tabs: const [
                          Tab(
                              icon: AppText(text:
                            "Transactions",
                          )),
                          Tab(
                              icon: AppText(text:
                            "Categories",
                          )),
                          Tab(
                              icon: AppText(text:
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
                        showTransactionsList(transactionProvider),
                        categoryView(transactionProvider),
                        merchant(),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      );
    });
  }

  showTransactionsList(TransactionProvider transactionProvider) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: ColorConstant.appThemeColor)),
            child: TextField(
              controller: transactionProvider.searchController,
              decoration: InputDecoration(
                suffixIconConstraints: const BoxConstraints(
                  minWidth: 3,
                  minHeight: 2,
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    isSearch = !isSearch;
                    if (isSearch == false) {
                      transactionProvider.searchController.clear();
                      transactionProvider.searchTransactionsList.clear();
                    }

                    transactionProvider.notifyListeners();
                  },
                  child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorConstant.appThemeColor),
                      child: const Icon(
                        Icons.clear,
                        color: ColorConstant.appWhite,
                        size: 18,
                      )),
                ),
                contentPadding: const EdgeInsets.only(left: 8),
                hintText: 'Search here ...',
                hintStyle: const TextStyle(
                  color: ColorConstant.appThemeColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                border: InputBorder.none,
              ),
              style: const TextStyle(
                fontSize: 15,
                color: ColorConstant.appThemeColor,
                fontWeight: FontWeight.w500,
              ),
              onChanged: (value) {
                transactionProvider.onSearch(value);
              },
            ),
          ),
          (transactionProvider.searchTransactionsList.isNotEmpty ||
                  transactionProvider.searchController.text.isNotEmpty)
              ? ListView.builder(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                  itemCount: transactionProvider.searchTransactionsList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    // List<String> result = transactionProvider
                    //     .searchTransactionsList[index].datetime!
                    //     .split('-');
                    // String isDate = "${result[2]}-${result[1]}-${result[0]}";
                    transactionProvider.searchTransactionsList
                        .sort((a, b) => b.datetime!.compareTo(a.datetime!));
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TransactionsPage(
                                    transItem: transactionProvider
                                        .searchTransactionsList[index])));
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
                                          .nextInt(
                                              ColorConstant.colorList.length)]
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
                                      .searchTransactionsList[index]
                                      .description,
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
                                        text:
                                            // transactionProvider
                                            //     .transactionsList[index].datetime,
                                            DateFormat.MMMd()
                                                .format(DateTime.parse(transactionProvider.searchTransactionsList[index].datetime!)),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        maxLines: 1,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Icon(
                                          transactionProvider
                                                      .searchTransactionsList[
                                                          index]
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
                                            '₹ ${transactionProvider.searchTransactionsList[index].amount}',
                                        fontWeight: FontWeight.w500,
                                        textColor: transactionProvider
                                                    .searchTransactionsList[
                                                        index]
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
                )
              :
          transactionProvider.filterTransactionsList.isEmpty
                  ?  Padding(
                      padding: const EdgeInsets.only(top: 15,bottom: 10),
                      child: Column(
                        children: const [
                          AppImageAsset(
                            image: AppAsset.spendsImg,
                            height: 150,
                          ),
                          AppText(text: "Transactions list is empty",fontSize: 15,fontWeight: FontWeight.w600,),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(left: 10, right: 20),
                      itemCount: transactionProvider.filterTransactionsList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        transactionProvider.filterTransactionsList
                            .sort((a, b) => b.datetime!.compareTo(a.datetime!));
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TransactionsPage(
                                          transItem: transactionProvider
                                              .filterTransactionsList[index])));
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
                                        color: ColorConstant
                                            .colorList[Random().nextInt(
                                                ColorConstant.colorList.length)]
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
                                            .filterTransactionsList[index]
                                            .description,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        maxLines: 1,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            AppText(
                                              text:
                                                  // transactionProvider
                                                  //    .transactionsList[index].datetime,
                                                  DateFormat.MMMd().format(
                                                      DateTime.parse(transactionProvider.filterTransactionsList[index].datetime!)),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              maxLines: 1,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Icon(
                                                transactionProvider
                                                            .filterTransactionsList[
                                                                index]
                                                            .type ==
                                                        "Expense"
                                                    ? CupertinoIcons
                                                        .arrow_up_right
                                                    : CupertinoIcons
                                                        .arrow_down_left,
                                                size: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 1),
                                          child: AppText(
                                              text:
                                                  '₹ ${transactionProvider.filterTransactionsList[index].amount}',
                                              fontWeight: FontWeight.w500,
                                              textColor: transactionProvider
                                                          .filterTransactionsList[
                                                              index]
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
                    )
        ],
      ),
    );
  }

  categoryView(TransactionProvider transactionProvider) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          transactionProvider.chartData.isEmpty ?
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: AppImageAsset(
                  image: AppAsset.spendsImg,
                  height: 150,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: AppText(
                    text: "No Category",
                    textAlign: TextAlign.center,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              )
            ],
          )
              :SizedBox(
              height: 250,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: SfCircularChart(series: <CircularSeries>[
                      DoughnutSeries<ChartData, String>(
                        // radius: '50%',
                        dataSource: transactionProvider.chartData,
                        pointColorMapper: (ChartData data, _) => data.color,
                        xValueMapper: (ChartData data, _) => data.category,
                        yValueMapper: (ChartData data, _) => data.amt,
                        enableTooltip: true,
                        // dataLabelMapper: (data, __) => '${data.category}',
                        // dataLabelSettings: DataLabelSettings(
                        //  isVisible: true,
                        //  labelIntersectAction: LabelIntersectAction.none,
                        //  labelAlignment: ChartDataLabelAlignment.auto,
                        //  connectorLineSettings: ConnectorLineSettings(
                        //    length: '0',
                        //   // type: ConnectorType.line,
                        //    width: 0,
                        //   ),
                        //   labelPosition: ChartDataLabelPosition.outside,
                        // ),
                        explode: true,
                        // explodeIndex: 1,
                        onPointTap: (pointInteractionDetails) {
                          var tappedValue = pointInteractionDetails
                              .dataPoints![pointInteractionDetails.pointIndex!]
                              .x
                              .toString();
                          debugPrint("-->category $tappedValue");
                          Navigator.push(
                              context,
                               MaterialPageRoute(builder: (context) =>
                                      BillReviewPage(category: tappedValue)));
                        },
                         // Explode all the segments
                        //explodeAll: true
                      )
                    ]),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      width: 100,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: transactionProvider.chartData.length,
                        itemBuilder: (BuildContext context, int index) {
                          var myInt = (transactionProvider.chartData[index].amt /transactionProvider.totalAmt) * 100;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  margin: const EdgeInsets.only(right: 5),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: transactionProvider.chartData[index].color),
                                ),
                                Expanded(
                                    child: AppText(
                                        textAlign: TextAlign.start,
                                        text:transactionProvider.chartData[index].category,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.03)),
                                AppText(
                                    textAlign: TextAlign.justify,
                                    text: ' ${myInt.toStringAsFixed(2)}%',
                                    fontWeight: FontWeight.w600,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.03),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              )),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: transactionProvider.chartData.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          BillReviewPage(category: transactionProvider.chartData[index].category)));
                },
                child: Container(
                  height: 170,
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: ColorConstant.appThemeColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, top: 10),
                            child: AppText(
                              text: transactionProvider.chartData[index].category,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: methodIcon(transactionProvider.chartData[index].category) != null
                            ? AppImageAsset(
                                image: methodIcon(transactionProvider.chartData[index].category))
                            : const Icon(Icons.error_outline_outlined,
                                size: 30, color: ColorConstant.appThemeColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: AppText(
                          text: '₹ ${transactionProvider.chartData[index].amt.toString()}',
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  merchant() {
    return Column(
      children: const [
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: AppImageAsset(
            image: AppAsset.spendsImg,
            height: 150,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: AppText(
              text: "No Spends",
              textAlign: TextAlign.center,
              fontSize: 16,
              fontWeight: FontWeight.w600),
        )
      ],
    );
  }

  String? methodIcon(String category) {
    if (category == 'Bills') {
      return AppAsset.pdfIcon;
    }
    if (category == 'EMI') {
      return AppAsset.emlIcon;
    }
    if (category == 'Entertainment') {
      return AppAsset.entertainmentIcon;
    }
    if (category == 'Food') {
      return AppAsset.foodIcon;
    }
    if (category == 'Fule') {
      return AppAsset.fuleIcon;
    }
    if (category == 'Groceries') {
      return AppAsset.groceriesIcon;
    }
    if (category == 'Health') {
      return AppAsset.healthIcon;
    }
    if (category == 'Investment') {
      return AppAsset.investmentIcon;
    }
    if (category == 'Other') {
      return AppAsset.otherIcon;
    }
    if (category == 'Shopping') {
      return AppAsset.shopping_1Icon;
    }
    if (category == 'Transfer') {
      return AppAsset.transferIcon;
    }
    if (category == 'Travel') {
      return AppAsset.travelIcon;
    }
    return null;
  }

  filterDialog(TransactionProvider transactionProvider,ThemeProvider themeProvider) async {
    await showDialog(
        context: context,
        builder: (_) =>
            StatefulBuilder(builder: (context, setState) {
              return Dialog(
                  backgroundColor: themeProvider.isDarkMode
                      ? ColorConstant.appDialogBlack
                      : ColorConstant.appBlack,
                  child: SingleChildScrollView(
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
                              InkWell(
                                onTap: () async {
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  DateTime? pickerDate = await showDatePicker(
                                      context: context,
                                      firstDate: DateTime(1960),
                                      initialDate: DateTime.now(),
                                      lastDate: DateTime.now(),
                                      builder: (context, child) {
                                        return Theme(
                                          data: ThemeData.dark().copyWith(
                                            colorScheme: const ColorScheme.dark(
                                              onPrimary: ColorConstant.appBlack,
                                              onSurface: ColorConstant.appWhite,
                                              primary: ColorConstant.appWhite, // circle color
                                            ),
                                            dialogBackgroundColor: ColorConstant.appLightBlack,
                                          ),
                                          child: child!,
                                        );
                                      }
                                  );

                                  if (pickerDate != null) {
                                    if(pickerDate.isBefore(transactionProvider.filterDate!)){
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              backgroundColor: ColorConstant.appDialogBlack,
                                              title: const AppText(text : "Invalid Date",textAlign: TextAlign.center,fontSize: 16,fontWeight: FontWeight.w500,),
                                              content: const AppText(text :"Please select datetime after start date!"),
                                              actions: <Widget>[
                                                FlatButton(
                                                  child: const AppText(text :"Close"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                )
                                              ],
                                            );
                                          }
                                      );
                                    }
                                    else{
                                      print("--->filterEndDate");
                                      transactionProvider.filterEndDate = pickerDate;
                                    }
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Row(children: [
                                    const Icon(Icons.calendar_today_rounded,color: ColorConstant.appGreen),
                                    const SizedBox(width: 10),
                                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                         AppText(text: "Start Date",textColor: ColorConstant.appWhite.withOpacity(0.4),), const SizedBox(height: 2,),
                                         AppText(text: transactionProvider.filterDate.toString().substring(0,10),textColor: ColorConstant.appWhite,)
                                      ],)
                                  ],),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  DateTime? pickerDate = await showDatePicker(
                                      context: context,
                                      firstDate: DateTime(1960),
                                      initialDate: DateTime.now(),
                                      lastDate: DateTime.now(),
                                      builder: (context, child) {
                                        return Theme(
                                          data: ThemeData.dark().copyWith(
                                            colorScheme: const ColorScheme.dark(
                                              onPrimary: ColorConstant.appBlack,
                                              onSurface: ColorConstant.appWhite,
                                              primary: ColorConstant.appWhite, // circle color
                                            ),
                                            dialogBackgroundColor: ColorConstant.appLightBlack,
                                          ),
                                          child: child!,
                                        );
                                      }
                                  );
                                     if (pickerDate != null) {
                                       if(pickerDate.isBefore(transactionProvider.filterDate!)){
                                         showDialog(
                                             context: context,
                                             builder: (BuildContext context) {
                                               return AlertDialog(
                                                 backgroundColor: ColorConstant.appDialogBlack,
                                                 title: AppText(text : "Invalid Date",textAlign: TextAlign.center,fontSize: 16,fontWeight: FontWeight.w500,),
                                                 content: AppText(text :"Please select datetime after start date!"),
                                                 actions: <Widget>[
                                                   FlatButton(
                                                     child: AppText(text :"Close"),
                                                     onPressed: () {
                                                       Navigator.of(context).pop();
                                                     },
                                                   )
                                                 ],
                                               );
                                             }
                                         );
                                       }
                                       else{
                                         print("--->filterEndDate");
                                         transactionProvider.filterEndDate = pickerDate;
                                       }
                                     }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0,top: 20),
                                  child: Row(children: [
                                    const Icon(Icons.calendar_today_rounded,color: ColorConstant.appOrange),
                                    const SizedBox(width: 10,),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5,bottom: 5),
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          AppText(text: "End Date",textColor: ColorConstant.appWhite.withOpacity(0.4),), const SizedBox(height: 2,),
                                          AppText(text: transactionProvider.filterEndDate.toString().substring(0,10),textColor: ColorConstant.appWhite,)
                                        ]),
                                    )
                                  ],),
                                ),
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
                                  DateTime now = DateTime.now();
                                  transactionProvider.filterEndDate = DateTime(now.year, now.month+1, 1).subtract( const Duration(days: 1));
                                  transactionProvider.filterDate = DateTime(now.year, now.month-2, 1);
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
                                child: const AppText(text: 'Last 6 Months',textColor: ColorConstant.appWhite,),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  selectedRadioTile = value as int;
                                  DateTime now = DateTime.now();
                                  transactionProvider.filterEndDate = DateTime(now.year, now.month+1, 1).subtract( const Duration(days: 1));
                                  transactionProvider.filterDate = DateTime(now.year, now.month-5, 1);
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
                              value: 4,
                              title:Transform.translate(
                                offset: const Offset(-15, 0),
                                child: const AppText(text: 'All Time',textColor: ColorConstant.appWhite,),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  selectedRadioTile = value as int;
                                  DateTime now = DateTime.now();
                                  transactionProvider.filterEndDate = DateTime(now.year, now.month+1, 1).subtract( const Duration(days: 1));
                               //   transactionProvider.filterDate = DateTime(1960,1, 1);
                               transactionProvider.filterDate = DateTime(now.year, now.month-9, 1);
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
                                buttonText: "Cancel",borderColor:ColorConstant.appOrange,textColor:ColorConstant.appOrange,)),
                              Expanded(
                                  child: AppWithoutBgButton(
                                      onTap: () async {
                                        selectedRadioTile = 0;
                                        await transactionProvider.getChartDate();
                                        transactionProvider.notifyListeners();
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
