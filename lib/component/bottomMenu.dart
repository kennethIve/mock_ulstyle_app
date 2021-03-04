import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mock_back_home/global.dart';
import 'package:mock_back_home/model/providerModels.dart';
import 'package:provider/provider.dart';

class BottomMenu extends StatefulWidget {
  final GlobalKey<NavigatorState> _navigatorKey;

  const BottomMenu(this._navigatorKey);

  @override
  _BottomMenuState createState() => new _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> with TickerProviderStateMixin {
  final double radius = 45;
  BottomMenuState state;

  @override
  void initState() {
    super.initState();
    print("fade in the menu");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //debugPrint("BottomMenu: didChangeDependencies");
  }

  @override
  Widget build(BuildContext context) {
    NavigatorState navigatorState = widget._navigatorKey.currentState;
    state = Provider.of<BottomMenuState>(context);
    final animationController =
        AnimationController(duration: Duration(milliseconds: 700), vsync: this);
    final fadeOutOnScrollAnimation =
        Tween(begin: 1.0, end: .0).animate(animationController);

    debugPrint("BottomMenu rebuiilded");
    (state.shownFlag)
        ? animationController.forward()
        : animationController.reverse();
    return FadeTransition(
      opacity: fadeOutOnScrollAnimation,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            child: Container(
                width: 300,
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.blue,
                  unselectedItemColor: Colors.grey,
                  enableFeedback: false,
                  showUnselectedLabels: true,
                  unselectedFontSize: 14,
                  currentIndex: state.index,
                  onTap: (int index) {
                    if (index == state.index) return;
                    if (index == 0) {
                      navigatorState
                          .popUntil(ModalRoute.withName(routeList[index]));
                      state.setActivePageToHome();
                    } else {
                      if (state.pageCount > 0)
                        navigatorState.pushReplacementNamed(routeList[index]);
                      else
                        navigatorState.pushNamed(routeList[index]);
                      state.setActivePageTo(index);
                    }
                  },
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.home), label: "首頁"),
                    BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.play_rectangle_fill),
                        label: "U TV"),
                    BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.underline), label: "U Jetso"),
                    BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.square_grid_2x2),
                        label: "小幫手"),
                    BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.bookmark_fill), label: "收藏夾"),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
