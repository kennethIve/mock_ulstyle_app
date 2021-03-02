import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mock_back_home/model/providerModels.dart';
import 'package:provider/provider.dart';

import 'ContentPage.dart';

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
      //print(_controller.offset);
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
        child: NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification is UserScrollNotification) {
          if (notification.direction == ScrollDirection.reverse) {
            print("fade in menu");
            Provider.of<BottomMenuState>(context, listen: false).fadeOut(true);
          } else if (notification.direction == ScrollDirection.forward) {
            Provider.of<BottomMenuState>(context, listen: false).fadeOut(false);
          }
        }
        return true;
      },
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
                return UfoodContent(widget.title);
              },
              childCount: random.nextInt(15) + 5,
            ),
          ),
        ],
      ),
    ));
  }
}

abstract class Content extends StatelessWidget {
  final String appBarTitle;
  final String url =
      "https://resource01-proxy.ulifestyle.com.hk/res/v3/image/content/2825000/2829920/element5-digital-WCPg9ROZbM0-unsplash_1024.jpg";
  const Content(this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //Push to root context
        Navigator.push(
            Provider.of<BuildContext>(context, listen: false),
            MaterialPageRoute(
                builder: (context) => ContentDetailPage(),
                fullscreenDialog: true));
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 240,
              padding: EdgeInsets.symmetric(horizontal: 15),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(url), fit: BoxFit.cover),
              ),
              child: Wrap(
                alignment: WrapAlignment.start,
                spacing: 15,
                children: [
                  Chip(
                    backgroundColor: Colors.grey[400],
                    label: Text("美食開箱"),
                    labelStyle: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  Chip(
                    backgroundColor: Colors.grey[400],
                    label: Text("U Food"),
                    labelStyle: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "頭髮稀疏可能血氣不足！ 一文睇清脫髮原因＋防脫髮方法＋湯水食療推介",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                softWrap: true,
              ),
            ),
            Row(children: [
              IconButton(
                icon: Icon(Icons.local_florist_rounded),
                onPressed: () {},
              ),
              Text(
                "U Food",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    fontFamily: "Raleway"),
              ),
              Text(
                "  16 小時前",
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              Spacer(),
              IconButton(
                icon: Icon(CupertinoIcons.bookmark),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(CupertinoIcons.share),
                onPressed: () {},
              ),
            ]),
            Divider(
              indent: 20,
              endIndent: 20,
              thickness: 1,
              color: Colors.grey.withOpacity(0.2),
            ),
            Container(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

class UfoodContent extends Content {
  const UfoodContent(String appBar) : super(appBar);
}
