import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_study/view/BasePage.dart';
import 'package:flutter_study/http/Api.dart';
import 'package:flutter_study/constant/Constant.dart';
import 'package:flutter_study/model/BannerBean.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_study/widght/HomeItem.dart';
import 'package:flutter_study/entity_factory.dart';
import 'package:flutter_study/model/article_bean_entity.dart';

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

  List<ArticleBeanEntity> articles = [];

  //滑动控制器
  ScrollController _scrollController = ScrollController();

  bool isPerformingRequest = false; // 是否有请求正在进行

  @override
  void initState() {
    super.initState();

    Future(_getBannerData);

    _scrollController.addListener((){
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _getHomeArticleData();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildHome(),
    );
  }

  //获取banner数据
  void _getBannerData() async {

    Api.getApi().getData(homeBannerUrl, voidCallbackList: (result) {
      
      if (result != null && result is List) {

        list = result.map((bean) => BannerBean.fromMap(bean)).toList();
      }
    });
  }

  Widget _swiperBuilder(BuildContext context, int index) {

    if (list.length == 0) {
      return Image.network("http://via.placeholder.com/350x150", fit: BoxFit.fill,);
    } else {
      return Image.network(list[index].imagePath, fit: BoxFit.fill,);
    }

  }

  Widget _buildHome() {

    return ListView.builder(
      controller: _scrollController,
      itemCount: articles.length + 1,
      itemBuilder: (context, i) {

        if (i == 0) {

          return new Container(
            width: MediaQuery.of(context).size.width,
            height: 180.0,
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
          );
        } else {

          return HomeItem(articles[i]);
        }

      }
    );
  }

  //首页文章列表
  void _getHomeArticleData() async {

    if (!isPerformingRequest) {
      //没有请求的时候 设置为正在请求
      setState(() {
        isPerformingRequest = true;
      });

      Api.getApi().getData(homeArticleUrl, voidCallbackList: (result) {

        if (result != null && result is List) {

          articles = EntityFactory.generateOBJ(result);
          print(articles);

          //没有数据时动画
          if (articles.isEmpty) {
            double edge = 50.0;
            double offsetFromBottom = _scrollController.position.maxScrollExtent - _scrollController.position.pixels;

            if(offsetFromBottom < edge) {
              _scrollController.animateTo(
                  _scrollController.offset - (edge - offsetFromBottom),
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeOut);
            }
          }

          setState(() {
            articles.addAll(articles);
            isPerformingRequest = false;
          });
        }
      });

    }
  }
}


