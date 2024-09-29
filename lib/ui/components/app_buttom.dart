import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../settings/app_colors.dart';
import '../../settings/app_fonts.dart';

enum AppButtonType { filled, outlined }

enum AppButtonSize { large, medium, small }

class AppButton extends StatefulWidget {

  final VoidCallback onPressed;
  final AppButtonType type;
  final AppButtonSize size;
  final bool isExpanded;
  final bool isLoading;
  final String? iconAsset;
  final Widget? iconWidget;
  final String? label;
  final Color mainColor;

  const AppButton({
    super.key,
    required this.onPressed,
    this.type = AppButtonType.filled,
    this.size = AppButtonSize.medium,
    this.isExpanded = false,
    this.isLoading = false,
    this.iconAsset,
    this.iconWidget,
    this.label,
    this.mainColor = AppColors.blueDefaultColor,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {

  bool _isPressed = false;

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  double get height {
    switch (widget.size) {
      case AppButtonSize.large:
        return 50;
      case AppButtonSize.medium:
        return 40;
      case AppButtonSize.small:
        return 30;
    }
  }

  EdgeInsets get padding {
    if (widget.iconAsset != null) {
      return const EdgeInsets.only(left: 16, right: 24);
    } else {
      return EdgeInsets.symmetric(horizontal: 24, vertical: widget.type == AppButtonType.filled ? 18 : 0);
    }
  }

  TextStyle get style {
    switch (widget.size) {
      case AppButtonSize.large:
        return AppFonts.bodyRegularLarge.copyWith(
          color: widget.type == AppButtonType.filled ? AppColors.whiteColor : widget.mainColor,
        );
      case AppButtonSize.medium:
        return AppFonts.bodyRegularDefault.copyWith(
          color: widget.type == AppButtonType.filled ? AppColors.whiteColor : widget.mainColor,
        );
      case AppButtonSize.small:
        return AppFonts.bodyRegularSmall.copyWith(
          color: widget.type == AppButtonType.filled ? AppColors.whiteColor : widget.mainColor,
        );
    }
  }

  double get iconSize {
    switch (widget.size) {
      case AppButtonSize.large:
        return 20;
      case AppButtonSize.medium:
        return 16;
      case AppButtonSize.small:
        return 13;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: widget.type == AppButtonType.outlined ? Border.all(color: widget.mainColor, width: 1.5) : null,
      ),
      child: MaterialButton(
        onHighlightChanged: (value) {
          if (mounted) {
            setState(() => _isPressed = value);
          } else {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) => setState(() => _isPressed = value));
          }
        },
        onPressed: widget.isLoading ? () {} : widget.onPressed,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        disabledElevation: 0,
        minWidth: 0,
        padding: padding,
        height: height,
        color: widget.type == AppButtonType.filled ? widget.mainColor : Colors.transparent,
        focusColor: widget.type == AppButtonType.filled ? widget.mainColor : Colors.transparent,
        hoverColor: widget.type == AppButtonType.filled ? widget.mainColor : Colors.transparent,
        highlightColor: widget.type == AppButtonType.filled ? widget.mainColor : Colors.transparent,
        splashColor: widget.type == AppButtonType.filled ? widget.mainColor : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: widget.iconAsset != null && widget.label != null ? 8 : 0),
            widget.iconAsset != null
              ? SvgPicture.asset(
                widget.iconAsset!,
                clipBehavior: Clip.antiAlias,
                width: iconSize,
                height: iconSize,
                fit: BoxFit.scaleDown,
                colorFilter: ColorFilter.mode(
                  widget.type != AppButtonType.filled
                    ? !_isPressed
                    ? widget.mainColor
                    : widget.mainColor
                    : AppColors.whiteColor,
                  BlendMode.srcIn
                ),
              )
              : widget.iconWidget != null
              ? Padding(
                padding: const EdgeInsets.only(right: 8),
                child: widget.iconWidget!,
              )
              : const SizedBox(),
            SizedBox(width: widget.iconAsset != null && widget.label != null ? 8 : 0),
            widget.label != null
              ? Flexible(
                child: Text(
                  widget.label!,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: style,
                ),
              )
              : const SizedBox(),
            widget.isLoading
              ? Row(
                children: [
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 10,
                    height: 10,
                    child: CircularProgressIndicator(
                      color: style.color,
                      strokeWidth: 1.5,
                    ),
                  ),
                ],
              )
              : const SizedBox(),
            SizedBox(width: widget.iconAsset != null && widget.label != null ? 8 : 0),
          ],
        ),
      ),
    );
  }
}
