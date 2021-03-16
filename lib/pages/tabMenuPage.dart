import 'package:flutter/material.dart';
import 'package:mock_back_home/global.dart';

class TabMenuPage extends StatelessWidget {
  final double _borderRadius = 10;
  final double _containerHeight = 50;
  final double _fontSize = 20;
  final TabController tabController;

  const TabMenuPage(this.tabController);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("選擇分類"),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: tabName.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            print(tabName[index]);
            tabController.animateTo(index);
            Navigator.pop(context);
          },
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(_borderRadius)),
            borderOnForeground: true,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            child: Row(
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(_borderRadius),
                            bottomLeft: Radius.circular(_borderRadius))),
                    height: _containerHeight,
                    width: 30,
                    alignment: Alignment.center,
                    child: Text(
                      (index + 1).toString(),
                      style:
                          TextStyle(color: Colors.white, fontSize: _fontSize),
                    )),
                SizedBox(
                  width: 10,
                ),
                Text(
                  tabName[index],
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: _fontSize - 5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
