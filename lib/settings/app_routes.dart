import 'package:flutter/material.dart';
import 'package:order_manager/ui/pages/home/home_page.dart';
import 'package:order_manager/ui/pages/orders/order_page.dart';
import 'package:order_manager/ui/pages/reports/report_page.dart';

class AppRoutes {

  static final navigatorKey = GlobalKey<NavigatorState>();
  static final routeObserver = RouteObserver<ModalRoute>();

  static const String home = "/home";
  static const String order = "/order";
  static const String report = "/report";

  static final routeList = <String, Widget Function(BuildContext)>{
    home: (context) => const HomePage(),
    order: (context) => const OrderPage(),
    report: (context) => const ReportPage(),
  };
}