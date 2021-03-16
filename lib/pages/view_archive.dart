import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mock_back_home/main.dart';
import 'package:mock_back_home/model/providerModels.dart';
import 'package:provider/provider.dart';

class Archive extends StatefulWidget {
  final NavigatorObserver routeObserver;

  const Archive(this.routeObserver);

  //const Archive();

  @override
  _ArchiveState createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> implements BottomMenuObserver {
  Function callback;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //widget.routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void didPop(route, previousRoute) {
    debugPrint("Archive Popped");
    Provider.of<BottomMenuState>(context, listen: false).setActivePageToHome();
  }

  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic> previousRoute) {
    debugPrint("getturestart");
  }

  @override
  void deactivate() {
    super.deactivate();
    //Provider.of<BottomMenuState>(context, listen: false).setActivePageToHome();
  }

  @override
  void dispose() {
    //widget.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的收藏"),
      ),
      body: null,
    );
  }

  @override
  void didPush(Route route, Route previousRoute) {}

  @override
  void didRemove(Route route, Route previousRoute) {}

  @override
  void didReplace({Route newRoute, Route oldRoute}) {}

  @override
  void didStopUserGesture() {}

  @override
  NavigatorState get navigator => throw UnimplementedError();
}
