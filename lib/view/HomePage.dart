import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_study/view/BasePage.dart';
import 'package:flutter_study/http/Api.dart';
import 'package:flutter_study/constant/Constant.dart';
import 'package:flutter_study/model/BannerBean.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

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

  List<BannerBean> list = [];

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
          new Container(
            width: MediaQuery.of(context).size.width,
            height: 200.0,
            child: Swiper(
              itemCount: list.length == 0 ? 1 : list.length,
              itemBuilder: _swiperBuilder,
              scrollDirection: Axis.horizontal,
              autoplay: true,
              onTap: (index) => debugPrint('点击了第$index个'),
              pagination: new SwiperPagination(
                  builder: DotSwiperPaginationBuilder(
                      color: Colors.black54,
                      activeColor: Colors.white
                  )
              ),
            ),
          )
        ],
      ),
    );
  }

  //获取banner数据
  void _getBannerData() async {
    List<BannerBean> bannerBeans = await Api.getApi().getBannerData();
    if (bannerBeans != null) {
      print(bannerBeans);
      setState(() {
        list = bannerBeans;
      });
    }
  }

  Widget _swiperBuilder(BuildContext context, int index) {

    if (list.length == 0) {
      return Image.network("http://via.placeholder.com/350x150", fit: BoxFit.fill,);
    } else {
      return Image.network(list[index].imagePath, fit: BoxFit.fill,);
    }

  }
}


