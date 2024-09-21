import 'dart:math';
import 'package:flutter/material.dart';
import '../../modal/all_modal.dart';
import '../constant/color_constant.dart';
import '../pages/markets_page/bill_review_page.dart';
import '../sqflite_database/database.dart';

class TransactionProvider extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  List<TransactionModel> transactionsList = [];
  List<ReminderModel> reminderList = [];
  List<TransactionModel> searchTransactionsList = [];
  List<TransactionModel> filterTransactionsList = [];
  List<DateTime>? month;
  int? tappedIndex;
  DateTime? filterDate;
  DateTime? filterEndDate;

  List<ChartData> chartData = [];
  int totalAmt = 0;
  int totalExpense = 0;
  int totalIncome = 0;
  int balance = 0;

  getAllTransaction() async {
    transactionsList = await DatabaseProvider.getAllTransaction();
    notifyListeners();
  }

  getAllReminder() async {
    reminderList = await DatabaseProvider.getReminder();
    notifyListeners();
  }

  deleteTransaction({String? deleteId}) {
    DatabaseProvider.deleteTransaction(deleteId!);
    getAllTransaction();
  }

  updateTransaction({TransactionModel? transactionModel, bool? filter}) async {
    //await DatabaseProvider.updateTransaction(transactionModel);
    await getAllTransaction();
    // if(filter == true) {
    //   print("--->filter ");
    //   getChartDate();
    // }
  }

  onSearch(String text) async {
    searchTransactionsList.clear();
    if (text.isEmpty) {
      notifyListeners();
      return;
    }
    for (var doc in filterTransactionsList) {
      if (doc.description!.toLowerCase().contains(text.toLowerCase())) {
        searchTransactionsList.add(doc);
      }
    }
    notifyListeners();
  }

  static List<DateTime> getMonthsInYear(DateTime createdDate, int length) {
    List<DateTime> years = [];
    int currentYear = createdDate.year;
    int currentMonth = createdDate.month;
    for (int i = 0; i < length; i++) {
      createdDate = DateTime(currentYear, currentMonth - i);
      // years.add(dateFormat.format(createdDate));
      years.add(createdDate);
    }
    return years.reversed.toList();
  }

  getFilterValue({bool isChart = true}) {
    month = getMonthsInYear((DateTime.now()), 10);
    tappedIndex = month!.length - 1;
    filterDate = month![tappedIndex!];
    filterEndDate = DateTime(filterDate!.year, filterDate!.month + 1, 1)
        .subtract(const Duration(days: 1));
    getChartDate(isChart: isChart);
  }

  // getChartDate({bool isChart = true}) async {
  //   filterTransactionsList.clear();
  //   chartData.clear();
  //   totalAmt = 0;
  //   for (var element in transactionsList) {
  //     // List<String> result = element.datetime!.split('-');
  //     // String isDate = "${result[2]}-${result[1]}-${result[0]}";
  //     // print("-->filterTransactionsList isDate ${isDate}");
  //     if ((filterDate!.isBefore(DateTime.parse(element.datetime!)) &&
  //             DateTime.parse(element.datetime!).isBefore(filterEndDate!)) ||
  //         filterDate!.difference(DateTime.parse(element.datetime!)).inDays ==
  //             0 ||
  //         filterEndDate!.difference(DateTime.parse(element.datetime!)).inDays ==
  //             0) {
  //       filterTransactionsList.add(element);
  //       if (isChart) {
  //         var contain =
  //             chartData.where((chart) => chart.category == element.category);
  //         if (contain.isNotEmpty) {
  //           var index = chartData
  //               .indexWhere((user) => user.category == element.category);
  //           int add = chartData[index].amt + int.parse(element.amount!);
  //           chartData[index] = ChartData(
  //               '${element.category}',
  //               add,
  //               Colors.primaries[Random().nextInt(Colors.primaries.length)]
  //                   [Random().nextInt(9) * 100]);
  //         } else {
  //           chartData.add(ChartData(
  //               '${element.category}',
  //               int.parse(element.amount!),
  //               Colors.primaries[Random().nextInt(Colors.primaries.length)]
  //                   [Random().nextInt(9) * 100]));
  //         }
  //       }
  //     }
  //   }
  //   filterTransactionsList.sort((a, b) => b.datetime!.compareTo(a.datetime!));
  //   chartData.forEach((element) {
  //     totalAmt = totalAmt + element.amt;
  //   });
  //   print("----->chartData ${chartData.length}");
  //   print("----->totalAmt $totalAmt");
  // }

  getChartDate({bool isChart = true}) async {
    filterTransactionsList.clear();
    chartData.clear();
    totalAmt = 0;
    totalExpense = 0;
    totalIncome = 0;
    balance = 0;
    for (var element in transactionsList) {
      if ((filterDate!.isBefore(DateTime.parse(element.datetime!)) &&
              DateTime.parse(element.datetime!).isBefore(filterEndDate!)) ||
          filterDate!.difference(DateTime.parse(element.datetime!)).inDays ==
              0 ||
          filterEndDate!.difference(DateTime.parse(element.datetime!)).inDays ==
              0) {
        filterTransactionsList.add(element);
        if (isChart) {
          if (element.type == "Expense") {
            var contain =
                chartData.where((chart) => chart.category == element.category);
            if (contain.isNotEmpty) {
              var index = chartData
                  .indexWhere((user) => user.category == element.category);
              int add = chartData[index].amt + int.parse(element.amount!);
              chartData[index] = ChartData(
                  '${element.category}',
                  add,
                  // ([...Colors.primaries]..shuffle()).first
                  Color(Random().nextInt(0xffffffff)).withAlpha(0xff)
                  // Colors.primaries[Random().nextInt(Colors.primaries.length)]
                  // [Random().nextInt(9) * 100]
                  );
            } else {
              chartData.add(ChartData(
                  '${element.category}',
                  int.parse(element.amount!),
                  // ([...Colors.primaries]..shuffle()).first
                   Color(Random().nextInt(0xffffffff)).withAlpha(0xff)
                  // Colors.primaries[Random().nextInt(Colors.primaries.length)]
                  // [Random().nextInt(9) * 100]
                  ));
            }
          }
        }
      }
    }

    filterTransactionsList.sort((a, b) => b.datetime!.compareTo(a.datetime!));
    for (var e in filterTransactionsList) {
      if (e.type == "Expense") {
        totalExpense = totalExpense + int.parse(e.amount!);
        balance = balance + int.parse(e.amount!);
      } else {
        totalIncome = totalIncome + int.parse(e.amount!);
        balance = balance - int.parse(e.amount!);
      }
    }
    for (var element in chartData) {
      totalAmt = totalAmt + element.amt;
    }
  }

  getCategoryList({String? category}) async {
    List<CategoryChartData>? chartMonth =
        getMonthsCategory((DateTime.now()), 10);
    for (var element in chartMonth) {
      for (var elementCategory in transactionsList) {
        if (elementCategory.category == category &&
            elementCategory.type == "Expense") {
          if (DateTime.parse(elementCategory.createMonth!) ==
              element.dateTime) {
            var index = chartMonth.indexWhere((user) =>
                user.dateTime == DateTime.parse(elementCategory.createMonth!));
            int amt =
                chartMonth[index].amt! + int.parse(elementCategory.amount!);
            List<TransactionModel> add =
                chartMonth[index].list! + [elementCategory];
            chartMonth[index] = CategoryChartData(
                dateTime: element.dateTime,
                list: add,
                amt: amt,
                color: chartMonth[index].color);
          }
        }
      }
    }
    return chartMonth;
  }

  static List<CategoryChartData> getMonthsCategory(
      DateTime createdDate, int length) {
    List<CategoryChartData> years = [];
    List<Color> color = [
      ColorConstant.appThemeColor,
      ColorConstant.appGreen,
      ColorConstant.appOrange,
      ColorConstant.appBlack,
      ColorConstant.appOrange,
      ColorConstant.appThemeColor,
      ColorConstant.appGreen,
      ColorConstant.appOrange,
      ColorConstant.appBlack,
      ColorConstant.appOrange
    ];
    int currentYear = createdDate.year;
    int currentMonth = createdDate.month;
    for (int i = 0; i < length; i++) {
      createdDate = DateTime(currentYear, currentMonth - i);
      // years.add(dateFormat.format(createdDate));
      years.add(CategoryChartData(
          dateTime: createdDate, list: [], amt: 0, color: color[i]));
    }
    return years.reversed.toList();
  }
}

class CategoryChartData {
  CategoryChartData({this.dateTime, this.amt, this.color, this.list});

  final DateTime? dateTime;
  final int? amt;
  final Color? color;
  final List<TransactionModel>? list;
}
