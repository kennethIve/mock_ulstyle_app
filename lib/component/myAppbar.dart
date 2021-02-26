import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mock_back_home/component/mySearchDele.dart';
import 'package:mock_back_home/global.dart';
import 'package:mock_back_home/pages/tabMenu.dart';

// ignore: non_constant_identifier_names
Widget MyAppBar({tabController: TabController, context: BuildContext}) {
  return new AppBar(
    toolbarHeight: 90,
    title: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
            child: Row(
          children: [
            IconButton(
                icon: Icon(
                  Icons.home,
                ),
                onPressed: () {}),
            Expanded(
              child: Container(
                color: Colors.grey.withOpacity(0.2),
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
                icon: Icon(Icons.account_circle_rounded), onPressed: () {}),
          ],
        )),
        Container(
          height: 40,
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
                  child: TabBar(
                controller: tabController,
                indicatorColor: Colors.black,
                isScrollable: true,
                tabs: <Widget>[
                  for (String element in tabName)
                    Tab(
                      text: element,
                    )
                ],
              )),
            ],
          ),
        )
      ],
    ),
  );
}
