import 'package:flutter/material.dart';

Image getImageAssets(path, {width = 20.0, height = 20.0}) {

  return Image.asset(path, width: width, height: height, fit: BoxFit.fill);
}

Image getImageNetwork(path, {width = 20.0, height = 20.0}) {

  return Image.network(path, width: width, height: height, fit: BoxFit.fill);
}

