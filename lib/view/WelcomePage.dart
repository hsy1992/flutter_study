import 'package:flutter/material.dart';
import 'package:flutter_study/util/ImageUtil.dart';
import 'dart:async';
import 'package:flutter_study/view/MainPage.dart';

class WelcomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return WelcomePageState();
  }

}

class WelcomePageState extends State<WelcomePage> with SingleTickerProviderStateMixin{
  Timer _timer;
  @override
  Widget build(BuildContext context) {

    jump(context);
    return Container(
      child: getImageAssets('images/bg_advertising.jpg'),
    );
  }

  ///跳页并销毁当前页面
  void jump(context) async {
    //倒计时3秒后跳页
    if (_timer == null) {
      _timer = Timer(
          Duration(seconds: 3),
              () => Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) {

                return MainPage();
              }), (router) => router == null)
      );
    }
  }

  ///销毁
  @override
  void dispose() {

    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }

    super.dispose();
  }
}

