import 'package:flutter/material.dart';

import '../../constant/app_asset.dart';
import '../../constant/color_constant.dart';
import '../../modal/all_modal.dart';
import '../../widget/app_appbar.dart';
import '../../widget/app_button.dart';
import '../../widget/app_doted_button.dart';
import '../../widget/app_image_assets.dart';
import '../../widget/app_text.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

 List<ProductItem> cartList = [
   ProductItem(
       title: "Sleepy Head",
       discount: "50%",
       image: AppAsset.gridImg1Img,
       productName: "Direct Cool 4 Door",
       amount: "₹30,000",
       color: ColorConstant.appThemeColor,
     qty: 2
   ),
   ProductItem(
       title: "Sleepy Head",
       discount: "40%",
       image: AppAsset.gridImg1Img,
       productName: "Direct Cool 4 Door",
       amount: "₹25,000",
       color: ColorConstant.appGreen,
     qty: 1
   ),
   ProductItem(
       title: "Sleepy Head",
       discount: "50%",
       image: AppAsset.gridImg1Img,
       productName: "Direct Cool 4 Door",
       amount: "₹40,000",
       color: ColorConstant.appGrey,
       qty: 5),
 ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        showProfile: false,
        showTitle: true,
        appbarTitle: "Cart",
        actions: [
          AppIconButton(
            onTap: () {
            },
            iconColor: ColorConstant.appOrange,
          ),
        ],
      ),body: cardView(),
    );
  }

  cardView(){
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          ListView.builder(
            itemCount: cartList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return SizedBox(
                height: 100,
                child: Row(
                  children: [
                    Expanded(
                      child : Container(
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(color:cartList[index].color?. withOpacity(0.2),borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: AppImageAsset(
                                    image: cartList[index].image,
                                   ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  AppText(
                                    text: cartList[index].productName,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    maxLines: 1,
                                  ),       const AppText(
                                    text: '100kg',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    maxLines: 1,
                                  ),       AppText(
                                    text: cartList[index].amount,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: (){},
                                  child:  Container(
                                      decoration: BoxDecoration(color: ColorConstant.appBlack,borderRadius: BorderRadius.circular(5)),
                                      child: const Icon(Icons.remove, color: ColorConstant.appWhite,))),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: AppText(
                                      text: cartList[index].qty.toString(),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                                GestureDetector(
                                    onTap: (){},
                                    child:  Container(
                                      margin: const EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(color: ColorConstant.appBlack,borderRadius: BorderRadius.circular(5)),
                                        child: const Icon(Icons.add, color: ColorConstant.appWhite,))),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(Icons.close),
                    )
                  ],
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20,bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround  ,
              children: [
                const AppText(text: "25HOY023",fontSize: 16,),
                AppWithoutBgButton(
                  padding: EdgeInsets.zero,
                    onTap: (){
                      Navigator.pop(context);
                    },
                    buttonText: "Apply",
                    buttonColor:ColorConstant.appOrange ,
                    borderColor:ColorConstant.appOrange,textColor:ColorConstant.appBlack),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                 AppText(text: "Subtotal",textColor: ColorConstant.appGrey,),
                AppText(text: "₹240",textColor: ColorConstant.appOrange,fontWeight: FontWeight.w600,fontSize: 16,),

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                AppText(text: "Delivery",textColor: ColorConstant.appGrey,),
                AppText(text: "Free",textColor: ColorConstant.appGreen,fontWeight: FontWeight.w600,fontSize: 16,),

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                AppText(text: "Subtotal",textColor: ColorConstant.appGrey,fontWeight: FontWeight.w600,),
                 AppText(text: "₹30,000",textColor: ColorConstant.appThemeColor,fontWeight: FontWeight.w600,fontSize: 16,),

              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 100),
            width: double.infinity,
            child: AppWithoutBgButton(
                onTap: (){
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                buttonText: "Checkout",
                buttonColor:ColorConstant.appGreen,
                borderColor:ColorConstant.appGreen,textColor:ColorConstant.appWhite),
          ),
        ],
      ),
    );
  }
}
