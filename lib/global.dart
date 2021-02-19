import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
var global_theme = new ThemeData(
    primaryColor: Colors.white,
    accentColor: Colors.red,
    scaffoldBackgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.blue, size: 20));

const roundBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(90)),
  borderSide: BorderSide(color: Colors.grey),
);

const roundTextField = InputDecoration(
  border: roundBorder,
  focusedBorder: roundBorder,
  enabledBorder: roundBorder,
  prefixIcon: Icon(
    Icons.search,
    color: Colors.grey,
  ),
  fillColor: Colors.grey,
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
