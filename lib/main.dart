import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mock_back_home/component/myAppbar.dart';
import 'package:mock_back_home/pages/page1.dart';
import 'package:mock_back_home/view_archive.dart';

import 'global.dart';

void main() {
  runApp(MyApp());
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
  var isSelected = <bool>[true, false, false];
  var index = 0;
  TabController tabController = new TabController(length: 5, vsync: MyTicker());

  @override
  Widget build(BuildContext context) {
    Widget mainPage = Scaffold(
      appBar: MyAppBar(tabController: tabController, context: context),
      body: TabBarView(
        controller: tabController,
        children: [
          MyPage("page 1"),
          MyPage("page 2"),
          MyPage("page 3"),
          MyPage("page 4"),
          MyPage("page 5")
        ],
      ),
    );
    Archive archive = new Archive();
    return Scaffold(
      body: (index == 2) ? archive : mainPage,
      floatingActionButton: Container(
          child: ToggleButtons(
        fillColor: Color(0xFF6200EE).withOpacity(0.08),
        splashColor: Color(0xFF6200EE).withOpacity(0.12),
        hoverColor: Color(0xFF6200EE).withOpacity(0.9),
        borderRadius: BorderRadius.circular(90.0),
        isSelected: isSelected,
        onPressed: (index) {
          isSelected = <bool>[false, false, false];
          isSelected[index] = true;
          switch (index) {
            case 0:
              {
                Navigator.of(context).popUntil((route) => route.isFirst);
              }
              break;
            case 2:
              {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Archive()));
              }
              break;
            default:
              {
                this.index = index;
              }
          }
          //setState(() {});
        },
        children: [
          Icon(Icons.favorite),
          Icon(Icons.visibility),
          Icon(Icons.notifications),
        ],
      )),
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
