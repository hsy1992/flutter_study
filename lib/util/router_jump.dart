import 'package:flutter/material.dart';
///路由跳页传值

class Router {

  static Router router;

  static Router getInstance() {
    return router == null ? Router() : router;
  }

  void startPage (context, page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return page;
    }));
  }

}





