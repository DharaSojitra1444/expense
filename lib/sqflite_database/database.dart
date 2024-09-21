import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../../modal/all_modal.dart';
import '../pages/welcome_page.dart';

class DatabaseProvider {
  static Database? _db;
  static const int _version = 1;
  static const String _path = 'transactions.db';

  static const String _userInfoTable = 'userInfo';
  static const String _transactionsTable = 'transactions';
  static const String _category = 'category';
  static const String _reminder = 'reminder';
  static const String _userExpense = 'userExpense';

  //user table column
  static const columnID = 'id';
  static const columnName = 'name';
  static const columnEmail = 'email';

  //transactions table column
  static const transactionsID = 'id';
  static const type = 'type';
  static const amount = 'amount';
  static const dateTime = 'datetime';

  static const category = 'category';
  static const description = 'description';
  static const tag = 'tag';
  static const userId = 'userId';
  static const createMonth = 'createMonth';

  //category table column
  static const categoryID = 'id';
  static const categoryName = 'categoryName';

  //Reminder table column
  static const reminderID = 'rid';
  static const reminderName = 'reminderName';
  static const reminderAmt = 'reminderAmt';
  static const reminderDate = 'reminderDate';

  //userExpense table column
  static const userExpenseId = 'eid';
  static const userName = 'userName';
  static const userAmt = 'userAmt';
  static const userDate = 'userDate';
  static const phoneNo = 'phoneNo';
  static const dataList = 'dataList';


  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String path = await getDatabasesPath() + _path;
      _db = await openDatabase(path,
          version: _version, onCreate: onCreate);
    } catch (e) {
      debugPrint("---->  Error initializing database");
    }
  }

  static Future<FutureOr<void>> onCreate(Database db, int version) async {
    debugPrint("----------->OnCreate Call");
    await db.execute('''
      CREATE TABLE $_userInfoTable (
        $columnID INTEGER PRIMARY KEY,
        $columnName TEXT NOT NULL,
        $columnEmail TEXT NOT NULL
      )
      ''');

    await db.execute('''
      CREATE TABLE $_transactionsTable (
        $transactionsID INTEGER PRIMARY KEY,
        $type TEXT NOT NULL,
        $amount TEXT NOT NULL,
        $dateTime TEXT NOT NULL,
        $category TEXT NOT NULL,
        $description TEXT NOT NULL,
        $tag TEXT NOT NULL,
        $createMonth TEXT NOT NULL,
        $userId TEXT NOT NULL
      )
      ''');

    await db.execute('''
      CREATE TABLE $_category (
        $categoryID INTEGER PRIMARY KEY,
        $categoryName TEXT NOT NULL
      )
      ''');

    await db.execute('''
      CREATE TABLE $_reminder (
        $reminderID INTEGER PRIMARY KEY,
        $reminderName TEXT NOT NULL,
        $reminderAmt TEXT NOT NULL,
        $userId TEXT NOT NULL,
        $reminderDate TEXT NOT NULL
      )
      ''');


    await db.execute('''
      CREATE TABLE $_userExpense (
        $userExpenseId INTEGER PRIMARY KEY,
        $userName TEXT NOT NULL,
        $userAmt TEXT NOT NULL,
        $userId TEXT NOT NULL,
        $phoneNo TEXT NOT NULL,
        $userDate TEXT NOT NULL,
        $dataList TEXT
      )
      ''');
  }

  static Future<int> addUserInformation(Map<String, dynamic> row) async {
    return await _db!.insert(_userInfoTable, row);
  }

  static Future<List<UserInformation>> queryAll() async {
    final maps = await _db!.query(_userInfoTable);
    return List.generate(maps.length, (index) {
      return UserInformation(
        id: maps[index]['id'].toString(),
        email: maps[index]['email'].toString(),
        name: maps[index]['name'].toString(),
      );
    });
  }

  static Future<UserInformation> getLoginRecord(String? email) async {
    String whereString = 'email = ?';
    List<dynamic> whereArguments = [email];
    final maps = await _db!.query(_userInfoTable,where: whereString, whereArgs: whereArguments);
      return UserInformation(
        id:  maps[0]['id'].toString(),
        email: maps[0]['email'].toString(),
        name: maps[0]['name'].toString(),
      );
  }

  static Future<int> addTransaction(Map<String, dynamic> row) async {
    return await _db!.insert(_transactionsTable, row);
  }

  static Future<int> deleteTransaction(String id) async {
    return await _db!.delete(
        _transactionsTable, where: 'id=?', whereArgs: [id]);
  }

  static Future<List<TransactionModel>> getAllTransaction() async {
    String whereString = 'userId = ?';
    List<dynamic> whereArguments = [storeUserId];
    final maps = await _db!.query(_transactionsTable,
        where: whereString, whereArgs: whereArguments);
    // final maps = await _db!.query(_transactionsTable);
    return List.generate(maps.length, (index) {
      return TransactionModel(
        id: maps[index]['id'].toString(),
        type: maps[index]['type'].toString(),
        amount: maps[index]['amount'].toString(),
        datetime: maps[index]['datetime'].toString(),
        category: maps[index]['category'].toString(),
        description: maps[index]['description'].toString(),
        tag: maps[index]['tag'].toString(),
        userId: maps[index]['userId'].toString(),
        createMonth: maps[index]['createMonth'].toString(),
      );
    });
  }

  static Future<int> updateTransaction(TransactionModel tm) async {
    return await _db!.rawUpdate('''
      UPDATE $_transactionsTable 
      SET type = ?,
      amount = ?,
      datetime = ?,
      category = ?,
      description = ?,
      tag = ?,
      userId = ?
      WHERE id = ? 
''', [
      tm.type,
      tm.amount,
      tm.datetime,
      tm.category,
      tm.description,
      tm.tag,
      tm.userId,
      tm.id,
    ]);
  }

  static Future<int> updateTransactionRecords(Map<String, dynamic> row, {String? ids}) async {
    final maps = await _db!.update(_transactionsTable, row,
        where: 'id = ?', whereArgs: [ids]);
    return maps;
  }

  static Future<int> addCategory(Map<String, dynamic> row) async {
    return await _db!.insert(_category, row);
  }

  static Future<List<CategoryItem>> getAllCategory() async {
    final maps = await _db!.query(_category);
    return List.generate(maps.length, (index) {
      return CategoryItem(
        title: maps[index]['categoryName'].toString(),
      );
    });
  }

  static Future<int> addReminder(Map<String, dynamic> row) async {
    return await _db!.insert(_reminder, row);
  }
  static Future<int> deleteReminder(String id) async {
    return await _db!.delete(
        _reminder, where: 'rid=?', whereArgs: [id]);
  }

  static Future<int> deleteUserTrans(String id) async {
    return await _db!.delete(
        _userExpense, where: 'eid=?', whereArgs: [id]);
  }

  static Future<List<ReminderModel>> getReminder() async {
    String whereString = 'userId = ?';
    List<dynamic> whereArguments = [storeUserId];
    final maps = await _db!.query(_reminder,
        where: whereString, whereArgs: whereArguments);
    //final maps = await _db!.query(_reminder);
    return List.generate(maps.length, (index) {
      return ReminderModel(
        rid: maps[index]['rid'].toString(),
        reminderName: maps[index]['reminderName'].toString(),
        reminderAmt: maps[index]['reminderAmt'].toString(),
        reminderDate: maps[index]['reminderDate'].toString(),
        userId: maps[index]['userId'].toString(),
      );
    });
  }


  static Future<int> addUserExpense(Map<String, dynamic> row) async {
    return await _db!.insert(_userExpense, row);
  }

  static Future<List<ExpenseModel>> getUserExpense() async {
    String whereString = 'userId = ?';
    List<dynamic> whereArguments = [storeUserId];
    final maps = await _db!.query(_userExpense,
        where: whereString, whereArgs: whereArguments);
    //final maps = await _db!.query(_reminder);
    return List.generate(maps.length, (index) {
      return ExpenseModel(
        eid: maps[index]['eid'].toString(),
        userName: maps[index]['userName'].toString(),
        userAmt: maps[index]['userAmt'].toString(),
        userDate: maps[index]['userDate'].toString(),
        phoneNo: maps[index]['phoneNo'].toString(),
        dataList: maps[index]['dataList'].toString(),
        userId: maps[index]['userId'].toString(),
      );
    });
  }

  static Future<int> updateExpenseTransaction(ExpenseModel em) async {
    return await _db!.rawUpdate('''
      UPDATE $_userExpense 
      SET userName = ?,
      userDate = ?,
      userAmt = ?,
      dataList = ?,
      userId = ?
      WHERE eid = ? 
''', [
      em.userName,
      em.userDate,
      em.userAmt,
      em.dataList,
      em.userId,
      em.eid,
    ]);
  }
}




