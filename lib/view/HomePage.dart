import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_study/view/BasePage.dart';
import 'package:flutter_study/http/Api.dart';
import 'package:flutter_study/constant/Constant.dart';
import 'package:flutter_study/model/BannerBean.dart';

class HomePage extends BasePage {

  HomePage() : super(HomePageView());

}

class HomePageView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return HomePageViewState();
  }
}

class HomePageViewState extends State<HomePageView> {

  @override
  void initState() {
    super.initState();

    Future(_getBannerData);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
        ],
      ),
    );
  }

  void _getBannerData() async {
    List<BannerBean> bannerBeans = await Api.getApi().getBannerData();
    if (bannerBeans != null) {
      print(bannerBeans);
    }
  }
}


