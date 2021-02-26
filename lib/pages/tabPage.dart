import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
              return UfoodContent(widget.title);
            },
            childCount: random.nextInt(15) + 5,
          ),
        ),
      ],
    ));
  }
}

abstract class Content extends StatelessWidget {
  final String appBarTitle;

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
          children: [
            Image.network(
              "https://resource01-proxy.ulifestyle.com.hk/res/v3/image/content/2825000/2829920/element5-digital-WCPg9ROZbM0-unsplash_1024.jpg",
            ),
            Text(
              "頭髮稀疏可能血氣不足！ 一文睇清脫髮原因＋防脫髮方法＋湯水食療推介",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Row(children: [
              IconButton(
                icon: Icon(Icons.local_florist_rounded),
                onPressed: () {},
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
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }
}

class UfoodContent extends Content {
  const UfoodContent(String appBar) : super(appBar);
}
