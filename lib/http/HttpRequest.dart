import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_study/constant/Constant.dart';

class HttpRequest {

  static HttpRequest request;

  static HttpRequest getRequest() {

    if (request == null) {
      request = HttpRequest();
    }

    return request;
  }

  Future<Map<String, dynamic>> httpGet(String url, {Map<String, dynamic> parameters}) async {

    url = buildUrl(url, parameters);

    final response = await http.get(host + url);

    return _parseResponse(response);
  }

  Future<Map<String, dynamic>> httpPost(String url, {Map<String, dynamic> parameters}) async {

    final response = await http.post(host + url, body: parameters);

    return _parseResponse(response);
  }

  //返回转换
  Map<String, dynamic> _parseResponse(var response) {

    if (response.statusCode == 200) {

      Map<String, dynamic> dataJson = json.decode(response.body);

      int errorCode = dataJson['errorCode'];

      String errorMsg = dataJson['errorMsg'];

      if (errorCode == 0) {

        Map<String, dynamic> resultMap = {};



        if (dataJson['data'] is List) {

          resultMap['list'] = dataJson['data'];

        } else {

          resultMap['data'] = dataJson['data'];
        }

        return resultMap;

      } else {

        print('url>>>' + response.request.url + ' 报错  ' + errorMsg);
      }
    }

    return null;
  }

  //构建路径
  String buildUrl(String url, Map<String, dynamic> parameters) {

    if (parameters == null || parameters.isEmpty) {

      return url;
    } else {

      for (String key in parameters.keys) {

        if (!url.contains("?")) {

          url += "?" + key + "=" + parameters[key];
        } else {

          url += "&" + key + "=" + parameters[key];
        }
      }
    }

    return url;
  }
}