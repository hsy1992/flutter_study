import 'package:flutter_study/model/article_bean_entity.dart';
import 'package:flutter_study/model/user_bean_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "ArticleBeanEntity") {
      return ArticleBeanEntity.fromJson(json) as T;
    } else if (T.toString() == "UserBeanEntity") {
      return UserBeanEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}