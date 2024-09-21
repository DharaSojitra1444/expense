import 'package:expense_tracker_app/widget/app_text.dart';
import 'package:flutter/material.dart';
import '../../constant/app_asset.dart';
import '../../constant/color_constant.dart';
import '../../widget/app_appbar.dart';
import '../../widget/app_button.dart';
import '../../widget/app_image_assets.dart';
import '../../widget/app_text_field.dart';

class EditAccountPage extends StatefulWidget {
  const EditAccountPage({Key? key}) : super(key: key);

  @override
  State<EditAccountPage> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {

  TextEditingController nameController = TextEditingController(text: "Wade Warren");
  TextEditingController emailController = TextEditingController(text: "WadeWarren@gamil.com");
  TextEditingController numberController = TextEditingController(text: "997998585");
  TextEditingController addressController = TextEditingController(text: "Wade Warren address");
  TextEditingController accountNoController = TextEditingController(text: "12345679890");
  TextEditingController passwordController = TextEditingController(text: "1234666");
  TextEditingController cityController = TextEditingController(text: "Surat");
  TextEditingController countryController = TextEditingController(text: "India");

  bool isEdit = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      // backgroundColor: ColorConstant.appWhite,
      appBar: AppAppBar(
        showProfile: false,
        showTitle: true,
        appbarTitle: "Account",
        actions:  [
          GestureDetector(
            onTap: (){
              isEdit = !isEdit;
              setState(() {
              });
            },
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.only(right: 15,left: 15),
                  child: AppText(text: "Edit",textColor: ColorConstant.appOrange,fontWeight: FontWeight.w600,fontSize: 16,),
                ),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
          Stack(
            children: [
              const AppImageAsset(image: AppAsset.profile),
              Positioned(
                bottom: 10,
                right: 10,
                child: InkWell(
                  onTap: () {

                  },
                  child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorConstant.appBlack),
                      child: const Icon(
                        Icons.edit,
                        color: ColorConstant.appWhite,
                        size: 18,
                      )),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
            itemList(label: "Name",controller: nameController),
            itemList(label: "Email",controller: emailController),
            itemList(label: "Number",controller: numberController),
            itemList(label: "Address",controller: addressController),
            itemList(label: "Account Number",controller: accountNoController),
            itemList(label: "Password",controller: passwordController),
            itemList(label: "City",controller: cityController),
            itemList(label: "Country",controller: countryController),
            const SizedBox(height: 20),
            isEdit ? Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 25),
              padding: const EdgeInsets.symmetric(horizontal: 30 ),
              child: AppWithoutBgButton(
                  padding: EdgeInsets.zero,
                  onTap: (){

                  },
                  buttonText: "Save",
                  buttonColor:ColorConstant.appGreen ,
                  borderColor:ColorConstant.appGreen,textColor:ColorConstant.appWhite),
            ):const SizedBox()
        ],),
      ),
    );
  }

  itemList({String? label,TextEditingController? controller}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15,top: 15,bottom: 10  ),
          child: AppText(text:label,textColor: ColorConstant.appGrey,fontWeight: FontWeight.w500,),
        ),
        AppTextField(
          readOnly: !isEdit,
           controller:controller,
            isUnderLine: false,
            hint: label),
      ],
    );
  }
}
