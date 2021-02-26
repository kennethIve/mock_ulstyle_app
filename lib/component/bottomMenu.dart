import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mock_back_home/model/providerModels.dart';
import 'package:provider/provider.dart';

class BottomMenu extends StatefulWidget {
  final GlobalKey<NavigatorState> _navigatorKey;
  const BottomMenu(this._navigatorKey);

  @override
  _BottomMenuState createState() => new _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  BottomMenuState state;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("did change");
  }

  @override
  Widget build(BuildContext context) {
    NavigatorState navigatorState = widget._navigatorKey.currentState;
    state = Provider.of<BottomMenuState>(context);
    print("BottomMenu rebuiilded");
    return Container(
      child: Container(
          child: ToggleButtons(
        fillColor: Color(0xFF6200EE).withOpacity(0.08),
        splashColor: Color(0xFF6200EE).withOpacity(0.12),
        hoverColor: Color(0xFF6200EE).withOpacity(0.9),
        borderRadius: BorderRadius.circular(90.0),
        isSelected: state.isSelected,
        onPressed: (index) {
          if (!state.isSelected[index]) {
            state.setActivePageTo(index);
            String url;
            print("menu pressed: ${state.toString()}");
            switch (index) {
              case 0:
                {
                  url = "/";
                  navigatorState.popUntil(ModalRoute.withName(url));
                  //navigatorState.popAndPushNamed(url);
                  state.pageCount = 0;
                  return;
                }
                break;
              case 1:
                {
                  url = "/archive";
                }
                break;
              case 2:
                {
                  url = "/archive";
                }
                break;
            }
            (state.pageCount == 0)
                ? navigatorState.pushNamed(url, arguments: () {})
                : navigatorState.pushReplacementNamed(url, arguments: () {});
            state.pageCount++;
          }
        },
        children: [
          Icon(Icons.favorite),
          Icon(Icons.visibility),
          Icon(Icons.notifications),
        ],
      )),
    );
  }
}
