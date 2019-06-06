import 'package:flutter/material.dart';

class MyTheme {

  ThemeData getTheme() {

    return ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
        backgroundColor: Colors.white,
        bottomAppBarColor: Colors.white,
        textTheme: TextTheme(
          title: TextStyle(
            color: Colors.white
          )
        )

    );
  }

}

