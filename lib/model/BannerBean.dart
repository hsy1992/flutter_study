import 'BaseBean.dart';

class BannerBean extends BaseBean<List<BannerBean>> {

  String desc;

  int id;

  String title;

  String imagePath;

  int isVisible;

  int order;

  int type;

  String url;

  @override
  String toString() {
    return 'BannerBean{desc : $desc, id: $id, title: $title, imagePath: $imagePath, isVisible: $isVisible,'
        ' order: $order, type: $type, url: $url}';
  }
  //json序列化
  Map<String, dynamic> toJson() => {
    'desc': desc,
    'id': id,
    'title': title,
    'imagePath': imagePath,
    'isVisible': isVisible,
    'order': order,
    'type': type,
    'url': url,
  };

  BannerBean.fromMap(Map<String, dynamic> map) : desc = map['desc'], id = map['id'], title = map['title'],
        imagePath = map['imagePath'], isVisible = map['isVisible'], order = map['order'],
        type = map['type'], url = map['url'];
}
