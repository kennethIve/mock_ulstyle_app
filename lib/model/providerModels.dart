import 'package:flutter/material.dart';

class BottomMenuState extends ChangeNotifier {
  List<bool> isSelected = <bool>[true, false, false, false, false];
  int index = 0;
  int previousIndex = 0;
  int pageCount = 0;
  bool shownFlag = true;

  Future<void> setActivePageTo(page) async {
    isSelected = <bool>[true, false, false, false, false];
    isSelected[page] = true;
    previousIndex = index;
    index = page;
    pageCount++;
    shownFlag = true;
    notifyListeners();
  }

  Future<void> setActivePageToHome() async {
    index = 0;
    pageCount = 0;
    isSelected = <bool>[true, false, false, false, false];
    isSelected[index] = true;
    shownFlag = true;
    notifyListeners();
  }

  Future<void> fadeOut(isShown) async {
    if (isShown != this.shownFlag) {
      shownFlag = isShown;
      notifyListeners();
    }
  }

  Future<void> restoreActicePage() async {
    isSelected = <bool>[true, false, false, false, false];
    isSelected[previousIndex] = true;
    var temp = index;
    index = previousIndex;
    previousIndex = temp;
    //pageCount = 0;
    notifyListeners();
  }

  List<bool> getIsSelected() => isSelected;

  int getIndex() => index;

  @override
  String toString() {
    return "isSelected:$isSelected  index:$index _pageCount:$pageCount";
  }
}
