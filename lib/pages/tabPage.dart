import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mock_back_home/controller/ufoodApi.dart';
import 'package:mock_back_home/model/providerModels.dart';
import 'package:mock_back_home/model/xml2jsonModel.dart';
import 'package:provider/provider.dart';

import 'ContentPage.dart';

class MyPage extends StatefulWidget {
  final String title;
  const MyPage(this.title);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  ScrollController _controller;
  Random random = new Random();
  BottomMenuState bottomMenuState;
  List<Article> contentList = [];

  @override
  void initState() {
    super.initState();
    _getContentList();
    _controller = ScrollController();
    _controller.addListener(() {
      //print(_controller.offset);
      if (!_controller.keepScrollOffset) {
        Future.delayed(Duration(seconds: 2));
        print("is stop for 2 seconds");
        bottomMenuState.fadeOut(false);
      }
    });
  }

  _getContentList() {
    UFoodAPi().getFoodNews().then((result) {
      contentList = result;
      setState(() {});
    });
  }

  @override
  void deactivate() {
    print("homepage dispose");
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bottomMenuState = Provider.of<BottomMenuState>(context, listen: false);
    return Container(
        child: NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification is UserScrollNotification) {
          if (notification.direction == ScrollDirection.reverse) {
            print("fade in menu");
            bottomMenuState.fadeOut(false);
          } else if (notification.direction == ScrollDirection.forward) {
            bottomMenuState.fadeOut(true);
          }
        } else if (notification is ScrollEndNotification) {
          bottomMenuState.fadeOut(true);
        }
        return true;
      },
      child: CustomScrollView(
        controller: _controller,
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: <Widget>[
          CupertinoSliverRefreshControl(
            onRefresh: () async {
              contentList = await UFoodAPi().getFoodNews();
              setState(() {});
            },
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                Article article = contentList[index];
                return UfoodContent(
                    article, "${article.title} ", article.thumbnail);
              },
              childCount: contentList.length,
            ),
          ),
          SliverPadding(padding: EdgeInsets.all(35))
        ],
      ),
    ));
  }
}

abstract class Content extends StatelessWidget {
  final String appBarTitle;
  final String url;
  const Content(this.appBarTitle, this.url);

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
                appBarTitle,
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
  final Article article;
  const UfoodContent(Article this.article, String title, String url)
      : super(title, url);
}
