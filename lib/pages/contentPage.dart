import 'package:flutter/material.dart';
import 'package:mock_back_home/global.dart';
import 'package:provider/provider.dart';

class ContentDetailPage extends StatefulWidget {
  @override
  _ContentDetailPageState createState() => _ContentDetailPageState();
}

class _ContentDetailPageState extends State<ContentDetailPage> {
  @override
  Widget build(BuildContext context) {
    TabController tabController = Provider.of<TabController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(tabName[tabController.index]),
      ),
      body: Center(
        child: Text("Content Detail Page"),
      ),
    );
  }
}
