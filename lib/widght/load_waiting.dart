import 'package:flutter/material.dart';
//加入等待窗口
Widget buildProgressIndicator(isPerformingRequest) {
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