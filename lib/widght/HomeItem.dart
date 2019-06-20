import 'package:flutter/material.dart';
import 'package:flutter_study/model/article_bean_entity.dart';
import 'package:flutter_study/util/check_status.dart';


///首页item
class HomeItem extends StatefulWidget {

  final ArticleBeanData entity;

  HomeItem(this.entity);

  @override
  State<StatefulWidget> createState() {
    return HomeItemState(entity);
  }

}

class HomeItemState extends State<HomeItem> {

  final ArticleBeanData entity;

  HomeItemState(this.entity);

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      height: 130.0,
      decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
          boxShadow: [new BoxShadow(color: Colors.grey, offset: Offset(0.0, 2.0)),
            new BoxShadow(color: Colors.grey, offset: Offset(0.0, -0.5))]
      ),
      child: GestureDetector(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text("作者："),
                  Expanded(child: Text(entity.author, style: TextStyle(color: Colors.blue))),
                  Text(entity.niceDate),
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 20.0),
                child: Text(entity.title, overflow: TextOverflow.ellipsis, maxLines: 1,),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 20.0),
                      child: Text(entity.chapterName, style: TextStyle(color: Colors.blue),),
                    ),
                  ),
                  GestureDetector(child: Icon(Icons.favorite, color: entity.collect ? Colors.red : Colors.grey), onTap: _onCollect,)
                ],
              )
            ],
          ), onTap: _onItemClick,
      )
    );
  }

  void _onCollect() {

    print(entity.title);
    checkLogin(context);
  }

  void _onItemClick() {
    print('item_click');
  }
}