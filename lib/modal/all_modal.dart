import 'package:flutter/material.dart';

class SendMoneyItem {
  String? name;
  String? type;
  String? amount;
  String? duration;

  SendMoneyItem({this.name, this.type, this.amount, this.duration});
}

class DepositsItem {
  String? title;
  String? subTitle;
  String? image;

  DepositsItem({this.title, this.subTitle, this.image});
}

class TransactionsItem {
  String? name;
  DateTime? date;
  String? amount;
  bool? isExpense;

  TransactionsItem({this.name, this.date, this.amount, this.isExpense});
}

class CategoryItem {
  String? image;
  String? title;

  CategoryItem({this.title, this.image});
}

class ProductItem {
  String? title;
  String? discount;
  String? image;
  String? productName;
  String? amount;
  Color? color;
  int? qty;

  ProductItem(
      {this.title,
      this.discount,
      this.image,
      this.productName,
      this.amount,
      this.color,
      this.qty});
}

class UserInformation {
  UserInformation({
    this.id,
    this.name,
    this.email,
  });

  String? id;
  String? name;
  String? email;

  factory UserInformation.fromJson(Map<String, dynamic> json) =>
      UserInformation(
        id: json["id"],
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {"id": id, "name": name, "email": email};
}

class TransactionModel {
  final String? id;
  final String? type;
  final String? amount;
  final String? datetime;
  final String? category;
  final String? description;
  final String? tag;
  final String? userId;
  final String? createMonth;

  TransactionModel(
      {this.id,
      this.type,
      this.amount,
      this.datetime,
      this.category,
      this.description,
      this.tag,
      this.userId,
      this.createMonth});

  TransactionModel fromJson(Map<String, dynamic> json) => TransactionModel(
      id: json['id'],
      type: json['type'],
      amount: json['amount'],
      datetime: json['datetime'],
      category: json['category'],
      description: json['description'],
      tag: json['tag'],
      userId: json['userId'],
      createMonth: json['createMonth']);

  Map<String, dynamic> toMap() => {
        'id': id,
        'type': type,
        'amount': amount,
        'datetime': datetime,
        'category': category,
        'description': description,
        'tag': tag,
        'userId': userId,
        'createMonth': createMonth
      };
}

class ReminderModel {
  final String? rid;
  final String? reminderName;
  final String? reminderAmt;
  final String? reminderDate;
  final String? userId;

  ReminderModel({
    this.rid,
    this.reminderName,
    this.reminderAmt,
    this.reminderDate,
    this.userId,
  });

  ReminderModel fromJson(Map<String, dynamic> json) => ReminderModel(
      rid: json['rid'],
      reminderName: json['reminderName'],
      reminderAmt: json['reminderAmt'],
      reminderDate: json['reminderDate'],
      userId: json['userId']);

  Map<String, dynamic> toMap() => {
        'rid': rid,
        'reminderName': reminderName,
        'reminderAmt': reminderAmt,
        'reminderDate': reminderDate,
        'userId': userId
      };
}

class ExpenseModel {
  final String? eid;
  final String? userName;
  final String? userAmt;
  final String? userDate;
  final String? phoneNo;
  final String? dataList;
  final String? userId;

  ExpenseModel({
    this.eid,
    this.userName,
    this.userAmt,
    this.userDate,
    this.phoneNo,
    this.dataList,
    this.userId,
  });

  ExpenseModel fromJson(Map<String, dynamic> json) => ExpenseModel(
      eid: json['eid'],
      userName: json['userName'],
      userAmt: json['userAmt'],
      userDate: json['userDate'],
      phoneNo: json['phoneNo'],
      dataList: json['dataList'],
      userId: json['userId']);

  Map<String, dynamic> toMap() => {
        'eid': eid,
        'userName': userName,
        'userAmt': userAmt,
        'userDate': userDate,
        'phoneNo': phoneNo,
        'dataList': dataList,
        'userId': userId
      };
}

class EditExpenseModel {
  // final String? id;
  final String? userName;
  final String? userAmt;
  final bool? isGave;
  final String? userDate;
  final String? description;

  EditExpenseModel(
      {
      // this.id,
      this.userName,
      this.userAmt,
      this.isGave,
      this.userDate,
      this.description});

  EditExpenseModel fromJson(Map<String, dynamic> json) => EditExpenseModel(
        // id: json['id'],
        userName: json['userName'],
        userAmt: json['userAmt'],
        userDate: json['userDate'],
        isGave: json['isGave'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        // 'id': id,
        'userName': userName,
        'userAmt': userAmt,
        'userDate': userDate,
        'isGave': isGave,
        'description': description,
      };
}
