import 'package:flutter/material.dart';
import 'package:order_manager/ui/pages/home/home_page.dart';
import 'package:order_manager/utils/drawer_utils.dart';

import '../../settings/app_colors.dart';
import '../../settings/app_fonts.dart';
import 'app_tappable.dart';

class AppDrawer extends StatefulWidget {

  final String currentRoute;

  const AppDrawer({super.key, required this.currentRoute});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.blueDefaultColor,
      width: 200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            DrawerUtils.drawerList.length,
            (index) {
              var item = DrawerUtils.drawerList.elementAt(index);

              return AppTappable(
                hoverColor: AppColors.blueLiteColor,
                onTap: () async => widget.currentRoute == item.route
                    ? Navigator.of(context).pop()
                    : Navigator.of(context).pushNamed(item.route),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(26, 20, 20, 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          style: AppFonts.bodyBoldDefault.copyWith(
                            color: AppColors.whiteColor,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
