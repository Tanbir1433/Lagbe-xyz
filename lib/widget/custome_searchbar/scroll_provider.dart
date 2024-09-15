import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollProvider with ChangeNotifier {
  bool _showSearchBar = false; // Initially hidden

  bool get showSearchBar => _showSearchBar;

  void onScroll(ScrollController scrollController) {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        // Scrolling down
        if (_showSearchBar) {
          _showSearchBar = false;
          notifyListeners();
        }
      } else if (scrollController.position.userScrollDirection == ScrollDirection.forward) {
        // Scrolling up
        if (!_showSearchBar) {
          _showSearchBar = true;
          notifyListeners();
        }
      }
    });
  }
}
