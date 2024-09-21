// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:expense_tracker_app/constant/color_constant.dart';
import 'package:expense_tracker_app/pages/welcome_page.dart';
import 'package:expense_tracker_app/provider/theme_provider.dart';
import 'package:expense_tracker_app/widget/app_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:provider/provider.dart';
import '../../modal/all_modal.dart';
import '../../provider/user_transaction_provider.dart';
import '../../sqflite_database/database.dart';
import '../../widget/app_doted_button.dart';
import '../../widget/app_text.dart';

List<Contact> contacts = [];

class AddContactPage extends StatefulWidget {
  const AddContactPage({Key? key}) : super(key: key);

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  int? selectIndex;
  Contact? selectContact;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (contacts.isEmpty) {
      getList();
    }
  }

  getList() async {
    if (await FlutterContacts.requestPermission()) {
      contacts = await FlutterContacts.getContacts(
          withProperties: true, withThumbnail: true);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2(builder: (context,
        UserTransactionProvider userTransactionProvider,
        ThemeProvider themeProvider,
        _) {
      return Scaffold(
        appBar: AppAppBar(
          showProfile: false,
          showTitle: true,
          appbarTitle: "Contacts",
          actions: [
            AppIconButton(
              iconColor: ColorConstant.appThemeColor,
              iconImage: Icons.save_rounded,
              onTap: () async {
                if (selectIndex == null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    backgroundColor: themeProvider.isDarkMode
                        ? ColorConstant.appWhite
                        : ColorConstant.appBlack,
                    behavior: SnackBarBehavior.floating,
                    elevation: 6.0,
                    content: AppText(
                        text: 'Please select any contact!',
                        textColor: themeProvider.isDarkMode
                            ? ColorConstant.appBlack
                            : ColorConstant.appWhite,
                        fontWeight: FontWeight.w500),
                  ));
                } else {
                  bool exists = userTransactionProvider.userTransList.any(
                      (ExpenseModel ex) =>
                          ex.phoneNo ==
                          selectContact!.phones.first.number.toString());
                  if (exists) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      backgroundColor: themeProvider.isDarkMode
                          ? ColorConstant.appWhite
                          : ColorConstant.appBlack,
                      behavior: SnackBarBehavior.floating,
                      elevation: 6.0,
                      content: AppText(
                          text: 'Contact already added!',
                          textColor: themeProvider.isDarkMode
                              ? ColorConstant.appBlack
                              : ColorConstant.appWhite,
                          fontWeight: FontWeight.w500),
                    ));
                  } else {
                    List<EditExpenseModel> myList = [];
                    final dataFromJsonToMap = json.encode(myList);
                    Map<String, dynamic> userExpense = {
                      'userName': selectContact!.name.first,
                      'phoneNo': selectContact!.phones.first.number.toString(),
                      'userAmt': 0,
                      'userDate': DateTime.now().toString(),
                      'dataList': dataFromJsonToMap,
                      'userId': storeUserId,
                    };
                    await DatabaseProvider.addUserExpense(userExpense);
                    userTransactionProvider.getUserTransaction();
                    ScaffoldMessenger.of(this.context).showSnackBar(SnackBar(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      backgroundColor: themeProvider.isDarkMode
                          ? ColorConstant.appWhite
                          : ColorConstant.appBlack,
                      behavior: SnackBarBehavior.floating,
                      elevation: 6.0,
                      content: AppText(
                          text: 'Contact added successfully',
                          textColor: themeProvider.isDarkMode
                              ? ColorConstant.appBlack
                              : ColorConstant.appWhite,
                          fontWeight: FontWeight.w500),
                    ));
                    Navigator.pop(context);
                  }
                }
              },
            ),
          ],
        ),
        body: contacts.isEmpty
            ? const Center(child: AppText(text: "List is empty"))
            : ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (BuildContext context, int index) {
                  if (contacts[index].phones.isNotEmpty) {
                    return ListTile(
                      onTap: () {
                        selectIndex = index;
                        selectContact = contacts[index];
                        setState(() {});
                      },
                      leading: (contacts[index].thumbnail == null)
                          ? const CircleAvatar(
                              backgroundColor: ColorConstant.appThemeColor,
                              child: Icon(Icons.person,
                                  color: ColorConstant.appWhite))
                          : CircleAvatar(
                              backgroundImage:
                                  MemoryImage(contacts[index].thumbnail!)),
                      // contacts[index].thumbnail != null ? Image.memory(contacts[index].thumbnail!): Container(height: 10,),
                      title: AppText(
                        text: contacts[index].name.first,
                      ),
                      subtitle: AppText(
                        text: contacts[index].phones.isEmpty
                            ? ''
                            : contacts[index].phones.first.number,
                        textColor: ColorConstant.appThemeColor,
                      ),
                      tileColor: selectIndex == index
                          ? ColorConstant.appThemeColor.withOpacity(0.2)
                          : Colors.transparent,
                      //AppText(text: contacts[index].phones.isEmpty ? '':contacts[index].phones.first.number),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
      );
    });
  }
}
