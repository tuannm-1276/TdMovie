import 'package:flutter/material.dart';

class FailureWidget extends StatelessWidget {
  FailureWidget({
    this.message: '',
    this.backgroundColor: Colors.black,
    this.icon: const Icon(
      Icons.error,
      color: Colors.red,
      size: 80,
    ),
  });

  final String message;
  final Color backgroundColor;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            SizedBox(height: 16.0),
            Text(message),
          ],
        ),
      ),
    );
  }
}
