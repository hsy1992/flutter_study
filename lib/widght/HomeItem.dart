import 'package:flutter/material.dart';
import 'package:flutter_study/model/article_bean_entity.dart';

///首页item
class HomeItem extends StatelessWidget {

  final ArticleBeanEntity entity;

  HomeItem(this.entity);

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
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text("作者"),
                Expanded(child: Text("haosiyuan", style: TextStyle(color: Colors.blue))),
                Text("时间"),
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 20.0),
              child: Text("我是一个标题"),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    child: Text("分类", style: TextStyle(color: Colors.blue)),
                  ),
                ),
                Icon(Icons.favorite, color: Colors.red,)
              ],
            )
          ],
        ),
    );
  }

}