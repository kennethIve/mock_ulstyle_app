import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mock_back_home/model/providerModels.dart';
import 'package:provider/provider.dart';

class Archive extends StatefulWidget {
  //const Archive();

  @override
  _ArchiveState createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  Function callback;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant Archive oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    Provider.of<BottomMenuState>(context, listen: false).setActivePageTo(0);
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget pop = WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Text("data"),
    );
    //callback = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("我的收藏"),
        leading: CupertinoButton(
            child: Icon(Icons.arrow_back_ios_outlined), onPressed: () {}),
      ),
      body: null,
    );
  }
}
