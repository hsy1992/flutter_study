import 'package:flutter/material.dart';
import 'package:flutter_study/widght/navigation/NavigationBar.dart';
import 'package:flutter_study/view/FindPage.dart';
import 'package:flutter_study/view/HomePage.dart';
import 'package:flutter_study/view/MinePage.dart';
import 'package:flutter_study/util/ImageUtil.dart';

class MainPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NavigationBarBuilder()
          .setDefaultTextColor(Color(0xff8a8a8a))
          .setSelectTextColor(Color(0xff1296db))
          .addNavigationTab('首页', getImageAssets('images/icon_home.png'), getImageAssets('images/icon_home_select.png'), new HomePage())
          .addNavigationTab('发现', getImageAssets('images/icon_find.png'), getImageAssets('images/icon_find_select.png'), new FindPage())
          .addNavigationTab('我的', getImageAssets('images/icon_mine.png'), getImageAssets('images/icon_mine_select.png'), new MinePage())
          .build(),
    );
  }

}
