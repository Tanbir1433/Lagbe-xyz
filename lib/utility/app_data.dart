import 'package:flutter/material.dart';

import 'bottom_navy_bar_item.dart';


class AppData {
  const AppData._();


  static List<Color> randomColors = [
    const Color(0xFFFCE4EC),
    const Color(0xFFF3E5F5),
    const Color(0xFFEDE7F6),
    const Color(0xFFE3F2FD),
    const Color(0xFFE0F2F1),
    const Color(0xFFF1F8E9),
    const Color(0xFFFFF8E1),
    const Color(0xFFECEFF1),
  ];


  static List<Color> randomPosterBgColors = [
    const Color(0xFF5068F2),
    const Color(0xFFDF71EA),
    const Color(0xFF87D082),
    const Color(0xFF5068F2),
    const Color(0xFF87D082),
    const Color(0xFFDF71EA),
    const Color(0xFF7D46BC),
    const Color(0xFFE518D1),
  ];

  static List<BottomNavyBarItem> bottomNavyBarItems = [
    const BottomNavyBarItem(
      "Home",
      Icon(Icons.home),
      Color(0xFF551AA2),
    ),
    const BottomNavyBarItem(
      "Favorite",
      Icon(Icons.favorite),
      Color(0xFF551AA2),
    ),
    const BottomNavyBarItem(
      "Cart",
      Icon(Icons.shopping_cart),
      Color(0xFF551AA2),
    ),
    const BottomNavyBarItem(
      "Profile",
      Icon(Icons.person),
      Color(0xFF551AA2),
    ),
  ];

}
