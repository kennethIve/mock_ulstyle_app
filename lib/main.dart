import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mock_back_home/component/bottomMenu.dart';
import 'package:mock_back_home/model/providerModels.dart';
import 'package:mock_back_home/pages/mainPage.dart';
import 'package:mock_back_home/pages/page1.dart';
import 'package:mock_back_home/pages/view_archive.dart';
import 'package:provider/provider.dart';

import 'global.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<BottomMenuState>(create: (_) => BottomMenuState())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Back Home Safe?',
      theme: global_theme,
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  final controller = PageController(initialPage: 1);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TabController tabController =
      new TabController(length: tabName.length, vsync: MyTicker());
  GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    Widget mainPage =
        new MainPage(tabController: tabController, parentContext: context);
    Archive archive = new Archive();
    return Scaffold(
      body: Navigator(
        key: _navigatorKey,
        initialRoute: "/",
        onGenerateRoute: (settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case '/':
              builder = (BuildContext context) => mainPage;

              break;
            case '/archive':
              builder = (BuildContext context) => archive;
              break;
            default:
              builder = (BuildContext context) => mainPage;
              break;
          }
          return MaterialPageRoute(builder: builder, settings: settings);
        },
        observers: [
          BottomMenuObserver(context),
        ],
      ),
      //floatingActionButton: BottomMenu(_navigatorKey),
      floatingActionButton: Consumer<BottomMenuState>(
          builder: (context, model, child) => new BottomMenu(_navigatorKey)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class MyTicker extends TickerProvider {
  @override
  Ticker createTicker(onTick) {
    return Ticker(onTick, debugLabel: "Ticker trigger $onTick");
  }
}

class BottomMenuObserver extends NavigatorObserver {
  final BuildContext context;

  BottomMenuObserver(this.context);

  @override
  void didPop(Route route, Route previousRoute) {
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route route, Route previousRoute) {
    super.didPush(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route previousRoute) {
    print("remove");
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route newRoute, Route oldRoute}) {
    super.didReplace();
  }

  @override
  void didStartUserGesture(Route route, Route previousRoute) {
    print("start gesture");
    super.didStartUserGesture(route, previousRoute);
  }

  @override
  void didStopUserGesture() {
    print("end gesture");
  }
}
