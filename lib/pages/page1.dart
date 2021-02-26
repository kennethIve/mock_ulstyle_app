import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  final String title;
  const MyPage(this.title);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  ScrollController _controller = new ScrollController();
  Random random = new Random();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.offset < -50 && _controller.offset > -80) {
        print(_controller.offset);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: CustomScrollView(
      controller: _controller,
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      slivers: <Widget>[
        CupertinoSliverRefreshControl(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
            setState(() {});
          },
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return ListTile(
                title: Text("ListTile no.$index"),
              );
            },
            childCount: random.nextInt(15),
          ),
        ),
      ],
    ));
  }
}
