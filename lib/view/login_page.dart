import 'package:flutter/material.dart';
import 'package:flutter_study/util/router_jump.dart';
import 'package:toast/toast.dart';
import 'package:flutter_study/http/Api.dart';
import 'package:flutter_study/constant/Constant.dart';
import 'package:flutter_study/entity_factory.dart';
import 'package:flutter_study/model/user_bean_entity.dart';
///0 登录页面 1注册
class LoginPage extends StatelessWidget {

  final int type;

  LoginPage(this.type);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(type == 0 ? '登录' : '注册'),),
      body: LoginPageView(type),
      resizeToAvoidBottomPadding: false,
    );
  }

}

class LoginPageView extends StatefulWidget {

  final int type;

  LoginPageView(this.type);

  @override
  State<StatefulWidget> createState() {
    return LoginPageState(type);
  }
}

class LoginPageState extends State<LoginPageView> {

  TextEditingController accountController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final int type;

  LoginPageState(this.type);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Image.asset("images/logo.png", width: 100.0, height: 100.0, fit: BoxFit.fill,),
          margin: EdgeInsets.only(top: 20.0),
          alignment: Alignment.center,
        ),
        Container(
          margin: EdgeInsets.only(left: 40, right: 40),
          child: TextField(
            controller: accountController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              icon: Icon(Icons.account_box),
              contentPadding: EdgeInsets.all(10.0),
              labelText: "账户"
            ),
            autofocus: false,
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 40, right: 40, bottom: 40),
          child: TextField(
            controller: passwordController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                icon: Icon(Icons.pan_tool),
                contentPadding: EdgeInsets.all(10.0),
                labelText: "密码"
            ),
            autofocus: false,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 100.0,
              child: RaisedButton(
                onPressed: _login,
                child: Text(type == 0 ? "登录" : "提交"),
                color: Colors.blue,
                textColor: Colors.white,
                splashColor: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))
                ),
              ),
            ),
            Visibility(
              visible: type == 0 ? true : false,
              child: Container(
                width: 100.0,
                margin: EdgeInsets.only(left: 20.0),
                child: RaisedButton(
                  onPressed: _register,
                  child: Text("注册"),
                  color: Colors.blue,
                  textColor: Colors.white,
                  splashColor: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                  ),
                ),

              ),
            ),
          ],
        )
      ],
    );
  }

  void _login() {

    checkParms(() {

      if (type == 0) {
        //登录
        Map<String, String> map = {};
        map['username'] = accountController.text;
        map['password'] = passwordController.text;
        Api.getApi().postData(loginUrl, parameters: map, voidCallback: (result){
          //登录成功
          UserBeanEntity userBeanEntity = EntityFactory.generateOBJ(map);
          print(userBeanEntity);
          Navigator.pop(context);
          Toast.show('登录成功', context);
        });

      } else {
        //注册
        Map<String, String> map = {};
        map['username'] = accountController.text;
        map['password'] = passwordController.text;
        map['repassword'] = passwordController.text;
        Api.getApi().postData(registerUrl, parameters: map, voidCallback: (result){
          //注册
          Navigator.pop(context);
          Toast.show('注册成功', context);
        });
      }
    });

  }

  void checkParms(callBack) {
    //登录
    if (accountController.text == null || accountController.text.length == 0) {
      Toast.show('请输入账号', context);
    } else if (passwordController.text == null || passwordController.text.length == 0) {
      Toast.show('请输入密码', context);
    } else {
      callBack();
    }
  }

  void _register() {
    Router.getInstance().startPage(context, LoginPage(1));
  }
}
