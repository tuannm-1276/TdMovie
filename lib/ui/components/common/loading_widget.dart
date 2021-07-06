import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  LoadingWidget({
    @required this.message,
    this.textStyle: const TextStyle(color: Colors.white),
  });

  final String message;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16.0),
            Text(
              message,
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
