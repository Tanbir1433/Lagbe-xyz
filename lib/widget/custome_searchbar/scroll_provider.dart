import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollProvider with ChangeNotifier {
  bool _showSearchBar = false;

  bool get showSearchBar => _showSearchBar;

  void onScroll(ScrollController scrollController) {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection == ScrollDirection.reverse) {

        if (_showSearchBar) {
          _showSearchBar = false;
          notifyListeners();
        }
      } else if (scrollController.position.userScrollDirection == ScrollDirection.forward) {

        if (!_showSearchBar) {
          _showSearchBar = true;
          notifyListeners();
        }
      }
    });
  }
}
