import 'package:flutter/material.dart';
import 'package:mock_back_home/component/myAppbar.dart';
import 'package:mock_back_home/pages/tabPage.dart';

import '../global.dart';

class MainPage extends StatefulWidget {
  final tabController;
  final parentContext;

  const MainPage({Key key, this.tabController, BuildContext this.parentContext})
      : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
          tabController: widget.tabController, context: widget.parentContext),
      body: TabBarView(
        controller: widget.tabController,
        children: [for (String element in tabName) MyPage(element)],
      ),
    );
  }
}
