import 'package:flutter/material.dart';

class Archive extends StatelessWidget {
  var isSelected = <bool>[true, false, false];
  var index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("我的收藏")),
      body: Text("Archive Page"),
    );
  }
}
