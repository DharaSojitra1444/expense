
import 'package:expense_tracker_app/widget/app_appbar.dart';
import 'package:expense_tracker_app/widget/app_text.dart';
import 'package:flutter/material.dart';

import '../../constant/color_constant.dart';
import '../../modal/all_modal.dart';
import '../../widget/app_button.dart';
import '../../widget/app_doted_button.dart';
import 'cart_page.dart';

// ignore: must_be_immutable
class ShoppingDetailsPage extends StatefulWidget {
  ProductItem? item;

  ShoppingDetailsPage({Key? key, this.item}) : super(key: key);

  @override
  State<ShoppingDetailsPage> createState() => _ShoppingDetailsPageState();
}

class _ShoppingDetailsPageState extends State<ShoppingDetailsPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ColorConstant.appWhite,
      appBar: AppAppBar(
        showProfile: false,
        showTitle: false,
        actions: [
          AppIconButton(
            onTap: () {
            },
            iconColor: ColorConstant.appOrange,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: widget.item?.productName,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AppText(
                      text: "Grilled Beet Steak With Sauce Abc",
                      textColor: ColorConstant.appGrey,
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  height: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorConstant.appThemeColor.withOpacity(0.4)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      AppText(
                        text: "4.5",
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Icon(
                        Icons.star_outlined,
                        color: ColorConstant.appOrange,
                        size: 18,
                      )
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: AppText(
                text: widget.item!.amount,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Center(
              child: InteractiveViewer(
                panEnabled: false,
                // Set it to false
                boundaryMargin: const EdgeInsets.all(100),
                minScale: 0.5,
                maxScale: 8,
                child: Image.asset(
                  widget.item!.image!,
                  height: 350,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 12,bottom: 5),
              child: AppText(
                text: 'Description',
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
             AppText(
              text: 'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over ',
              textColor: ColorConstant.appGrey,
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              alignment: Alignment.center,
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorConstant.appGreen),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText(
                        text: 'Total Price',
                        fontSize: 16,
                        textColor: ColorConstant.appWhite.withOpacity(0.7),
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AppText(
                        text: widget.item!.amount,
                        textColor: ColorConstant.appWhite
                      ),
                    ],
                  ),
                  AppWithoutBgButton(
                    padding: EdgeInsets.zero,
                      onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>const CartPage()));
                      },
                      buttonText: "Order Now",
                      buttonColor:ColorConstant.appBlack ,
                      borderColor:ColorConstant.appBlack,textColor:ColorConstant.appWhite)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
