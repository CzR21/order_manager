import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:order_manager/settings/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.home,
      routes: AppRoutes.routeList,
      navigatorKey: AppRoutes.navigatorKey,
      navigatorObservers: [AppRoutes.routeObserver],
    );
  }
}