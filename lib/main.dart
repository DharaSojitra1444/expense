import 'package:expense_tracker_app/pages/markets_page/add_reminder_page.dart';
import 'package:expense_tracker_app/pages/welcome_page.dart';
import 'package:expense_tracker_app/provider/theme_provider.dart';
import 'package:expense_tracker_app/provider/transation_provider.dart';
import 'package:expense_tracker_app/provider/user_transaction_provider.dart';
import 'package:expense_tracker_app/sqflite_database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'constant/app_asset.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

localNotificationTimeWise() {
  const AndroidInitializationSettings android =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings(
    requestSoundPermission: true,
    requestBadgePermission: true,
    requestAlertPermission: true,
  );
  InitializationSettings initializationSettings = const InitializationSettings(
      android: android, iOS: initializationSettingsIOS);

  flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

getNameLocalTimeZone() async {
  tz.initializeTimeZones();
  if (DateTime.now().timeZoneName == "IST") {
    tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));
  } else {
    var locations = tz.timeZoneDatabase.locations;
    int milliseconds = DateTime.now().timeZoneOffset.inMilliseconds;
    String name = "";
    locations.forEach((key, value) {
      for (var element in value.zones) {
        if (element.offset == milliseconds) {
          name = value.name;
          break;
        }
      }
    });
    tz.setLocalLocation(tz.getLocation(name));
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  getNameLocalTimeZone();
  localNotificationTimeWise();
  await GetStorage.init();
  await DatabaseProvider.initDb();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    List<SingleChildWidget> providers = [
      ChangeNotifierProvider<TransactionProvider>(
          create: (context) => TransactionProvider()),
      ChangeNotifierProvider<UserTransactionProvider>(
          create: (context) => UserTransactionProvider()),
      ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider()),
    ];
    return MultiProvider(
      providers: providers,
      child: Consumer(
        builder: (context,ThemeProvider themeProvider,_) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: themeProvider.selectedThemeData,
            darkTheme: themeProvider.darkTheme,
            // theme: ThemeData(fontFamily: AppAsset.defaultFont),
            home: const WelcomePage(),
          );
        }
      ),
    );
  }
}
