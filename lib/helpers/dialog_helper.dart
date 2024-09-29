import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:order_manager/settings/app_assets.dart';
import 'package:order_manager/settings/app_colors.dart';
import 'package:order_manager/settings/app_fonts.dart';
import 'package:order_manager/ui/components/app_tappable.dart';

class DialogHelper{

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required Widget body,
    Function()? onClose,
    bool isScrollable = false,
    bool isExpanded = false,
    double? maxWidget
  }) async {
    final result = await showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: AppColors.whiteColor,
        child: LayoutBuilder(
          builder: (context, constrains) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: maxWidget ?? constrains.maxWidth*2/3,
                maxHeight: constrains.maxHeight/2
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: AppColors.blueDefaultColor,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10), )
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Text(title, style: AppFonts.title3.copyWith(color: AppColors.whiteColor),)
                        ),
                        AppTappable(
                          onTap: onClose ?? () => Navigator.of(context).pop(),
                          child: SvgPicture.asset(
                            AppAssets.closeIcon,
                            color: AppColors.whiteColor,
                          )
                        )
                      ],
                    ),
                  ),
                  body
                ],
              ),
            );
          }
        ),
      )
    );

    return result;
  }

}

