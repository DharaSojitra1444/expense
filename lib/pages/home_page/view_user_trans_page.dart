// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously, must_be_immutable

import 'dart:convert';
import 'package:expense_tracker_app/constant/app_asset.dart';
import 'package:expense_tracker_app/provider/theme_provider.dart';
import 'package:expense_tracker_app/sqflite_database/database.dart';
import 'package:expense_tracker_app/widget/app_image_assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constant/color_constant.dart';
import '../../modal/all_modal.dart';
import '../../provider/user_transaction_provider.dart';
import '../../widget/app_button.dart';
import '../../widget/app_text.dart';
import 'package:intl/intl.dart';
import '../../widget/app_text_field.dart';
import '../welcome_page.dart';

class ViewUserTransPage extends StatefulWidget {
  ExpenseModel? userTransList;

  ViewUserTransPage({Key? key, this.userTransList}) : super(key: key);

  @override
  State<ViewUserTransPage> createState() => ViewUserTransPageState();
}

class ViewUserTransPageState extends State<ViewUserTransPage> {
  int total = 0;
  TextEditingController timeController = TextEditingController();
  TextEditingController decController = TextEditingController();
  TextEditingController amtController = TextEditingController();
  List<EditExpenseModel> expenseModelList = [];
  final editFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    List<dynamic> dataFromJsonToMap1 =
        json.decode(widget.userTransList!.dataList!);
    expenseModelList = List.generate(dataFromJsonToMap1.length, (i) {
      return EditExpenseModel().fromJson(dataFromJsonToMap1[i]);
    });
    countTotal();
  }

  countTotal() {
    total = 0;
    for (var element in expenseModelList) {
      if (element.isGave == true) {
        total = total + int.parse(element.userAmt!);
      } else {
        total = total - int.parse(element.userAmt!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeProvider themeProvider, _) {
      return Scaffold(
        backgroundColor: themeProvider.isDarkMode
            ? ColorConstant.appBlack
            : ColorConstant.appGrey.withOpacity(0.3),
        appBar: AppBar(
          elevation: 0.0,
          titleSpacing: 0,
          iconTheme: IconThemeData(
            color: themeProvider.isDarkMode
                ? ColorConstant.appWhite
                : ColorConstant.appBlack,
          ),
          backgroundColor: themeProvider.isDarkMode
              ? ColorConstant.appBlack
              : ColorConstant.appWhite,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppText(
                text: "Hello",
                fontSize: 12,
              ),
              AppText(
                text: widget.userTransList!.userName,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 15),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: 500,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: themeProvider.isDarkMode
                          ? ColorConstant.appWhite
                          : ColorConstant.appBlack,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                            text: DateFormat.yMMMEd().format(DateTime.parse(
                                widget.userTransList!.userDate!)),
                            //"Tue, 13th Sep, 6:52 Am",
                            fontSize: 12,
                            textColor: themeProvider.isDarkMode
                                ? ColorConstant.appBlack
                                : ColorConstant.appWhite),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: AppText(
                                  text: widget.userTransList!.userName,
                                  fontSize: 16,
                                  maxLines: 2,
                                  textColor: themeProvider.isDarkMode
                                      ? ColorConstant.appBlack
                                      : ColorConstant.appWhite),
                            ),
                            AppText(
                              text: '₹ $total',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              textColor: ColorConstant.appOrange,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    decoration:
                        const BoxDecoration(color: ColorConstant.appGreen),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 10, right: 10, bottom: 10, left: 10),
                    child: Column(
                      children: [
                        expenseModelList.isEmpty
                            ? Column(
                                children: [
                                  AppText(
                                    text:
                                        "Start adding transactions with\n ${widget.userTransList!.userName}",
                                    textAlign: TextAlign.center,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const AppImageAsset(
                                    image: AppAsset.animationIcon,
                                    height: 45,
                                    width: 45,
                                  )
                                ],
                              )
                            : Row(
                                children: const [
                                  Expanded(
                                    flex: 2,
                                    child: AppText(
                                      text: "Entries",
                                      textColor: ColorConstant.appThemeColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: AppText(
                                      text: "₹ You Gave",
                                      textColor: ColorConstant.appThemeColor,
                                      textAlign: TextAlign.center,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: AppText(
                                      text: "₹ You Got",
                                      textColor: ColorConstant.appThemeColor,
                                      textAlign: TextAlign.center,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                        const SizedBox(
                          height: 5,
                        ),
                        // Container(
                        //   margin: const EdgeInsets.only(top: 8, bottom: 10),
                        //   height: 1,
                        //   width: double.infinity,
                        //   color: ColorConstant.appThemeColor,
                        // ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: expenseModelList.length,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(bottom: 60),
                          itemBuilder: (
                            BuildContext context,
                            int index,
                          ) {
                            expenseModelList.sort(
                                (a, b) => b.userDate!.compareTo(a.userDate!));
                            EditExpenseModel item = expenseModelList[index];
                            return InkWell(
                              onTap: () {
                                addEditTrans(
                                    themeProvider: themeProvider,
                                    editExpenseModel: item,
                                    isEdit: true,
                                    index: index);
                              },
                              child: Container(
                                height: 60,
                                padding: const EdgeInsets.only(left: 10),
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                    color: ColorConstant.appWhite,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 6,
                                      child: AppText(
                                        textColor: ColorConstant.appBlack,
                                        text: DateFormat.yMMMEd().format(
                                            DateTime.parse(item.userDate!)),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        padding:
                                            const EdgeInsets.only(right: 4),
                                        alignment: Alignment.centerRight,
                                        width: 80,
                                        color: ColorConstant.appThemeColor
                                            .withOpacity(
                                                themeProvider.isDarkMode
                                                    ? 0.8
                                                    : 0.4),
                                        child: AppText(
                                          text: item.isGave == true
                                              ? '₹ ${item.userAmt}'
                                              : '',
                                          textAlign: TextAlign.end,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        padding:
                                            const EdgeInsets.only(right: 4),
                                        alignment: Alignment.centerRight,
                                        width: 80,
                                        decoration: BoxDecoration(
                                            color: ColorConstant.appGreen
                                                .withOpacity(themeProvider
                                                        .isDarkMode
                                                    ? 0.8
                                                    : 0.4),
                                            borderRadius:
                                                const BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10))),
                                        child: AppText(
                                          text: item.isGave == false
                                              ? '₹ ${item.userAmt}'
                                              : '',
                                          textAlign: TextAlign.end,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.all(5),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AppWithoutBgButton(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        onTap: () async {
                          addEditTrans(
                            isGave: true,
                            themeProvider: themeProvider,
                          );
                          // List<EditExpenseModel> myList = [
                          //   EditExpenseModel(
                          //       isGave: true,
                          //       userAmt: "121",
                          //       userDate: DateTime.now().toString(),
                          //       userName: widget.userTransList!.userName),
                          //   EditExpenseModel(
                          //       isGave: false,
                          //       userAmt: "1121",
                          //       userDate: DateTime.now().toString(),
                          //       userName: widget.userTransList!.userName)
                          // ];
                          // var dataFromJsonToMap = json.encode(myList);
                          // ExpenseModel userExpense = ExpenseModel(
                          //     userName: '${widget.userTransList!.userName}',
                          //     phoneNo:  widget.userTransList!.phoneNo,
                          //     userDate: DateTime.now().toString(),
                          //     dataList: dataFromJsonToMap,
                          //     userAmt: "5000",
                          //     userId: storeUserId,
                          //     eid: widget.userTransList!.eid);
                          // await DatabaseProvider.updateExpenseTransaction(
                          //     userExpense);
                        },
                        buttonText: "YOU GAVE ₹",
                        buttonColor: ColorConstant.appThemeColor,
                        borderColor: ColorConstant.appThemeColor,
                        textColor: ColorConstant.appWhite),
                    AppWithoutBgButton(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        onTap: () async {
                          addEditTrans(
                            isGave: false,
                            themeProvider: themeProvider,
                          );
                        },
                        buttonText: "YOU GOT ₹",
                        buttonColor: ColorConstant.appGreen,
                        borderColor: ColorConstant.appGreen,
                        textColor: ColorConstant.appWhite),
                    // trying to move to the bottom
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  clearAll() {
    timeController.clear();
    decController.clear();
    amtController.clear();
  }

  addEditTrans({
    bool? isGave,
    EditExpenseModel? editExpenseModel,
    bool? isEdit = false,
    int? index,
    ThemeProvider? themeProvider,
  }) async {
    bool? type;
    if (isEdit == true) {
      type = editExpenseModel!.isGave;
      timeController.text = editExpenseModel.userDate!;
      amtController.text = editExpenseModel.userAmt!;
      decController.text = editExpenseModel.description ?? '';
    } else {
      type = isGave;
    }
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => StatefulBuilder(builder: (context, setState) {
              return Dialog(
                backgroundColor: themeProvider!.isDarkMode
                    ? ColorConstant.appDialogBlack
                    : ColorConstant.appBlack,
                child: SingleChildScrollView(
                  child: Form(
                    key: editFormKey,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: AppText(
                            text: "Entry Detail",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.center,
                            textColor: ColorConstant.appWhite,
                          ),
                        ),
                        AppTextField(
                          enableInteractiveSelection:false,
                          controller: timeController,
                          label: "DateTime",
                          suffix: const Icon(
                            Icons.calendar_today_sharp,
                            color: ColorConstant.appOrange,
                          ),
                          hint: '',
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please select date";
                            }
                            return null;
                          },
                          onTap: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            DateTime? pickerDate = await showDatePicker(
                                context: context,
                                firstDate: DateTime(1880),
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
                              timeController.text =
                                  pickerDate.toString().substring(0, 10);
                            }
                          },
                        ),
                        // AppTextField(
                        //   textColor: ColorConstant.appWhite,
                        //   controller: nameController,
                        //   label: "Name",
                        //   hint: '',
                        // ),
                        AppTextField(
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please enter description";
                            }
                            return null;
                          },
                          controller: decController,
                          label: "Description",
                          hint: '',
                        ),
                        AppTextField(
                          keyboardType: TextInputType.number,
                          controller: amtController,
                          label: "Amount",
                          hint: '',
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please enter amount";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                                child: AppWithoutBgButton(
                              onTap: () {
                                Navigator.pop(context);
                                clearAll();
                              },
                              buttonText: "Cancel",
                              borderColor: ColorConstant.appOrange,
                              textColor: ColorConstant.appOrange,
                              // buttonColor: ColorConstant.appOrange,
                              // textColor: ColorConstant.appWhite,
                            )),
                            Expanded(
                                child: AppWithoutBgButton(
                              onTap: () async {
                                if (editFormKey.currentState!.validate()) {
                                  if (isEdit!) {
                                    expenseModelList[index!] = EditExpenseModel(
                                        isGave: type!,
                                        description: decController.text,
                                        userAmt: amtController.text,
                                        userDate: timeController.text,
                                        userName:
                                            widget.userTransList!.userName);
                                  } else {
                                    expenseModelList.add(EditExpenseModel(
                                        isGave: isGave!,
                                        description: decController.text,
                                        userAmt: amtController.text,
                                        userDate: timeController.text,
                                        userName:
                                            widget.userTransList!.userName));
                                  }
                                  var dataFromJsonToMap =
                                      json.encode(expenseModelList);
                                  ExpenseModel userExpense = ExpenseModel(
                                      userName:
                                          '${widget.userTransList!.userName}',
                                      phoneNo: widget.userTransList!.phoneNo,
                                      userDate: widget.userTransList!.userDate,
                                      dataList: dataFromJsonToMap,
                                      userAmt: "0",
                                      userId: storeUserId,
                                      eid: widget.userTransList!.eid);
                                  await DatabaseProvider
                                      .updateExpenseTransaction(userExpense);
                                  // await DatabaseProvider.getUserExpense();
                                  UserTransactionProvider userTrans =
                                      Provider.of<UserTransactionProvider>(
                                          context,
                                          listen: false);
                                  userTrans.getUserTransaction();
                                  Navigator.pop(context);
                                  clearAll();
                                  countTotal();
                                }
                              },
                              buttonText: "Done",
                              borderColor:
                                  ColorConstant.appGreen.withOpacity(0.2),
                              buttonColor:
                                  ColorConstant.appGreen.withOpacity(0.2),
                              // buttonColor: ColorConstant.appGreen,
                              textColor: ColorConstant.appGreen,
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
