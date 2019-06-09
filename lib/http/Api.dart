import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_study/model/BannerBean.dart';
///http请求类


Future<BannerBean> getHomeBean(String msg) async {
  // http.post 用来执行一个 HTTP POST 请求。   
  //  // 它的 body 参数是一个 dynamic，可以支持不同类型的 body，这里我们    
  //  只是直接把客户输入的消息发给服务端就可以了。由于 msg 是一个 String，    
  //  post 方法会自动设置 HTTP 的 Content-Type 为 text/plain

  final response = await http.post(host + '/echo', body: msg);

  if (response.statusCode == 200) {

    Map<String, dynamic> msgJson = json.decode(response.body);
    var message = Message.fromMap(msgJson);

    return message;
  } else {
    return null;
  }
}

  Future<List<BannerBean>> getHistoryList() async {

    try {
      final response = await http.get(host + '/history');

      if (response.statusCode == 200) {
        return _decodeHistory(response.body);
      }
    } catch (e) {
      print('getHistoryList exception $e');
    }
    return null;
  }

  List<BannerBean> _decodeHistory(String response) {
    // JSON 数组 decode 出来是一个 <Map<String, dynamic>>[]
    var messages = json.decode(response);

    var list = <Message>[];

    for (var message in messages) {

      list.add(Message.fromMap(message));
    }
    return list;
  }

}
