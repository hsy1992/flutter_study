import 'package:flutter/material.dart';

///登录页面
class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('登录'),),
      body: LoginPageView(),
    );
  }

}

class LoginPageView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPageView> {

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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 100.0,
              child: RaisedButton(
                onPressed: _login,
                child: Text("登录"),
                color: Colors.blue,
                textColor: Colors.white,
                splashColor: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))
                ),
              ),
            ),
            Container(
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
            )
          ],
        )
      ],
    );
  }

  void _login() {
  }

  void _register() {
  }
}
