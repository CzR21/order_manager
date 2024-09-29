import 'package:flutter/material.dart';
import 'package:order_manager/settings/app_assets.dart';
import '../../components/app_scaffold.dart';

class HomePage extends StatefulWidget {
  
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Home",
      body: Center(
        child: Image.asset(AppAssets.logoImage, )
      ),
    );
  }
}