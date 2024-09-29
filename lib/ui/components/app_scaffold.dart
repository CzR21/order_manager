import 'package:flutter/material.dart';
import 'package:order_manager/settings/app_colors.dart';
import 'package:order_manager/settings/app_fonts.dart';
import 'package:order_manager/ui/components/app_drawer.dart';

class AppScaffold extends StatefulWidget {

  final String title;
  final Widget body;

  const AppScaffold({
    super.key, 
    required this.title,
    required this.body
  });

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyColor,
      appBar: AppBar(
        backgroundColor: AppColors.blueDefaultColor,
        title: Text(widget.title, style: AppFonts.title3.copyWith(
          color: AppColors.whiteColor
        ),),
        iconTheme: const IconThemeData(
          color: AppColors.whiteColor
        ),
      ),
      drawer: AppDrawer(currentRoute: ModalRoute.of(context)?.settings.name ?? "",),
      body: Container(
        padding: const EdgeInsets.all(20),
        color: AppColors.whiteColor,
        child: widget.body
      ),
    );
  }
}