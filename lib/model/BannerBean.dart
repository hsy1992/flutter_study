

class BannerBean {

  final String desc;

  final int id;

  final String title;

  final String imagePath;

  final int isVisible;

  final int order;

  final int type;

  final String url;

  BannerBean({this.desc, this.id, this.title, this.imagePath, this.isVisible, this.order, this.type, this.url});

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
