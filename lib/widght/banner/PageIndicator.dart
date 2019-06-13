import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
///指示器

class WarmPainter extends BasePainter {

  WarmPainter(PageIndicator widget, double page, int index, Paint paint)
    : super(widget, page, index, paint);

  @override
  void draw(Canvas canvas, double space, double size, double radius) {

    //进度
    double progress = page - index;
    //距离
    double distance = size + space;
    //开始绘制的地点
    double start = index * distance

    if (progress > 0.5) {

      //到右边的距离
      double right = start + size + distance;

      double left = start + distance * (progress - 0.5) * 2;

      canvas.drawRRect(
          new RRect.fromLTRBR(left, 0.0, right, size, new Radius.circular(radius)),
          _paint);
    } else {

      double right = start + size + distance * progress * 2;

      canvas.drawRRect(
          new RRect.fromLTRBR(start, 0.0, right, size, new Radius.circular(radius)),
          _paint);
    }
  }
}

class DropPainter extends BasePainter {

  DropPainter(PageIndicator widget, double page, int index, Paint paint)
      : super(widget, page, index, paint);

  @override
  void draw(Canvas canvas, double space, double size, double radius) {
    double progress = page - index;
    double dropHeight = widget.dropHeight;
    double rate = (0.5 - progress).abs() * 2;
    double scale = widget.scale;

    canvas.drawCircle(
        new Offset(radius + ((page) * (size + space)), radius - dropHeight * (1 - rate)),
        radius * (scale + rate * (1.0 - scale)),
        _paint);
  }
}

class NonePainter extends BasePainter {

  NonePainter(PageIndicator widget, double page, int index, Paint paint)
      : super(widget, page, index, paint);

  @override
  void draw(Canvas canvas, double space, double size, double radius) {
    double progress = page - index;
    double secondOffset = index == widget.counts - 1 ? radius : radius + ((index + 1) * (size + space));

    if (progress > 0.5) {
      canvas.drawCircle(new Offset(secondOffset, radius), radius, _paint);
    } else {
      canvas.drawCircle(new Offset(radius + (index * (size + space)), radius), radius, _paint);
    }
  }

}

class SlidePainter extends BasePainter {
  SlidePainter(PageIndicator widget, double page, int index, Paint paint)
      : super(widget, page, index, paint);

  @override
  void draw(Canvas canvas, double space, double size, double radius) {
    canvas.drawCircle(
        new Offset(radius + (page * (size + space)), radius), radius, _paint);
  }
}

class ScalePainter extends BasePainter {

  ScalePainter(
      PageIndicator widget, double page, int index, Paint paint)
      : super(widget, page, index, paint);


  // 连续的两个点，含有最后一个和第一个
  @override
  bool _shouldSkip(int i) {
    if(index == widget.counts - 1){
      return i == 0 || i == index;
    }
    return (i == index || i == index + 1);
  }

  @override
  void paint(Canvas canvas, Size size) {
    _paint.color = widget.normalColor;
    double space = widget.space;
    double size = widget.size;
    double radius = size / 2;
    for (int i = 0, c = widget.counts; i < c; ++i) {
      if (_shouldSkip(i)) {
        continue;
      }
      canvas.drawCircle(new Offset(i * (size + space) + radius, radius),
          radius * widget.scale, _paint);
    }


    _paint.color = widget.selectColor;
    draw(canvas, space, size, radius);
  }

  @override
  void draw(Canvas canvas, double space, double size, double radius) {

    double secondOffset = index == widget.counts-1 ? radius : radius + ((index + 1) * (size + space));

    double progress = page - index;
    _paint.color = Color.lerp(widget.selectColor, widget.normalColor, progress);
    //last
    canvas.drawCircle(new Offset(radius + (index * (size + space)), radius),
        lerp(radius, radius * widget.scale, progress), _paint);
    //first
    _paint.color = Color.lerp(widget.normalColor, widget.selectColor, progress);
    canvas.drawCircle(
        new Offset(secondOffset, radius),
        lerp(radius * widget.scale, radius, progress),
        _paint);

  }
}

class ColorPainter extends BasePainter {
  ColorPainter(PageIndicator widget, double page, int index, Paint paint)
      : super(widget, page, index, paint);

  // 连续的两个点，含有最后一个和第一个
  @override
  bool _shouldSkip(int i) {
    if(index == widget.counts - 1){
      return i==0 || i == index;
    }
    return (i == index || i == index + 1);
  }

  @override
  void draw(Canvas canvas, double space, double size, double radius) {
    double progress = page - index;
    double secondOffset = index == widget.counts - 1 ? radius : radius + ((index + 1) * (size + space));

    _paint.color = Color.lerp(widget.selectColor, widget.normalColor, progress);
    //left
    canvas.drawCircle(
        new Offset(radius + (index * (size + space)), radius), radius, _paint);
    //right
    _paint.color = Color.lerp(widget.normalColor, widget.selectColor, progress);
    canvas.drawCircle(
        new Offset(secondOffset, radius),
        radius,
        _paint);
  }
}

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

  BasePainter _createPainer() {
    switch (widget.layout) {
      case PageIndicatorLayout.NONE:
        return new NonePainter(
            widget, widget.controller.page ?? 0.0, index, _paint);
      case PageIndicatorLayout.SLIDE:
        return new SlidePainter(
            widget, widget.controller.page ?? 0.0, index, _paint);
      case PageIndicatorLayout.WARM:
        return new WarmPainter(
            widget, widget.controller.page ?? 0.0, index, _paint);
      case PageIndicatorLayout.COLOR:
        return new ColorPainter(
            widget, widget.controller.page ?? 0.0, index, _paint);
      case PageIndicatorLayout.SCALE:
        return new ScalePainter(
            widget, widget.controller.page ?? 0.0, index, _paint);
      case PageIndicatorLayout.DROP:
        return new DropPainter(
            widget, widget.controller.page ?? 0.0, index, _paint);
      default:
        throw new Exception("Not a valid layout");
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child = new SizedBox(
      width: widget.counts * widget.size + (widget.counts - 1) * widget.space,
      height: widget.size,
      child: new CustomPaint(
        painter: _createPainer(),
      ),
    );

    if (widget.layout == PageIndicatorLayout.SCALE ||
        widget.layout == PageIndicatorLayout.COLOR) {
      child = new ClipRect(
        child: child,
      );
    }

    return new IgnorePointer(
      child: child,
    );
  }

  void _onController() {
    double page = widget.controller.page ?? 0.0;
    index = page.floor();

    setState(() {

    });
  }

  @override
  void initState() {
    widget.controller.addListener(_onController);
    super.initState();
  }

  @override
  void didUpdateWidget(PageIndicator oldWidget) {
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(_onController);
      widget.controller.addListener(_onController);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onController);
    super.dispose();
  }
}