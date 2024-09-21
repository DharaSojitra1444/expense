// ignore_for_file: depend_on_referenced_packages

import 'dart:math';

import 'package:expense_tracker_app/pages/markets_page/transactions%20_page.dart';
import 'package:expense_tracker_app/provider/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../constant/app_asset.dart';
import '../../constant/color_constant.dart';
import '../../provider/transation_provider.dart';

import '../../widget/app_image_assets.dart';
import '../../widget/app_text.dart';

// ignore: must_be_immutable
class BillReviewPage extends StatefulWidget {
  String? category;

  BillReviewPage({this.category, Key? key}) : super(key: key);

  @override
  State<BillReviewPage> createState() => BillReviewPageState();
}

class BillReviewPageState extends State<BillReviewPage> {
  List<CategoryChartData> chartData = [];
  int listIndex = -1;
  String? title;


  getChartInfo() async {
    TransactionProvider trans =
        Provider.of<TransactionProvider>(context, listen: false);
    chartData = await trans.getCategoryList(category: widget.category);
    title = '${DateFormat("d MMM''yy").format(trans.filterDate!)} - ${DateFormat("d MMM''yy").format(trans.filterEndDate!)}';
    setState(() {});
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getChartInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2(
        builder: (context, TransactionProvider transactionProvider,ThemeProvider themeProvider, _) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: themeProvider.isDarkMode ?ColorConstant.appBlack : ColorConstant.appWhite,
          titleSpacing: -5,
          iconTheme:  IconThemeData(
            color: themeProvider.isDarkMode ?ColorConstant.appWhite : ColorConstant.appBlack,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: widget.category,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: AppText(
                  text: title,
                  textColor: ColorConstant.appThemeColor,
                  fontSize: 12,
                ),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Column(
            children: [
              SfCartesianChart(
                  backgroundColor: ColorConstant.appWhite,
                  primaryXAxis: CategoryAxis(),
                  zoomPanBehavior: ZoomPanBehavior(
                      enableDoubleTapZooming: true,
                      enablePanning: true,
                      enablePinching: true,
                      enableSelectionZooming: true),
                  primaryYAxis: NumericAxis(
                      // Applies currency format for y axis labels and also for data labels
                      numberFormat: NumberFormat.currency(
                    symbol: "₹",
                    decimalDigits: 0,
                  )),
                  series: <ChartSeries>[
                      ColumnSeries<CategoryChartData, String>(
                      onPointTap: (ChartPointDetails details) {
                        listIndex = details.pointIndex!;
                        title = details.dataPoints![listIndex].x.toString();
                        setState(() {});
                      },
                      width: 0.5,
                      dataLabelSettings: const DataLabelSettings(
                          // showZeroValue: false,
                          isVisible: true,
                          labelPosition: ChartDataLabelPosition.outside),
                      dataSource: chartData,
                      xValueMapper: (CategoryChartData data, _) =>
                          DateFormat("MMM").format(data.dateTime!).toString(),
                      //xValueMapper: (CategoryChartData data, _) => data.dateTime!.toString(),
                      yValueMapper: (CategoryChartData data, _) => data.amt,
                      pointColorMapper: (CategoryChartData data, _) =>
                          data.color,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ]),
              bill(transactionProvider),
            ],
          ),
        ),
      );
    });
  }

  bill(TransactionProvider transactionProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 20),
          child: AppText(
            text: "Bill",
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        // ListView.builder(
        //     itemCount: 1,
        //     physics: const NeverScrollableScrollPhysics(),
        //     // scrollDirection: Axis.horizontal,
        //     shrinkWrap: true,
        //     itemBuilder: (BuildContext context, int index) {
        //       return Container(
        //         margin: const EdgeInsets.only(top: 15),
        //         padding: const EdgeInsets.symmetric(horizontal: 8),
        //         width: 280,
        //         decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(10),
        //             color: ColorConstant.appOrange),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Container(
        //               margin: const EdgeInsets.all(8),
        //               padding: const EdgeInsets.all(12),
        //               height: 50,
        //               width: 50,
        //               decoration: BoxDecoration(
        //                 color: ColorConstant.appBlack.withOpacity(0.2),
        //                 borderRadius: BorderRadius.circular(10),
        //               ),
        //               //list_alt_rounded
        //               child: const AppImageAsset(
        //                   image: AppAsset.pdfIcon,
        //                   color: ColorConstant.appWhite),
        //             ),
        //             Expanded(
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: const [
        //                   AppText(
        //                     text: "Floyd Miles",
        //                   ),
        //                   SizedBox(
        //                     height: 8,
        //                   ),
        //                   AppText(
        //                     text: "₹ 220",
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             Container(
        //               margin: const EdgeInsets.all(8),
        //               height: 50,
        //               width: 50,
        //               decoration: BoxDecoration(
        //                 shape: BoxShape.circle,
        //                 color: ColorConstant.appBlack.withOpacity(0.2),
        //               ),
        //               child: const Icon(Icons.check,
        //                   color: ColorConstant.appWhite),
        //             ),
        //           ],
        //         ),
        //       );
        //     })
        listIndex == -1
            ? ListView.builder(
                // padding: const EdgeInsets.only(left: 10, right: 20),
                itemCount: transactionProvider.filterTransactionsList.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  transactionProvider.filterTransactionsList
                      .sort((a, b) => b.datetime!.compareTo(a.datetime!));
                  if (transactionProvider
                          .filterTransactionsList[index].category ==
                      widget.category) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TransactionsPage(
                                    transItem: transactionProvider
                                        .filterTransactionsList[index], category: widget.category)));
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
                                  color: ColorConstant.colorList[Random().nextInt(
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
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      AppText(
                                        text:
                                            // transactionProvider
                                            //    .transactionsList[index].datetime,
                                            DateFormat.MMMd().format(DateTime
                                                .parse(transactionProvider
                                                    .filterTransactionsList[
                                                        index]
                                                    .datetime!)),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        maxLines: 1,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Icon(
                                          transactionProvider
                                                      .filterTransactionsList[
                                                          index]
                                                      .type ==
                                                  "Expense"
                                              ? CupertinoIcons.arrow_up_right
                                              : CupertinoIcons
                                                  .arrow_down_left,
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
                              color:  ColorConstant.colorList[Random().nextInt(
                                      ColorConstant.colorList.length)]
                                  .withOpacity(0.5),
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              )
            : ListView.builder(
                itemCount: chartData[listIndex].list!.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  chartData[listIndex]
                      .list!
                      .sort((a, b) => b.datetime!.compareTo(a.datetime!));
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TransactionsPage(
                                  transItem: chartData[listIndex]
                                      .list![index],category: widget.category,)));
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
                                color: ColorConstant.colorList[Random().nextInt(
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
                                text: chartData[listIndex]
                                    .list![index]
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
                                          //    .transactionsList[index].datetime,
                                          DateFormat.MMMd().format(
                                              DateTime.parse(
                                                  chartData[listIndex]
                                                      .list![index]
                                                      .datetime!)),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      maxLines: 1,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Icon(
                                        chartData[listIndex]
                                                    .list![index]
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
                                          '₹ ${chartData[listIndex].list![index].amount}',
                                      fontWeight: FontWeight.w500,
                                      textColor: chartData[listIndex]
                                                  .list![index]
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
    );
  }
}

class ChartData {
  ChartData(
    this.category,
    this.amt,
    this.color,
  );

  final String category;
  final int amt;
  final Color? color;
}
