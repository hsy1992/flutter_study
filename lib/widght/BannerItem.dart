import 'package:flutter/material.dart';
import 'package:flutter_study/model/BannerBean.dart';

/// 首页banner图的 item
class BannerItem extends StatefulWidget {

  final BannerBean bannerBean;

  BannerItem(this.bannerBean);

  @override
  State<StatefulWidget> createState() {
    return BannerItemState(this.bannerBean);
  }
}

class BannerItemState extends State<BannerItem> with SingleTickerProviderStateMixin{

  final BannerBean bannerBean;
  
  BannerItemState(this.bannerBean);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(
        height: 120.0,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(bannerBean.imagePath))
        
      ),
      child: Center(
        child: Text(bannerBean.title, style: TextStyle(color: Color(0xffffffff))),
      ),
    );
  }
}





