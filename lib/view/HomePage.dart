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
import 'package:flutter_study/widght/load_waiting.dart';

class HomePage extends BasePage {

  HomePage() : super(HomePageView());

}

class HomePageView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return HomePageViewState();
  }
}

class HomePageViewState extends State<HomePageView> with AutomaticKeepAliveClientMixin {

  List<BannerBean> list = [];

  List<ArticleBeanData> _articles = [];

  //滑动控制器
  ScrollController _scrollController = ScrollController();

  bool isPerformingRequest = false; // 是否有请求正在进行

  int page = 0;

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
  bool get wantKeepAlive => true;

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

        setState(() {
          list = result.map((bean) => BannerBean.fromMap(bean)).toList();
        });

      }
      Future(_getHomeArticleData);
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
      itemCount: _articles.length + 2,
      itemBuilder: (context, i) {

        print(_articles.length);

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
        } else if (_articles.length + 1 == i) {

          return buildProgressIndicator(isPerformingRequest);
        } else {

          return HomeItem(_articles[i - 1]);
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

      String requestUrl = homeArticleUrl + "/" + page.toString() + "/json";

      //发起网络请求
      Api.getApi().getData(requestUrl, voidCallback: (result) {

        if (result != null) {

          //json转化为对象
          ArticleBeanEntity articleBeanEntity = EntityFactory.generateOBJ(result);


          //没有数据时动画
          if (articleBeanEntity.datas.isEmpty) {
            double edge = 50.0;
            double offsetFromBottom = _scrollController.position.maxScrollExtent - _scrollController.position.pixels;

            if(offsetFromBottom < edge) {
              _scrollController.animateTo(
                  _scrollController.offset - (edge - offsetFromBottom),
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeOut);
            }
          }

          //没有下一页了
          if (!articleBeanEntity.over) {
            page++;
          }

          //改变状态
          setState(() {
            _articles.addAll(articleBeanEntity.datas);
            isPerformingRequest = false;
          });
        }
      });

    }
  }
}


