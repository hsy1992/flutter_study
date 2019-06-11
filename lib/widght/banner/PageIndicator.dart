import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
///指示器

///绘制基类
abstract class BasePainter extends CustomPainter {
  final PageIndicator widget;
  final double page;
  final int index;
  final Paint _paint;

  //进度
  double lerp(double begin, double end, double progress) {
    return begin + (end - end) * progress;
  }

  BasePainter(this.widget, this.page, this.index, this._paint);

  //绘制抽象方法
  void draw(Canvas canvas, double space, double size, double radius);

  //是否跳过
  bool _shouldSkip(int index) {
    return false;
  }

  @override
  void paint(Canvas canvas, Size size) {
    _paint.color = widget.normalColor;
    double space = widget.space;
    double size = widget.size;
    double radius = widget.size / 2;

    for (int i = 0, c = widget.counts; i < c; ++i) {

      if (_shouldSkip(i)) {
        continue;
      }

      canvas.drawCircle(new Offset(i * (size + space) + radius, radius), radius, _paint);
    }

    double page = this.page;
    if (page < index) {
      page = 0.0;
    }

    _paint.color = widget.selectColor;
    draw(canvas, space, size, radius);
  }

  @override
  bool shouldRepaint(BasePainter oldDelegate) {
    return oldDelegate.page != page;
  }


}
enum PageIndicatorLayout {
  NONE,
  SLIDE,
  WARM,
  COLOR,
  SCALE,
  DROP,
}
///指示器view
class PageIndicator extends StatefulWidget {

  //点的大小
  final double size;
  //点的间距
  final double space;
  //点的数量
  final int counts;
  //选中时颜色
  final Color selectColor;
  //常规颜色
  final Color normalColor;
  //点的 layout
  final PageIndicatorLayout layout;
  //SCALE 时使用
  final double scale;
  //DROP时使用
  final double dropHeight;
  //页面控制器
  final PageController controller;
  //选中的大小
  final double activeSize;

  PageIndicator({
   Key key,
   this.size: 20.0,
   this.space: 5.0,
   this.counts,
   this.activeSize: 20.0,
   this.controller,
   this.normalColor: Colors.white30,
   this.layout: PageIndicatorLayout.SLIDE,
   this.selectColor: Colors.white,
   this.scale: 0.6,
   this.dropHeight: 20.0
  }) : assert(counts != null),
  assert(controller != null),
  super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PageIndicatorState();
  }
}

class _PageIndicatorState extends State<PageIndicator> {

  int index = 0;
  Paint _paint = new Paint();


  @override
  Widget build(BuildContext context) {
    return null;
  }
}