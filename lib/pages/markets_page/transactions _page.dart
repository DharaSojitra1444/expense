// ignore_for_file: file_names

import 'dart:math';
import 'package:expense_tracker_app/constant/app_asset.dart';
import 'package:expense_tracker_app/modal/all_modal.dart';
import 'package:expense_tracker_app/pages/welcome_page.dart';
import 'package:expense_tracker_app/widget/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constant/color_constant.dart';
import '../../provider/theme_provider.dart';
import '../../provider/transation_provider.dart';
import '../../sqflite_database/database.dart';
import '../../widget/app_appbar.dart';
import '../../widget/app_doted_button.dart';
import '../../widget/app_image_assets.dart';
import '../../widget/app_text.dart';
import '../../widget/app_text_field.dart';
import 'bill_review_page.dart';

// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class TransactionsPage extends StatefulWidget {
  final TransactionModel? transItem;
  final String? category;

  const TransactionsPage({Key? key, this.transItem, this.category})
      : super(key: key);

  @override
  State<TransactionsPage> createState() => TransactionsPageState();
}

class TransactionsPageState extends State<TransactionsPage> {
  bool? isSwitched;
  int? categoryIndex;
  List<String> listItem = [];
  final categoryFormKey = GlobalKey<FormState>();
  List<CategoryItem> gridViewList = [
    CategoryItem(
      title: 'Bills',
      image: AppAsset.pdfIcon,
    ),
    CategoryItem(
      title: 'EMI',
      image: AppAsset.emlIcon,
    ),
    CategoryItem(
      title: 'Entertainment',
      image: AppAsset.entertainmentIcon,
    ),
    CategoryItem(
      title: 'Food',
      image: AppAsset.foodIcon,
    ),
    CategoryItem(
      title: 'Fule',
      image: AppAsset.fuleIcon,
    ),
    CategoryItem(
      title: 'Groceries',
      image: AppAsset.groceriesIcon,
    ),
    CategoryItem(
      title: 'Health',
      image: AppAsset.healthIcon,
    ),
    CategoryItem(
      title: 'Investment',
      image: AppAsset.investmentIcon,
    ),
    CategoryItem(
      title: 'Other',
      image: AppAsset.otherIcon,
    ),
    CategoryItem(
      title: 'Shopping',
      image: AppAsset.shopping_1Icon,
    ),
    CategoryItem(
      title: 'Transfer',
      image: AppAsset.transferIcon,
    ),
    CategoryItem(
      title: 'Travel',
      image: AppAsset.travelIcon,
    ),
  ];

