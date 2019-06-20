import 'package:flutter_study/util/router_jump.dart';
import 'package:flutter_study/view/login_page.dart';
///检查登录状态

void checkLogin(context) {

  Router.getInstance().startPage(context, LoginPage());

}
