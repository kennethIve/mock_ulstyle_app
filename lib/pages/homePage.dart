import 'package:flutter/material.dart';
import 'package:mock_back_home/component/myAppbar.dart';
import 'package:mock_back_home/pages/tabPage.dart';

import '../global.dart';

class HomePage extends StatefulWidget {
  final tabController;
  final parentContext;

  const HomePage({Key key, this.tabController, BuildContext this.parentContext})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
