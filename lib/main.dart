import 'package:flutter/material.dart';
import 'package:td_movie/screen/home/home_container.dart';
import 'package:td_movie/util/strings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(Strings.appTitle),
        ),
        body: HomeContainer(),
      ),
    );
  }
}
