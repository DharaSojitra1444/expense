import 'package:expense_tracker_app/pages/shopping_page/shopping_details_page.dart';
import 'package:expense_tracker_app/pages/welcome_page.dart';
import 'package:expense_tracker_app/widget/app_image_assets.dart';
import 'package:expense_tracker_app/widget/app_text.dart';
import 'package:flutter/material.dart';
import '../../constant/app_asset.dart';
import '../../constant/color_constant.dart';
import '../../modal/all_modal.dart';
import '../../widget/app_appbar.dart';
import '../../widget/app_doted_button.dart';

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({Key? key}) : super(key: key);

  @override
  State<ShoppingPage> createState() => ShoppingPageState();
}

class ShoppingPageState extends State<ShoppingPage> {
  List<ProductItem> allList = [
    ProductItem(
        title: "Sleepy Head",
        discount: "50%",
        image: AppAsset.gridImg1Img,
        productName: "Direct Cool 4 Door",
        amount: "₹30,000",
        color: ColorConstant.appThemeColor),
    ProductItem(
        title: "Sleepy Head",
        discount: "40%",
        image: AppAsset.gridImg1Img,
        productName: "Direct Cool 4 Door",
        amount: "₹25,000",
        color: ColorConstant.appGreen),
    ProductItem(
        title: "Sleepy Head",
        discount: "50%",
        image: AppAsset.gridImg1Img,
        productName: "Direct Cool 4 Door",
        amount: "₹40,000",
        color: ColorConstant.appGrey),
    ProductItem(
        title: "Sleepy Head",
        discount: "30%",
        image: AppAsset.gridImg1Img,
        productName: "Direct Cool 4 Door",
        amount: "₹60,000",
        color: ColorConstant.appOrange),
    ProductItem(
        title: "Sleepy Head",
        discount: "20%",
        image: AppAsset.gridImg1Img,
        productName: "Direct Cool 4 Door",
        amount: "₹30,000",
        color: ColorConstant.appThemeColor),
    ProductItem(
        title: "Sleepy Head",
        discount: "50%",
        image: AppAsset.gridImg1Img,
        productName: "Direct Cool 4 Door",
        amount: "₹30,000",
        color: ColorConstant.appGreen),
    ProductItem(
        title: "Sleepy Head",
        discount: "50%",
        image: AppAsset.gridImg1Img,
        productName: "Direct Cool 4 Door",
        amount: "₹30,000",
        color: ColorConstant.appGrey),
    ProductItem(
        title: "Sleepy Head",
        discount: "50%",
        image: AppAsset.gridImg1Img,
        productName: "Direct Cool 4 Door",
        amount: "₹30,000",
        color: ColorConstant.appOrange),
  ];

  List<ProductItem> travelList = [
    ProductItem(
        title: "Sleepy Head",
        discount: "50%",
        image: AppAsset.gridImg2Img,
        productName: "Travel Bag",
        amount: "₹30,000",
        color: ColorConstant.appThemeColor),
    ProductItem(
        title: "Sleepy Head",
        discount: "40%",
        image: AppAsset.gridImg2Img,
        productName: "Travel Bag",
        amount: "₹25,000",
        color: ColorConstant.appGreen),
    ProductItem(
        title: "Sleepy Head",
        discount: "50%",
        image: AppAsset.gridImg2Img,
        productName: "Travel Bag",
        amount: "₹40,000",
        color: ColorConstant.appGrey),
    ProductItem(
        title: "Sleepy Head",
        discount: "30%",
        image: AppAsset.gridImg2Img,
        productName: "Travel Bag",
        amount: "₹60,000",
        color: ColorConstant.appOrange),
    ProductItem(
        title: "Sleepy Head",
        discount: "20%",
        image: AppAsset.gridImg2Img,
        productName: "Travel Bag",
        amount: "₹30,000",
        color: ColorConstant.appThemeColor),
    ProductItem(
        title: "Sleepy Head",
        discount: "50%",
        image: AppAsset.gridImg2Img,
        productName: "Travel Bag",
        amount: "₹30,000",
        color: ColorConstant.appGreen),
    ProductItem(
        title: "Sleepy Head",
        discount: "50%",
        image: AppAsset.gridImg2Img,
        productName: "Travel Bag",
        amount: "₹30,000",
        color: ColorConstant.appGrey),
    ProductItem(
        title: "Sleepy Head",
        discount: "50%",
        image: AppAsset.gridImg2Img,
        productName: "Travel Bag",
        amount: "₹30,000",
        color: ColorConstant.appOrange),
  ];

