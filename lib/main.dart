import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mock_back_home/component/bottomMenu.dart';
import 'package:mock_back_home/model/providerModels.dart';
import 'package:mock_back_home/pages/mainPage.dart';
import 'package:mock_back_home/pages/view_archive.dart';
import 'package:provider/provider.dart';

import 'global.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<BottomMenuState>(create: (_) => BottomMenuState()),
      Provider<BottomMenuObserver>(
        create: (_) => new BottomMenuObserver(),
      ),
      ChangeNotifierProvider<TabController>(
          create: (_) => TabController(
              initialIndex: 0, length: tabName.length, vsync: MyTicker())),
    ],
    child: MyApp(),
  ));
}

//testing firebase messaging
Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    final dynamic notification = message['notification'];
  }
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
  GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {
      _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print("onMessage: $message");
        },
        //onBackgroundMessage: myBackgroundMessageHandler,
        onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
        },
        onResume: (Map<String, dynamic> message) async {
          print("onResume: $message");
        },
      );
      _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true),
      );
    }
    if (Platform.isAndroid) {
      _firebaseMessaging.getToken().then((token) {
        print("Firebase Token: $token");
      });
      _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print("onMessage: $message");
        },
        onBackgroundMessage: myBackgroundMessageHandler,
        onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
        },
        onResume: (Map<String, dynamic> message) async {
          print("onResume: $message");
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = Provider.of<TabController>(context);

    Widget mainPage =
        MainPage(tabController: tabController, parentContext: context);

    BottomMenuObserver routeObserver = Provider.of<BottomMenuObserver>(context);

    Archive archive = new Archive(routeObserver);
    return Provider<BuildContext>(
      create: (_) => this.context,
      child: Scaffold(
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
          observers: [routeObserver],
        ),
        //floatingActionButton: BottomMenu(_navigatorKey),
        floatingActionButton: BottomMenu(_navigatorKey),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
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
  bool _isPopped = false;
  @override
  void didPop(Route route, Route previousRoute) {
    // TODO: implement didPop
    //super.didPop(route, previousRoute);
    Provider.of<BottomMenuState>(this.navigator.context, listen: false)
        .setActivePageToHome();
    debugPrint("did Pop");
    _isPopped = true;
  }

  @override
  void didPush(Route route, Route previousRoute) {
    // TODO: implement didPush
    debugPrint("did push");
  }

  @override
  void didRemove(Route route, Route previousRoute) {
    // TODO: implement didRemove
    Provider.of<BottomMenuState>(this.navigator.context, listen: false)
        .setActivePageToHome();
    debugPrint("did didremove");
  }

  @override
  void didReplace({Route newRoute, Route oldRoute}) {
    // TODO: implement didReplace
    debugPrint("did replace");
  }

  @override
  void didStartUserGesture(Route route, Route previousRoute) {
    // TODO: implement didStartUserGesture
    //super.didStartUserGesture(route, previousRoute);

    Provider.of<BottomMenuState>(this.navigator.context, listen: false)
        .setActivePageTo(0);
    _isPopped = false;
    debugPrint("did start gesture");
  }

  @override
  void didStopUserGesture() {
    // TODO: implement didStopUserGesture
    if (!_isPopped)
      Provider.of<BottomMenuState>(this.navigator.context, listen: false)
          .restoreActicePage();
    debugPrint("did stop gesture: ${navigator.widget}");
  }

  @override
  // TODO: implement navigator
  NavigatorState get navigator => super.navigator;
}
