import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mock_back_home/component/mySearchDele.dart';
import 'package:mock_back_home/global.dart';
import 'package:mock_back_home/pages/tabMenu.dart';

// ignore: non_constant_identifier_names
Widget MyAppBar({tabController: TabController, context: BuildContext}) {
  final Color tabBarBackground = Colors.grey[50];
  final IconThemeData globalIconTheme = Theme.of(context).iconTheme;
  return new AppBar(
    toolbarHeight: 115,
    titleSpacing: 0,
    excludeHeaderSemantics: true,
    title: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
            child: Row(
          children: [
            IconButton(
                icon: Image.asset("assets/ulife_icon.png"), onPressed: () {}),
            Expanded(
              child: Container(
                //color: Colors.grey.withOpacity(0.2),
                height: 30,
                child: TextField(
                  decoration: roundTextField,
                  readOnly: true,
                  onTap: () {
                    showSearch(context: context, delegate: MySearchDele());
                    //Navigator.push(context, MySearchDele());
                  },
                ),
              ),
            ),
            IconButton(
                icon: Icon(
                  Icons.account_circle_rounded,
                  size: globalIconTheme.size,
                  color: globalIconTheme.color,
                ),
                onPressed: () {}),
          ],
        )),
        Container(
          //height: 40,
          child: Row(
            children: [
              IconButton(
                  //hide the onpress animation of icon button
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  icon: Icon(
                    Icons.menu,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TabMenu(tabController),
                            fullscreenDialog: true));
                  }),
              Expanded(
                  child: Container(
                //color: tabBarBackground,
                decoration: BoxDecoration(
                  color: tabBarBackground,
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [0, 0.02, 0.04],
                    colors: [
                      Colors.grey[300],
                      Colors.grey[200],
                      Colors.grey[100],
                      //tabBarBackground,
                    ],
                  ),
                ),
                child: TabBar(
                  controller: tabController,
                  isScrollable: true,
                  tabs: <Widget>[
                    for (String element in tabName)
                      Tab(
                        text: element,
                      )
                  ],
                ),
              )),
            ],
          ),
        )
      ],
    ),
  );
}
