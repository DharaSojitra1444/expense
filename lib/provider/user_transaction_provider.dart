import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../modal/all_modal.dart';
import '../sqflite_database/database.dart';

class UserTransactionProvider extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  List<ExpenseModel> userTransList = [];

  getUserTransaction() async {
    userTransList = await DatabaseProvider.getUserExpense();
    notifyListeners();
  }

  deleteUserTransaction({String? deleteId}) {
    DatabaseProvider.deleteUserTrans(deleteId!);
    // getAllTransaction();
  }

  // onSearch(String text) async {
  //   searchTransactionsList.clear();
  //   if (text.isEmpty) {
  //     notifyListeners();
  //     return;
  //   }
  //   for (var doc in filterTransactionsList) {
  //     if (doc.description!.toLowerCase().contains(text.toLowerCase())) {
  //       searchTransactionsList.add(doc);
  //     }
  //   }
  //   print("---->searchDocuments ${searchTransactionsList.length}");
  //   notifyListeners();
  // }


}




