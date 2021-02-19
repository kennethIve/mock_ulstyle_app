import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mock_back_home/component/mySearchDele.dart';
import 'package:mock_back_home/global.dart';
import 'package:mock_back_home/main.dart';

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
              flex: 1,
              child: SizedBox(
                height: 30,
                child: TextField(
                  decoration: roundTextField,
                  readOnly: true,
                  onTap: () {
                    showSearch(context: context, delegate: MySearchDele());
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
                  icon: Icon(
                    Icons.menu,
                  ),
                  onPressed: () {}),
              Expanded(
                  child: TabBar(
                controller: tabController,
                isScrollable: true,
                tabs: [
                  Tab(
                    text: "Page 1",
                  ),
                  Tab(
                    text: "Page 2",
                  ),
                  Tab(
                    text: "Page 3",
                  ),
                  Tab(
                    text: "Page 4",
                  ),
                  Tab(
                    text: "Page 5",
                  ),
                ],
              )),
            ],
          ),
        )
      ],
    ),
  );
}
