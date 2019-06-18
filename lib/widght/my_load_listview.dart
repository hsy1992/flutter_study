import 'package:flutter/material.dart';

class MyLoadListView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _MyListState();
  }

}


class _MyListState extends State<MyLoadListView> {

  List<int> _data = List.generate(15, (i) => i);

  ScrollController _scrollController = ScrollController();

  bool isPerformingRequest = false; // 是否有请求正在进行

  _MyListState();

  @override
  void initState() {
    print('插入渲染时调用');
    super.initState();
    _scrollController.addListener((){
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });

  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print('依赖对象发生变化时调用');
  }

  @override
  void didUpdateWidget(MyLoadListView oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print('组件状态改变');
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print('移除渲染');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('销毁调用');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Infinite ListView'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {

          if(_data.length == index) {

            return _buildProgressIndicator();

          } else {

            return ListTile(
              title: Text('这是第 $index 个item'),
            );
          }

        },
        itemCount: _data.length + 1,
        controller: _scrollController,
      ),
    );
  }

  //获取更多数据
  void _getMoreData() async {
    if (!isPerformingRequest) {
      //没有请求的时候 设置为正在请求
      setState(() {
        isPerformingRequest = true;
      });

      List<int> newEntries = await fakeRequest(_data.length, _data.length + 15);

      //没有数据时动画
      if (newEntries.isEmpty) {
        double edge = 50.0;
        double offsetFromBottom = _scrollController.position.maxScrollExtent - _scrollController.position.pixels;

        print(_scrollController.offset.toString() + '>>>>>' + offsetFromBottom.toString());
        if(offsetFromBottom < edge) {
          _scrollController.animateTo(
              _scrollController.offset - (edge - offsetFromBottom),
              duration: Duration(milliseconds: 500),
              curve: Curves.easeOut);
        }
      }

      setState(() {
        _data.addAll(newEntries);
        isPerformingRequest = false;
      });

    }
  }

  //加入等待窗口
  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: new Opacity(
          opacity: isPerformingRequest ? 1.0 : 0.0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }
}

//模拟请求
Future<List<int>> fakeRequest(int from, int to) async {
  return Future.delayed(Duration(
      seconds: 2
  ), () {
    return [];
  });
}
