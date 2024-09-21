// ignore_for_file: depend_on_referenced_packages

import 'package:expense_tracker_app/sqflite_database/database.dart';
import 'package:expense_tracker_app/widget/app_text.dart';
import 'package:expense_tracker_app/widget/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../constant/color_constant.dart';
import '../../provider/transation_provider.dart';
import '../../widget/app_appbar.dart';
import '../../widget/app_button.dart';
import '../welcome_page.dart';
import 'package:timezone/timezone.dart' as tz;

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class AddReminderPage extends StatefulWidget {
  const AddReminderPage({Key? key}) : super(key: key);

  @override
  State<AddReminderPage> createState() => _AddReminderPageState();
}

class _AddReminderPageState extends State<AddReminderPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController reminderController  = TextEditingController();
  TextEditingController amtController  = TextEditingController();
  TextEditingController dateController  = TextEditingController();
  TextEditingController timeController  = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        showProfile: false,
        showTitle: true,
        appbarTitle: "Add Reminder",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              // showList(),
              AppText2Field(
                controller: reminderController,
                hint: 'Enter reminder',
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Please enter reminder name.";
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
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  DateTime? pickerDate = await showDatePicker(
                      context: context,
                      lastDate: DateTime(2090),
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now());
                  if (pickerDate != null) {
                    debugPrint("--->pickerDate $pickerDate");
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
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  TimeOfDay? pickerTime = (await showTimePicker(
                      context: context,
                      initialTime: const TimeOfDay(hour: 0, minute: 0)));
                  if (pickerTime != null) {
                    debugPrint("--->pickerDate $pickerTime");
                    var now = DateTime.now();
                    var dt = DateTime(now.year, now.month, now.day, pickerTime.hour, pickerTime.minute);
                    String formatTime = DateFormat.Hms().format(dt);
                    timeController.text = formatTime;
                  }
                },
                controller: timeController,
                hint: 'Enter time',
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Please enter time";
                  }
                  return null;
                },
              ),
              AppWithoutBgButton(
                  padding: const EdgeInsets.only(top: 10),
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      // DateTime date = DateTime.parse(dateController.text);
                      // String createDate = DateTime(date.year, date.month, 1).toString();
                      // print("-->${createDate}");
                      DateTime dateSchedule=  DateTime.parse("${dateController.text} ${timeController.text}");
                      if(dateSchedule.isBefore(DateTime.now())) {
                        ScaffoldMessenger.of(context).showSnackBar( const SnackBar(shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                          backgroundColor: ColorConstant.appThemeColor,
                          behavior: SnackBarBehavior.floating,
                          elevation: 6.0,
                          content: AppText(text:'Please select datetime after current time!',textColor: ColorConstant.appWhite,fontWeight: FontWeight.w500),
                        ));
                      }else{
                      Map<String, dynamic> addReminder = {
                        'reminderName': reminderController.text,
                        'reminderDate': '${dateController.text} ${timeController.text}',
                        'reminderAmt': amtController.text,
                        'userId': storeUserId,
                      };
                       int addId = await DatabaseProvider.addReminder(addReminder);
                      _zonedScheduleNotification(id: addId,dateTime: dateSchedule);
                        TransactionProvider trans =
                        Provider.of<TransactionProvider>(this.context, listen: false);
                        await trans.getAllReminder();
                    }
                    }
                },
                  buttonText: "Set Reminder",
                  buttonColor: ColorConstant.appGreen,
                  borderColor: ColorConstant.appGreen,
                  textColor: ColorConstant.appWhite),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _zonedScheduleNotification({int? id,DateTime? dateTime}) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        reminderController.text,
        amtController.text,
        tz.TZDateTime.from(dateTime!, tz.local),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'your channel id', 'your channel name',
                channelDescription: 'your channel description')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime).then((value) {
        reminderController.clear();
        amtController.clear();
        dateController.clear();
        timeController.clear();
        Navigator.pop(context);
    });
  }
}