  List<CategoryItem> grid1ViewList = [
    CategoryItem(
      title: 'Salary',
      image: AppAsset.pdfIcon,
    ),
    CategoryItem(
      title: 'Interest',
      image: AppAsset.emlIcon,
    ),
    CategoryItem(
      title: 'Business',
      image: AppAsset.entertainmentIcon,
    ),
    CategoryItem(
      title: 'Bank Deposit',
      image: AppAsset.foodIcon,
    ),
    CategoryItem(
      title: 'Credit',
      image: AppAsset.fuleIcon,
    ),
    CategoryItem(
      title: 'A/C Trans',
      image: AppAsset.groceriesIcon,
    ),
    CategoryItem(
      title: 'Refund ',
      image: AppAsset.healthIcon,
    ),
    CategoryItem(
      title: 'Reimburse',
      image: AppAsset.investmentIcon,
    ),
    CategoryItem(
      title: 'Bill Payment',
      image: AppAsset.otherIcon,
    ),
    CategoryItem(
      title: 'Recharge',
      image: AppAsset.shopping_1Icon,
    ),
    CategoryItem(
      title: 'Investment',
      image: AppAsset.transferIcon,
    ),
    CategoryItem(
      title: 'Rewards',
      image: AppAsset.travelIcon,
    ),
  ];
  TextEditingController timeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController amtController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController tagController = TextEditingController();
  TextEditingController addNewCategoryCtr = TextEditingController();
  String category = "Category";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategory();
    isSwitched = widget.transItem!.type == "Expense" ? true : false;
    listItem = [
      widget.transItem!.category!,
      widget.transItem!.description!,
      widget.transItem!.type!,
      // widget.transItem!.tag!,
      // "What Was This spend For ?",
      // "Add a Photo of A Receipt/warranty",
      (widget.transItem!.tag == null || widget.transItem!.tag == '')
          ? "Tag Your Spends"
          : widget.transItem!.tag!
    ];
    timeController.text =
        widget.transItem!.datetime.toString().substring(0, 10);
    nameController.text = widget.transItem!.description.toString();
    amtController.text = widget.transItem!.amount.toString();
    categoryController.text = widget.transItem!.category.toString();
    tagController.text = widget.transItem!.tag.toString();
  }

  getCategory() async {
    List<CategoryItem> list = await DatabaseProvider.getAllCategory();
    gridViewList = gridViewList + list;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeProvider themeProvider, _) {
      return Scaffold(
        appBar: AppAppBar(
          showProfile: false,
          showTitle: false,
          appbarTitle: storeUserName,
          actions: [
            AppIconButton(
              onTap: () async {
                //  addCategory2();
                await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    titlePadding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    title: Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: ColorConstant.appThemeColor,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(30))),
                      padding: const EdgeInsets.all(15),
                      child: const AppText(
                        text: "Delete",
                        textColor: ColorConstant.appWhite,
                      ),
                    ),
                    content: const AppText(
                      text: "Are you sure you want delete transaction?",
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      textColor: ColorConstant.appBlack,
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: AppWithoutBgButton(
                              buttonText: "No",
                              fontSize: 12,
                              borderRadius: 10,
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Expanded(
                            child: AppWithoutBgButton(
                              buttonText: "Yes",
                              fontSize: 12,
                              borderRadius: 10,
                              onTap: () async {
                                TransactionProvider trans =
                                    Provider.of<TransactionProvider>(
                                        this.context,
                                        listen: false);
                                trans.deleteTransaction(
                                    deleteId: widget.transItem!.id!);
                                await trans.getAllTransaction();
                                if (widget.category != null) {
                                  await trans.getChartDate();
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
                                  Navigator.pop(this.context);
                                  Navigator.pushReplacement(
                                      this.context,
                                      CupertinoPageRoute(
                                          builder: (_) => BillReviewPage(
                                              category: widget.category)));
                                } else {
                                  await trans.getChartDate();
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
                                  Navigator.pop(this.context);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
                //
              },
              iconColor: ColorConstant.appThemeColor,
              iconImage: CupertinoIcons.delete_simple,
            ),
            AppIconButton(
              onTap: () {
                editTrans(themeProvider);
              },
              iconColor: Colors.green,
              iconImage: Icons.edit,
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 15, bottom: 15),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: 500,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: themeProvider.isDarkMode
                        ? ColorConstant.appWhite
                        : ColorConstant.appBlack),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                        text: DateFormat.yMMMEd().format(
                            DateTime.parse(widget.transItem!.datetime!)),
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
                              text: widget.transItem!.description,
                              fontSize: 16,
                              maxLines: 2,
                              textColor: themeProvider.isDarkMode
                                  ? ColorConstant.appBlack
                                  : ColorConstant.appWhite),
                        ),
                        AppText(
                          text: '₹ ${widget.transItem!.amount}',
                          fontSize: 18,
                          textColor: ColorConstant.appOrange,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              showList(),
              Container(
                height: 1,
                decoration: const BoxDecoration(color: ColorConstant.appGreen),
              ),
              const SizedBox(
                height: 10,
              ),
              // widget.transItem!.type == "Expense"
              //     ? DottedBorder(
              //         borderType: BorderType.RRect,
              //         radius: const Radius.circular(10),
              //         dashPattern: [4, 4],
              //         color: ColorConstant.appGreen,
              //         strokeWidth: 1,
              //         child: Container(
              //           height: 40,
              //           width: 100,
              //           padding: const EdgeInsets.symmetric(
              //               horizontal: 5, vertical: 10),
              //           child: const Center(
              //             child: AppText(
              //               text: "Split",
              //               textColor: ColorConstant.appGreen,
              //             ),
              //           ),
              //         ))
              //     : Row(
              //         children: const [
              //           AppText(
              //             text: "More",
              //           ),
              //           Icon(Icons.keyboard_arrow_down)
              //         ],
              //       ),
              // const SizedBox(
              //   height: 10,
              // ),
            ],
          ),
        ),
      );
    });
  }

  showList() {
    return ListView.separated(
      itemCount: listItem.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            // if (index == 0) {
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) =>
            //               BillReviewPage(category: "Shopping")));
            // } else if (index == 1) {
            //   Navigator.push(context,
            //       MaterialPageRoute(builder: (context) => const UcoPage()));
            // } else if (index == 3) {
            //   Navigator.push(
            //       context, MaterialPageRoute(builder: (context) => Calendar()));
            // }
          },
          child: Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(12),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: ColorConstant.colorList[
                          Random().nextInt(ColorConstant.colorList.length)]
                      .withOpacity(0.5),
                  // ColorConstant.appThemeColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                //list_alt_rounded
                child: const AppImageAsset(
                    image: AppAsset.pdfIcon,
                    color: ColorConstant.appThemeColor),
              ),
              AppText(
                text: listItem[index],
                maxLines: 1,
              ),
              if (index == 2)
                Transform.scale(
                  scale: .7,
                  child: CupertinoSwitch (
                    value: isSwitched!,
                    onChanged: (value) {
                      // setState(() {
                      //   isSwitched = value;
                      // });
                    },
                    trackColor:ColorConstant.appThemeColor,
                    activeColor: widget.transItem!.type == "Expense"
                        ? ColorConstant.appOrange
                        : ColorConstant.appThemeColor,
                  ),
                ),
                // Switch(
                //   value: isSwitched!,
                //   onChanged: (value) {
                //     // setState(() {
                //     //   isSwitched = value;
                //     // });
                //   },
                //   activeTrackColor: widget.transItem!.type == "Expense"
                //       ? ColorConstant.appOrange.withOpacity(0.4)
                //       : ColorConstant.appThemeColor.withOpacity(0.4),
                //   activeColor: widget.transItem!.type == "Expense"
                //       ? ColorConstant.appOrange
                //       : ColorConstant.appThemeColor,
                // ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Container(
          height: 1,
          decoration: const BoxDecoration(color: ColorConstant.appGreen),
        );
      },
    );
  }

  addCategory(ThemeProvider themeProvider) async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => StatefulBuilder(builder: (context, setState) {
              return Dialog(
                backgroundColor: themeProvider.isDarkMode
                    ? ColorConstant.appDialogBlack
                    : ColorConstant.appBlack,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: AppText(
                          text: category,
                          textColor: ColorConstant.appWhite,
                          fontSize: 16,
                          maxLines: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 5),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                          ),
                          itemCount: gridViewList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                category = gridViewList[index].title!;
                                categoryIndex = index;
                                categoryController.text =
                                    gridViewList[index].title!;
                                setState(() => category);
                              },
                              child: Container(
                                margin: const EdgeInsets.all(8),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: categoryIndex == index
                                            ? ColorConstant.appThemeColor
                                            : Colors.transparent)),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        width: 25,
                                        height: 25,
                                        child: gridViewList[index].image == null
                                            ? Container(
                                                alignment: Alignment.center,
                                                child: AppText(
                                                  text: gridViewList[index]
                                                      .title![0]
                                                      .toUpperCase(),
                                                  textColor: ColorConstant
                                                      .appThemeColor,
                                                  fontSize: 18,
                                                ))
                                            : AppImageAsset(
                                                image:
                                                    gridViewList[index].image,
                                                fit: BoxFit.fill,
                                              ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: AppText(
                                          text: gridViewList[index].title,
                                          textColor: ColorConstant.appWhite
                                              .withOpacity(0.4),
                                          fontSize: 12,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: GestureDetector(
                          onTap: () async {
                            await showDialog(
                                // barrierDismissible: false,
                                context: context,
                                builder: (_) => Dialog(
                                      backgroundColor: ColorConstant.appBlack,
                                      child: SingleChildScrollView(
                                        child: Form(
                                          key: categoryFormKey,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 15,
                                                        horizontal: 5),
                                                child: AppTextField(
                                                  validator: (val) {
                                                    if (val!.isEmpty) {
                                                      return "Please add category";
                                                    }
                                                    return null;
                                                  },
                                                  controller: addNewCategoryCtr,
                                                  hint: "Category",
                                                  textColor:
                                                      ColorConstant.appWhite,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: AppWithoutBgButton(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        onTap: () async {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        buttonText: "Cancel",
                                                        buttonColor:
                                                            ColorConstant
                                                                .appGreen,
                                                        borderColor:
                                                            ColorConstant
                                                                .appGreen,
                                                        textColor: ColorConstant
                                                            .appWhite),
                                                  ),
                                                  Expanded(
                                                    child: AppWithoutBgButton(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        onTap: () async {
                                                          if (categoryFormKey
                                                              .currentState!
                                                              .validate()) {
                                                            Navigator.pop(
                                                                context);
                                                            Map<String, dynamic>
                                                                category = {
                                                              'categoryName':
                                                                  addNewCategoryCtr
                                                                      .text,
                                                            };
                                                            await DatabaseProvider
                                                                .addCategory(
                                                                    category);
                                                            await DatabaseProvider
                                                                .getAllCategory();

                                                            setState(() => gridViewList
                                                                .add(CategoryItem(
                                                                    title: addNewCategoryCtr
                                                                        .text)));
                                                          }
                                                        },
                                                        buttonText: "Add",
                                                        buttonColor:
                                                            ColorConstant
                                                                .appGreen,
                                                        borderColor:
                                                            ColorConstant
                                                                .appGreen,
                                                        textColor: ColorConstant
                                                            .appWhite),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.add,
                                  color: ColorConstant.appOrange,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                AppText(
                                  text: 'New Category',
                                  textColor: ColorConstant.appOrange,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      AppWithoutBgButton(
                          padding: const EdgeInsets.only(bottom: 20),
                          onTap: () async {
                            Navigator.pop(context);
                          },
                          buttonText: "Ok",
                          buttonColor: ColorConstant.appGreen,
                          borderColor: ColorConstant.appGreen,
                          textColor: ColorConstant.appWhite),
                    ],
                  ),
                ),
              );
            }));
  }

  addCategory2() async {
    await showDialog(
        // barrierDismissible: false,
        context: context,
        builder: (_) => StatefulBuilder(builder: (context, setState) {
              return Dialog(
                backgroundColor: ColorConstant.appBlack,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 5),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                          ),
                          itemCount: grid1ViewList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.all(8),
                              alignment: Alignment.center,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      width: 25,
                                      height: 25,
                                      child: AppImageAsset(
                                        image: grid1ViewList[index].image,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: AppText(
                                        text: grid1ViewList[index].title,
                                        textColor: ColorConstant.appWhite
                                            .withOpacity(0.4),
                                        fontSize: 12,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.add,
                              color: ColorConstant.appOrange,
                            ),
                            AppText(
                              text: 'New Category',
                              textColor: ColorConstant.appOrange,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }));
  }

  editTrans(ThemeProvider themeProvider) async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => StatefulBuilder(builder: (context, setState) {
              return Dialog(
                backgroundColor: themeProvider.isDarkMode
                    ? ColorConstant.appDialogBlack
                    : ColorConstant.appBlack,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      AppTextField(
                        enableInteractiveSelection: false,
                        textColor: ColorConstant.appWhite,
                        controller: timeController,
                        label: "Time",
                        suffix: const Icon(
                          Icons.calendar_today_sharp,
                          color: ColorConstant.appOrange,
                        ),
                        hint: '',
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
                                      primary: ColorConstant
                                          .appWhite, // circle color
                                    ),
                                    dialogBackgroundColor:
                                        ColorConstant.appLightBlack,
                                  ),
                                  child: child!,
                                );
                              });

                          if (pickerDate != null) {
                            // timeController.text = (DateFormat.yMMMEd().format(pickerDate));
                            // var formate1 = "${pickerDate.day.toString().padLeft(2,'0')}-${pickerDate.month.toString().padLeft(2,'0')}-${pickerDate.year}";
                            // timeController.text = formate1;
                            timeController.text =
                                pickerDate.toString().substring(0, 10);
                          }
                        },
                      ),
                      AppTextField(
                        textColor: ColorConstant.appWhite,
                        controller: nameController,
                        label: "Name",
                        hint: '',
                      ),
                      AppTextField(
                        keyboardType: TextInputType.number,
                        textColor: ColorConstant.appWhite,
                        // enabledColor: ColorConstant.appBlack,
                        // focusedColor: ColorConstant.appBlack,
                        controller: amtController,
                        label: "Amount",
                        hint: '',
                      ),
                      AppTextField(
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          addCategory(themeProvider);
                        },
                        textColor: ColorConstant.appWhite,
                        // enabledColor: ColorConstant.appBlack,
                        // focusedColor: ColorConstant.appBlack,
                        controller: categoryController,
                        readOnly: true,
                        label: "Category",
                        hint: '',
                      ),
                      AppTextField(
                        textColor: ColorConstant.appWhite,
                        // enabledColor: ColorConstant.appBlack,
                        // focusedColor: ColorConstant.appBlack,
                        controller: tagController,
                        label: "tag",
                        hint: '',
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                              child: AppWithoutBgButton(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            buttonText: "Cancel",
                            borderColor: ColorConstant.appOrange,
                            textColor: ColorConstant.appOrange,
                          )),
                          Expanded(
                              child: AppWithoutBgButton(
                            onTap: () async {
                              DateTime date =
                                  DateTime.parse(timeController.text);
                              String createMonth =
                                  DateTime(date.year, date.month, 1).toString();
                              TransactionModel transactionModel =
                                  TransactionModel(
                                      id: widget.transItem!.id,
                                      type: widget.transItem!.type,
                                      amount: amtController.text,
                                      datetime:
                                          '${timeController.text} 00:00:00.000',
                                      category: categoryController.text,
                                      description: nameController.text,
                                      tag: tagController.text,
                                      createMonth: createMonth,
                                      userId: widget.transItem!.userId);
                              // await DatabaseProvider.updateTransactionRecords(transactionModel.toMap(),ids: widget.transItem!.id);
                              await DatabaseProvider.updateTransaction(
                                  transactionModel);
                              TransactionProvider trans =
                                  Provider.of<TransactionProvider>(this.context,
                                      listen: false);
                              await trans.getAllTransaction();
                              await trans.getChartDate();
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                              if (widget.category != null) {
                                Navigator.pop(this.context);
                                Navigator.pushReplacement(
                                    this.context,
                                    CupertinoPageRoute(
                                        builder: (_) => BillReviewPage(
                                            category: widget.category)));
                              } else {
                                Navigator.pushReplacement(
                                    this.context,
                                    CupertinoPageRoute(
                                        builder: (_) => TransactionsPage(
                                            transItem: transactionModel)));
                              }
                            },
                            buttonText: "Done",
                            borderColor: ColorConstant.appGreen,
                            textColor: ColorConstant.appGreen,
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
