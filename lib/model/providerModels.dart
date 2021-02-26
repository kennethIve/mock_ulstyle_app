import 'package:flutter/material.dart';

class BottomMenuState extends ChangeNotifier {
  List<bool> isSelected = <bool>[true, false, false];
  int index = 0;
  int pageCount = 0;

  Future<void> setActivePageTo(page) async {
    isSelected = <bool>[false, false, false];
    isSelected[page] = true;
    index = page;
    notifyListeners();
  }

  List<bool> getIsSelected() => isSelected;

  int getIndex() => index;

  @override
  String toString() {
    return "isSelected:$isSelected  index:$index _pageCount:$pageCount";
  }
}
