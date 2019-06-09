class BaseBean<T> {

  int errorCode;

  String errorMsg;

  T data;

  //json序列化
  Map<String, dynamic> toJson() => {
    'errorCode': errorCode,
    'errorMsg': errorMsg,
    'data': data
  };

  BannerBean.fromMap(Map<String, dynamic> map) : errorCode = map['errorCode'], errorMsg = map['errorMsg'], data = map['data'];
}