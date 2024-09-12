import 'package:flutter/material.dart';

class AppBarState with ChangeNotifier {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  bool get isSearching => _isSearching;
  TextEditingController get searchController => _searchController;

  void toggleSearch() {
    _isSearching = !_isSearching;
    notifyListeners();
  }

  void clearSearch() {
    _isSearching = false;
    _searchController.clear();
    notifyListeners();
  }
}
