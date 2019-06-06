import 'package:flutter/material.dart';
import 'package:flutter_study/theme/MyTheme.dart';
import 'package:flutter_study/view/WelcomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Endless Android',
      theme: MyTheme().getTheme(),
      home: WelcomePage(),
    );
  }
}

