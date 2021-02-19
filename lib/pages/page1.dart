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
      child: Container(
        child: CustomRefresh(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
            //setState(() {});
          },
          color: Colors.grey,
          child: ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              controller: _controller,
              itemCount: random.nextInt(40),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("ListTile no.$index"),
                );
              }),
        ),
      ),
    );
  }
}

class CustomRefresh extends RefreshIndicator {
  final String name = "custom refresh";

  CustomRefresh(
      {Future<Null> Function() onRefresh, MaterialColor color, ListView child})
      : super(onRefresh: onRefresh, child: child, color: color) {}

  @override
  CustomRefreshState createState() => CustomRefreshState();
}

class CustomRefreshState extends RefreshIndicatorState {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [widget.child],
    );
  }
}