  List<ProductItem> selfCareList = [
    ProductItem(
        title: "Sleepy Head",
        discount: "50%",
        image: AppAsset.gridImg3Img,
        productName: "Cream for combination skin",
        amount: "₹30,000",
        color: ColorConstant.appThemeColor),
    ProductItem(
        title: "Sleepy Head",
        discount: "40%",
        image: AppAsset.gridImg3Img,
        productName: "Cream for combination skin",
        amount: "₹25,000",
        color: ColorConstant.appGreen),
    ProductItem(
        title: "Sleepy Head",
        discount: "50%",
        image: AppAsset.gridImg3Img,
        productName: "Cream for combination skin",
        amount: "₹40,000",
        color: ColorConstant.appGrey),
    ProductItem(
        title: "Sleepy Head",
        discount: "30%",
        image: AppAsset.gridImg3Img,
        productName: "Cream for combination skin",
        amount: "₹60,000",
        color: ColorConstant.appOrange),
    ProductItem(
        title: "Sleepy Head",
        discount: "20%",
        image: AppAsset.gridImg3Img,
        productName: "Cream for combination skin",
        amount: "₹30,000",
        color: ColorConstant.appThemeColor),
    ProductItem(
        title: "Sleepy Head",
        discount: "50%",
        image: AppAsset.gridImg3Img,
        productName: "Cream for combination skin",
        amount: "₹30,000",
        color: ColorConstant.appGreen),
    ProductItem(
        title: "Sleepy Head",
        discount: "50%",
        image: AppAsset.gridImg3Img,
        productName: "Cream for combination skin",
        amount: "₹30,000",
        color: ColorConstant.appGrey),
    ProductItem(
        title: "Sleepy Head",
        discount: "50%",
        image: AppAsset.gridImg3Img,
        productName: "Cream for combination skin",
        amount: "₹30,000",
        color: ColorConstant.appOrange),
  ];
  List<ProductItem> fashionList = [
    ProductItem(
        title: "Sleepy Head",
        discount: "50%",
        image: AppAsset.gridImg4Img,
        productName: "T Shirt",
        amount: "₹30,000",
        color: ColorConstant.appThemeColor),
    ProductItem(
        title: "Sleepy Head",
        discount: "40%",
        image: AppAsset.gridImg4Img,
        productName: "T Shirt",
        amount: "₹25,000",
        color: ColorConstant.appGreen),
    ProductItem(
        title: "Sleepy Head",
        discount: "50%",
        image: AppAsset.gridImg4Img,
        productName: "T Shirt",
        amount: "₹40,000",
        color: ColorConstant.appGrey),
    ProductItem(
        title: "Sleepy Head",
        discount: "30%",
        image: AppAsset.gridImg4Img,
        productName: "T Shirt",
        amount: "₹60,000",
        color: ColorConstant.appOrange),
    ProductItem(
        title: "Sleepy Head",
        discount: "20%",
        image: AppAsset.gridImg4Img,
        productName: "T Shirt",
        amount: "₹30,000",
        color: ColorConstant.appThemeColor),
    ProductItem(
        title: "Sleepy Head",
        discount: "50%",
        image: AppAsset.gridImg4Img,
        productName: "T Shirt",
        amount: "₹30,000",
        color: ColorConstant.appGreen),
    ProductItem(
        title: "Sleepy Head",
        discount: "50%",
        image: AppAsset.gridImg4Img,
        productName: "T Shirt",
        amount: "₹30,000",
        color: ColorConstant.appGrey),
    ProductItem(
        title: "Sleepy Head",
        discount: "50%",
        image: AppAsset.gridImg4Img,
        productName: "T Shirt",
        amount: "₹30,000",
        color: ColorConstant.appOrange),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        // backgroundColor: ColorConstant.appWhite,
        appBar: AppAppBar(
          appbarTitle: storeUserName,
          actions: const [
            AppIconButton(
              iconColor: ColorConstant.appThemeColor,
              iconImage: Icons.search,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 100,
                decoration: BoxDecoration(
                    color: ColorConstant.appThemeColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        AppText(
                          text: "Hot Sale",
                          textColor: ColorConstant.appWhite,
                          fontSize: 18,
                        ),
                        AppText(
                          text: "40% oFF",
                          textColor: ColorConstant.appWhite,
                          fontSize: 20,
                        ),
                        AppText(
                          text: "Rolex Smartwatch",
                          textColor: ColorConstant.appWhite,
                          fontSize: 16,
                        )
                      ],
                    ),
                    const AppImageAsset(image: AppAsset.saleItemImg)
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 50,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: TabBar(
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.tab,
                    physics: const NeverScrollableScrollPhysics(),
                    indicatorColor: ColorConstant.appGreen,
                    labelColor: Colors.black,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorConstant.appOrange),
                    tabs: const [
                      Tab(
                          icon: AppText(
                        text: "All",
                      )),
                      Tab(
                          icon: AppText(
                        text: "Travel",
                      )),
                      Tab(
                          icon: AppText(
                        text: "Home",
                      )),
                      Tab(
                          icon: AppText(
                        text: "Self Care",
                      )),
                      Tab(
                          icon: AppText(
                        text: "Fashion",
                      )),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    GridViewPage(gridViewList: allList),
                    GridViewPage(gridViewList: travelList),
                    GridViewPage(gridViewList: allList),
                    GridViewPage(gridViewList: selfCareList),
                    GridViewPage(gridViewList: fashionList),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class GridViewPage extends StatelessWidget {
  List<ProductItem>? gridViewList;
  GestureTapCallback? onTap;

  GridViewPage({Key? key, this.gridViewList, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 2;
    return SingleChildScrollView(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: (itemWidth / itemHeight),
        ),
        itemCount: gridViewList!.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ShoppingDetailsPage(item: gridViewList![index])));
            },
            child: Container(
              margin: const EdgeInsets.all(8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: gridViewList![index].color!.withOpacity(0.2),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          text: gridViewList![index].title,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          maxLines: 1,
                          letterSpacing: 1.2,
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorConstant.appThemeColor),
                          child: AppText(
                            text: gridViewList![index].discount,
                            textColor: ColorConstant.appWhite,
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    // width: 50,
                    // height: 100,
                    child: AppImageAsset(
                      image: gridViewList![index].image,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: AppText(
                            text: gridViewList![index].productName,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            maxLines: 2,
                            letterSpacing: 1.2,
                          ),
                        ),
                        AppText(
                          text: gridViewList![index].amount,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          maxLines: 1,
                          letterSpacing: 1.2,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
