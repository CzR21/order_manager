import 'package:flutter/widgets.dart';

class AppTappable extends StatefulWidget {

  final VoidCallback onTap;
  final VoidCallback? onDoubleTap;
  final MouseCursor cursor;
  final Widget child;
  final Color? hoverColor;
  final bool hasBorder;

  const AppTappable({
    super.key,
    required this.onTap,
    this.onDoubleTap,
    this.cursor = SystemMouseCursors.click,
    required this.child,
    this.hoverColor,
    this.hasBorder = false,
  });

  @override
  State<AppTappable> createState() => _AppTappableState();
}

class _AppTappableState extends State<AppTappable> {

  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.cursor,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        onDoubleTap: widget.onDoubleTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: widget.hasBorder
                ? const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10))
                : null,
            color: _isHovered ? widget.hoverColor : null,
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
