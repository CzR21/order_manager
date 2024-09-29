import 'package:flutter/material.dart';

enum DeviceType { desktop, tablet, tabletLandscape, mobile }

Size deviceSize(BuildContext context) => MediaQuery.of(context).size;
double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;

Orientation deviceOrientation(BuildContext context) =>
    MediaQuery.of(context).orientation;

DeviceType deviceType(BuildContext context) {
  final width = deviceWidth(context);
  final height = deviceHeight(context);
  final orientation = deviceOrientation(context);

  if (width <= 640) {
    return DeviceType.mobile;
  } else if (width > 640 && width <= 1024) {
    return orientation == Orientation.landscape
        ? DeviceType.tabletLandscape
        : DeviceType.tablet;
  } else if (height < 700 && orientation == Orientation.landscape) {
    return DeviceType.tabletLandscape;
  } else {
    return DeviceType.desktop;
  }
}