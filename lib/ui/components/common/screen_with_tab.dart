import 'package:flutter/material.dart';

class ScreenWithTab {
  ScreenWithTab({
    this.page,
    this.title,
    this.color,
    this.icon,
  });

  final Widget page;
  final String title;
  final Color color;
  final IconData icon;
}
