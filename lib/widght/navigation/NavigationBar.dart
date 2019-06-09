import 'package:flutter/material.dart';

///底部导航构建
class NavigationBarBuilder {

  Color _defaultTextColor = Colors.blueGrey;
  Color _selectTextColor = Colors.blue;

  var _tabText = [];
  var _tabImages = [];
  var _bodys = [];

  OnSearchClickListener _listener;

  NavigationBarBuilder setDefaultTextColor(Color defaultColor) {
    this._defaultTextColor = defaultColor;
    return this;
  }

  NavigationBarBuilder setSelectTextColor(Color selectTextColor) {
    this._selectTextColor = selectTextColor;
    return this;
  }

  NavigationBarBuilder setOnSearchListener(OnSearchClickListener listener) {
    this._listener = listener;
    return this;
  }

  NavigationBarBuilder addNavigationTab(String tabText, Image defaultImage, Image selectImage, Widget page) {
    _tabText.add(tabText);
    _tabImages.add([defaultImage, selectImage]);
    _bodys.add(page);
    return this;
  }

  StatefulWidget build() {
    return _NavigationView(this);
  }
}

class _NavigationView extends StatefulWidget {

  final NavigationBarBuilder builder;

  _NavigationView(this.builder);

  @override
  State<StatefulWidget> createState() {
    return _NavigationViewState(builder);
  }
}

class _NavigationViewState extends State<_NavigationView> {

  final NavigationBarBuilder builder;

  _NavigationViewState(this.builder);

  var _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            builder._tabText[_tabIndex]
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), iconSize: 30.0, onPressed: _onPressed),
        ],
      ),
      body: builder._bodys[_tabIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: getNavigationBarItem(),
        type: BottomNavigationBarType.fixed,
        currentIndex: _tabIndex,
        onTap: (index) {
          setState(() {
            _tabIndex = index;
          });
        },
      ),
    );
  }

  ///获取导航item
  List<BottomNavigationBarItem> getNavigationBarItem() {

    List<BottomNavigationBarItem> items = [];

    for (var index = 0; index < builder._tabText.length; index ++) {

      var isSelect = _tabIndex == index;
      items.add(
          BottomNavigationBarItem(
              icon: isSelect ? builder._tabImages[index][1] : builder._tabImages[index][0],
              title: Text(builder._tabText[index], style: TextStyle(fontSize: 14.0, color: !isSelect ? builder._defaultTextColor : builder._selectTextColor),)
          )
      );
    }

    return items;
  }

  void _onPressed() {
    if (builder._listener != null) {
      builder._listener.onSearchClick();
    }
  }
}

abstract class OnSearchClickListener {
  void onSearchClick();
}



