import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {

  final Widget widget;

  BasePage(this.widget);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget,
    );
  }

}

