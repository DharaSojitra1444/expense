import 'package:expense_tracker_app/pages/shopping_page/shopping_page.dart';
import 'package:expense_tracker_app/pages/user_profile/user_profile_page.dart';
import 'package:flutter/material.dart';
import '../../constant/app_asset.dart';
import '../../constant/color_constant.dart';
import '../home_page/home_page.dart';
import '../markets_page/markets_page.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  State<DashBoardPage> createState() => DashBoardPageState();
}

class DashBoardPageState extends State<DashBoardPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int selectedIndex = 0;

  final List<GlobalKey<NavigatorState>> navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  @override
  void initState() {
    super.initState();

    tabController = TabController(
        vsync: this,
        length: 4,
        initialIndex: 0,
        animationDuration: Duration.zero);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await navigatorKeys[selectedIndex].currentState!.maybePop();
        return isFirstRouteInCurrentTab;
      },
      child: DefaultTabController(
          length: 4,
          child: Scaffold(
              body: buildNavigator(selectedIndex),
              bottomNavigationBar: tabView())),
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context, int index) {
    return {
      '/': (context) {
        return [
          const HomePage(),
          const MarketPage(),
          const ShoppingPage(),
          const UserProfilePage(),
        ].elementAt(index);
      },
    };
  }

  Widget buildNavigator(int index) {
    var routeBuilders = _routeBuilders(context, index);
    return Offstage(
      offstage: selectedIndex != index,
      child: Navigator(
        key: navigatorKeys[index],
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => routeBuilders[routeSettings.name]!(context),
          );
        },
      ),
    );
  }

  Widget tabView() {
    return Container(
      height: 65,
      decoration: const BoxDecoration(
        color: ColorConstant.appBlack,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0,
          ),
        ],
      ),
      child: TabBar(
        padding: EdgeInsets.zero,
        labelColor: ColorConstant.appOrange,
        labelStyle:
            TextStyle(fontSize: MediaQuery.of(context).size.width * 0.029),
        unselectedLabelColor: Colors.white.withOpacity(0.7),
        indicatorSize: TabBarIndicatorSize.label,
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(
            width: 3.0,
            color: Colors.transparent,
          ),
        ),
        controller: tabController,
        onTap: (num int) {
          selectedIndex = int.toInt();
          setState(() {});
          // provider.dashboardNotifyListener();
        },
        tabs: const <Widget>[
          Tab(
            icon: ImageIcon(
              AssetImage(AppAsset.homeIcon),
              size: 24,
            ),
          ),
          Tab(
            icon: ImageIcon(AssetImage(AppAsset.marketsIcon), size: 23),
          ),
          Tab(
            icon: ImageIcon(
              AssetImage(AppAsset.shoppingIcon),
              size: 24,
            ),
          ),
          Tab(
            icon: ImageIcon(
              AssetImage(AppAsset.profileIcon),
              size: 24,
            ),
          )
        ],
      ),
    );
  }
}
