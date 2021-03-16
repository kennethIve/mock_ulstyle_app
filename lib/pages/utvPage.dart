import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:mock_back_home/global.dart';
import 'package:mock_back_home/model/providerModels.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class UTVPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          excludeHeaderSemantics: true,
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: Row(
            children: [
              Expanded(
                child: Material(
                  elevation: 1,
                  borderRadius: BorderRadius.all(Radius.circular(90)),
                  child: Container(
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(
                        border: roundBorder,
                        focusedBorder: roundBorder,
                        enabledBorder: roundBorder,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: -15),
                        hintText: "搜尋影片",
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                        ),
                      ),
                      readOnly: true,
                      onTap: () => {},
                    ),
                  ),
                ),
              ),
              ButtonBar(
                children: [
                  IconButton(
                      icon: Icon(Icons.add_business_rounded),
                      onPressed: () => null),
                  IconButton(
                      icon: Icon(Icons.add_business_rounded),
                      onPressed: () => null),
                ],
              )
            ],
          ),
        ),
        body: new UTVPageBody(),
      ),
    );
  }
}

class UTVPageBody extends StatefulWidget {
  @override
  _UTVPageBodyState createState() => _UTVPageBodyState();
}

class _UTVPageBodyState extends State<UTVPageBody> {
  double viewportFraction = 0.85, pageOffset = 0;
  bool swipingFlag = false;

  PageController pageController;
  ScrollController scrollController;
  BottomMenuState bottomMenuState;
  VideoPlayerController videoPlayerController;

  final String videoUrl =
      "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";

  @override
  void initState() {
    super.initState();
    bottomMenuState = Provider.of<BottomMenuState>(context, listen: false);
    pageController =
        PageController(initialPage: 0, viewportFraction: viewportFraction)
          ..addListener(() {
            setState(() {
              pageOffset = pageController.page;
            });
          });

    videoPlayerController = VideoPlayerController.network(videoUrl)
      ..initialize().then((value) {
        //setState(() {});
      });
    scrollController = ScrollController()
      ..addListener(() {
        //print(scrollController.offset);
        if (!scrollController.keepScrollOffset) {
          Future.delayed(Duration(seconds: 2));
          print("is stop for 2 seconds");
          bottomMenuState.fadeOut(false);
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
    pageController.dispose();
    scrollController.dispose();
  }

  Widget _title(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _latestVideo() {
    final itemCount = 5;
    final double left = 20, right = 20;
    return Container(
        height: 300,
        child: PageView.builder(
          itemCount: itemCount,
          controller: pageController,
          pageSnapping: true,
          itemBuilder: (_, index) {
            double paddingScale =
                max(viewportFraction, (1 - (pageOffset - index).abs()));
            //double xScale = (pageOffset - index).abs();
            bool nextEnd = (pageOffset + 1.5 > itemCount);
            //videoPlayerController.play();
            return Transform.translate(
              offset: (nextEnd) ? Offset(10, 0) : Offset(-10, 0),
              child: Container(
                padding: EdgeInsets.only(
                    left: (nextEnd) ? left * paddingScale : 0,
                    right: (nextEnd) ? 0 : right * paddingScale),
                child: Card(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  elevation: 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: videoPlayerController.value.isInitialized
                        ? VideoPlayer(videoPlayerController)
                        : Center(
                            child: Text(
                              "loading..",
                            ),
                          ),
                  ),
                ),
              ),
            );
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
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
      child: SingleChildScrollView(
        controller: scrollController,
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title("最新影片"),
            _latestVideo(),
            _title("精彩節目"),
            _title("科技"),
            _title("美食"),
            _title("女生"),
            _title("烹飪"),
            _title("生活"),
            Padding(padding: EdgeInsets.all(30)),
          ],
        ),
      ),
    );
  }
}
