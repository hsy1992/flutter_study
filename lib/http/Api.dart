import 'package:flutter_study/http/HttpRequest.dart';
import 'package:flutter_study/constant/Constant.dart';
import 'package:flutter_study/model/BannerBean.dart';

///http请求类

// http.post 用来执行一个 HTTP POST 请求。   
//  // 它的 body 参数是一个 dynamic，可以支持不同类型的 body，这里我们    
//  只是直接把客户输入的消息发给服务端就可以了。由于 msg 是一个 String，    
//  post 方法会自动设置 HTTP 的 Content-Type 为 text/plain

class Api {

  static Api api;

  static Api getApi() {

    if (api == null) {
      api = Api();
    }

    return api;
  }

  ///获取首页banner
  Future<List<BannerBean>> getBannerData() async {

    Map<String, dynamic> dataMap = await HttpRequest.getRequest().httpGet(homeBannerUrl);

    if (dataMap != null) {

      if (dataMap['list'] != null) {

        return (dataMap['list'] as List).map((bean) => BannerBean.fromMap(bean)).toList();
      }

      return dataMap['data'];
    }

    return null;
  }


}



