import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
var global_theme = new ThemeData(
    primaryColor: Colors.white,
    accentColor: Colors.red,
    tabBarTheme: TabBarTheme(
        labelPadding: EdgeInsets.symmetric(
          horizontal: 8,
        ),
        labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontSize: 15),
        indicatorSize: TabBarIndicatorSize.label,
        unselectedLabelColor: Colors.grey),
    indicatorColor: Colors.black,
    scaffoldBackgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.grey, size: 33));

const roundBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(90)),
  borderSide: BorderSide(color: Colors.transparent),
);

final InputDecoration roundTextField = InputDecoration(
  border: roundBorder,
  focusedBorder: roundBorder,
  enabledBorder: roundBorder,
  prefixIcon: Icon(
    Icons.search,
    color: Colors.grey,
  ),
  fillColor: Colors.grey.withOpacity(0.1),
  filled: true,
  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
  hintText: "搜尋 \“Staycation 優惠\”",
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
);

enum PageName {
  home,
  dontKnow,
  archive,
}

List<String> routeList = [
  "/", //home route
  "/utv",
  "/jetso",
  "/helper",
  "/archive",
];

List<String> tabName = <String>[
  "最新",
  "熱門",
  "TV",
  "著數",
  "美食",
  "女生",
  "好去處",
  "娛樂",
  "食譜",
  "熱爆話題",
  "網購",
  "生活",
  "旅遊",
  "科技玩物",
  "Blog"
];
