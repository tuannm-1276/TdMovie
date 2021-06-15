import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  showSnackBar(Widget content, Duration duration) {
    final snackBar = SnackBar(content: content, duration: duration);
    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }
}
