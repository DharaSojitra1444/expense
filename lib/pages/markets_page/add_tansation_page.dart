// ignore_for_file: use_build_context_synchronously

import 'dart:math';
import 'package:expense_tracker_app/constant/color_constant.dart';
import 'package:expense_tracker_app/provider/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constant/app_asset.dart';
import '../../modal/all_modal.dart';
import '../../provider/transation_provider.dart';
import '../../sqflite_database/database.dart';
import '../../widget/app_appbar.dart';
import '../../widget/app_button.dart';
import '../../widget/app_image_assets.dart';
import '../../widget/app_text.dart';
import '../../widget/app_text_field.dart';
import '../welcome_page.dart';

class AddTranslation extends StatefulWidget {
  const AddTranslation({Key? key}) : super(key: key);

  @override
  State<AddTranslation> createState() => _AddTranslationState();
}

class _AddTranslationState extends State<AddTranslation> {
  bool isSwitched = true;

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategory();
  }

  getCategory() async {
    List<CategoryItem> list = await DatabaseProvider.getAllCategory();
    gridViewList = gridViewList + list;
  }

  TextEditingController categoryController = TextEditingController();
  TextEditingController addNewCategoryCtr = TextEditingController();
  TextEditingController amtController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController tagController = TextEditingController();
  String category = "Category";
  final formKey = GlobalKey<FormState>();
  final categoryFormKey = GlobalKey<FormState>();
  int? categoryIndex;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context,ThemeProvider themeProvider,_) {
        return Scaffold(
          appBar: AppAppBar(
            showProfile: false,
            showTitle: true,
            appbarTitle: "Add Expense / Income",
            //  actions: const [
              // AppIconButton(
              //   iconColor: ColorConstant.appThemeColor,
              //   iconImage: CupertinoIcons.app_badge_fill,
              // ),
          //  ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  // showList(),
                  AppText2Field(
                    onTap: () {
                      addCategory(themeProvider);
                    },
                    readOnly: true,
                    controller: categoryController,
                    hint: 'Select category',
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please select category";
                      }
                      return null;
                    },
                  ),
                  AppText2Field(
                    controller: amtController,
                    hint: 'Enter amount',
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter amount";
                      }
                      return null;
                    },
                  ),
                  AppText2Field(
                    controller: desController,
                    hint: 'Enter description',
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter description";
                      }
                      return null;
                     },
                  ),
                  Row(
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
                          borderRadius: BorderRadius.circular(10),
                        ),
                        //list_alt_rounded
                        child: const AppImageAsset(
                            image: AppAsset.pdfIcon,
                            color: ColorConstant.appThemeColor),
                       ),
                       AppText(
                        text: isSwitched ?" Expense" : " Income",
                        maxLines: 1,
                      ),
                      Transform.scale(
                        scale: .7,
                        child: CupertinoSwitch (
                          value: isSwitched,
                          onChanged: (value) {
                            setState(() {
                              isSwitched = value;
                            });
                          },
                          trackColor:ColorConstant.appGrey,
                          activeColor: ColorConstant.appThemeColor,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    height: 1,
                    decoration: const BoxDecoration(color: ColorConstant.appGreen),
                  ),
                  AppText2Field(
                    enableInteractiveSelection:false,
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
                        debugPrint("--->pickerDate $pickerDate");
                   //   var formate1 = "${pickerDate.day.toString().padLeft(2,'0')}-${pickerDate.month.toString().padLeft(2,'0')}-${pickerDate.year}";
                        dateController.text = pickerDate.toString().substring(0,10);
                      }
                    },
                    controller: dateController,
                    hint: 'Enter Date',
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter date";
                      }
                      return null;
                    },
                  ),
                  AppText2Field(
                    controller: tagController,
                    hint: 'tag',
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter tag";
                      }
                      return null;
                    },
                  ),
                  AppWithoutBgButton(
                      padding: const EdgeInsets.only(top: 10),
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          DateTime date = DateTime.parse(dateController.text);
                          String createMonth = DateTime(date.year, date.month, 1).toString();
                          Map<String, dynamic> userInf0 = {
                            'type': isSwitched ? 'Expense' : 'Income',
                            'amount': amtController.text,
                            'datetime': '${dateController.text} 00:00:00.000',
                            'category': categoryController.text,
                            'description': desController.text,
                            'tag': tagController.text,
                            'createMonth': createMonth,
                            'userId': storeUserId,
                          };

                          await DatabaseProvider.addTransaction(userInf0);
                          TransactionProvider trans =
                          Provider.of<TransactionProvider>(this.context,
                              listen: false);
                          await trans.getAllTransaction();
                          await trans.getChartDate();
                          Navigator.pop(context);
                        }
                      },
                      buttonText: "Save",
                      buttonColor: ColorConstant.appGreen,
                      borderColor: ColorConstant.appGreen,
                      textColor: ColorConstant.appWhite),
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  addCategory(ThemeProvider themeProvider) async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => StatefulBuilder(builder: (context, setState) {
          return Dialog(
            backgroundColor: themeProvider.isDarkMode ?  ColorConstant.appDialogBlack: ColorConstant.appBlack,
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
                            categoryController.text =
                            gridViewList[index].title!;
                            categoryIndex = index;
                            setState(() => category);
                          },
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.all(2),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: categoryIndex == index ?ColorConstant.appThemeColor : Colors.transparent)),
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
                              backgroundColor:
                              ColorConstant.appBlack,
                              child: SingleChildScrollView(
                                child: Form(
                                  key: categoryFormKey,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets
                                            .symmetric(
                                            vertical: 15,
                                            horizontal: 5),
                                        child: AppTextField(
                                          validator: (val) {
                                            if (val!.isEmpty) {
                                              return "Please add category";
                                            }
                                            return null;
                                          },
                                          controller:
                                          addNewCategoryCtr,
                                          hint: "Category",
                                          textColor: ColorConstant
                                              .appWhite,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child:
                                            AppWithoutBgButton(
                                                padding:
                                                const EdgeInsets
                                                    .all(
                                                    10),
                                                onTap:
                                                    () async {
                                                  Navigator.pop(
                                                      context);
                                                },
                                                buttonText:
                                                "Cancel",
                                                buttonColor:
                                                ColorConstant
                                                    .appGreen,
                                                borderColor:
                                                ColorConstant
                                                    .appGreen,
                                                textColor:
                                                ColorConstant
                                                    .appWhite),
                                          ),
                                          Expanded(
                                            child:
                                            AppWithoutBgButton(
                                                padding:
                                                const EdgeInsets
                                                    .all(
                                                    10),
                                                onTap:
                                                    () async {
                                                  if (categoryFormKey
                                                      .currentState!
                                                      .validate()) {
                                                    Navigator.pop(
                                                        context);
                                                    Map<String,
                                                        dynamic>
                                                    category =
                                                    {
                                                      'categoryName':
                                                      addNewCategoryCtr
                                                          .text,
                                                    };
                                                    await DatabaseProvider
                                                        .addCategory(
                                                        category);
                                                    await DatabaseProvider
                                                        .getAllCategory();

                                                    setState(() =>
                                                        gridViewList.add(CategoryItem(
                                                            title:
                                                            addNewCategoryCtr.text)));
                                                  }
                                                },
                                                buttonText:
                                                "Add",
                                                buttonColor:
                                                ColorConstant
                                                    .appGreen,
                                                borderColor:
                                                ColorConstant
                                                    .appGreen,
                                                textColor:
                                                ColorConstant
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
                        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.add,
                              color: ColorConstant.appOrange,
                            ),
                            SizedBox(width: 5,),
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
}
