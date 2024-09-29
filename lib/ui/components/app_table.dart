import 'package:adaptivex/adaptivex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:order_manager/data/models/components/table_model.dart';
import 'package:order_manager/settings/app_assets.dart';
import 'package:order_manager/ui/components/app_tappable.dart';
import '../../settings/app_colors.dart';
import '../../settings/app_fonts.dart';

class AppTable extends StatefulWidget {

  final List<TableModel> headers;
  final List<Map<String, dynamic>>? source;
  final Map<String, dynamic>? selected;
  final Widget? title;
  final List<Widget>? actions;
  final List<Widget>? footers;
  final Function(Map<String, dynamic> value)? onTabRow;
  final Function(Map<String, dynamic> value)? onDoubleTabRow;
  final Function(dynamic value)? onSort;
  final String? sortColumn;
  final bool? sortAscending;
  final bool isLoading;
  final bool autoHeight;
  final bool hideUnderline;
  final bool commonMobileView;
  final bool isExpandRows;
  final double maxHeight;
  final List<ScreenSize> responseScreenSizes;
  final BoxDecoration? headerDecoration;
  final BoxDecoration? rowDecoration;
  final TextStyle? headerTextStyle;
  final TextStyle? rowTextStyle;

  const AppTable({
    super.key,
    this.onTabRow,
    this.onDoubleTabRow,
    this.onSort,
    this.headers = const [],
    this.source,
    this.selected,
    this.title,
    this.actions,
    this.footers,
    this.sortColumn,
    this.sortAscending,
    this.maxHeight = 500,
    this.isLoading = false,
    this.autoHeight = true,
    this.hideUnderline = true,
    this.commonMobileView = false,
    this.isExpandRows = true,
    this.responseScreenSizes = const [
      ScreenSize.xs,
      ScreenSize.sm,
      ScreenSize.md
    ],
    this.headerDecoration,
    this.rowDecoration,
    this.headerTextStyle,
    this.rowTextStyle,
  });

  @override
  State<AppTable> createState() => _AppTableState();
}

class _AppTableState extends State<AppTable> {

  static Alignment headerAlignSwitch(TextAlign? textAlign) {
    switch (textAlign) {
      case TextAlign.center:
        return Alignment.center;
      case TextAlign.left:
        return Alignment.centerLeft;
      case TextAlign.right:
        return Alignment.centerRight;
      default:
        return Alignment.center;
    }
  }

  Widget mobileHeader() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      PopupMenuButton(
          tooltip: "SORT BY",
          initialValue: widget.sortColumn,
          itemBuilder: (_) => widget.headers
              .where((header) => header.show == true && header.sortable == true)
              .toList()
              .map((header) => PopupMenuItem(
            value: header.value,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(header.text, textAlign: header.textAlign,),
                if (widget.sortColumn != null && widget.sortColumn == header.value)
                  widget.sortAscending!
                      ? SvgPicture.asset(AppAssets.arrowDownIcon, width: 15, height: 15,)
                      : SvgPicture.asset(AppAssets.arrowUpIcon, width: 15, height: 15,)
              ],
            ),
          )
          ).toList(),
          onSelected: (dynamic value) {
            if (widget.onSort != null) widget.onSort!(value);
          },
          child: Container(
            padding: const EdgeInsets.all(15),
            child: const Text("SORT BY"),
          )
      ),
    ],
  );

  List<Widget> mobileList() => widget.source!.map((data) {
    return InkWell(
      onTap: () => widget.onTabRow?.call(data),
      child: Container(
        decoration: widget.rowDecoration ?? const BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.greyColor, width: 0.5))
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!widget.commonMobileView)
              ...widget.headers
                  .where((header) => header.show == true)
                  .toList()
                  .map((header) => Container(
                padding: const EdgeInsets.all(11),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    header.headerBuilder != null
                        ? header.headerBuilder!(header.value)
                        : Text(header.text, overflow: TextOverflow.clip, style: widget.rowTextStyle),
                    const Spacer(),
                    header.sourceBuilder != null
                        ? header.sourceBuilder!(data[header.value], data)
                        : Text("${data[header.value]}", style: widget.rowTextStyle,)
                  ],
                ),
              ),
              )
          ],
        ),
      ),
    );
  }).toList();

  Widget desktopHeader() => Container(
    decoration: widget.headerDecoration ??
      const BoxDecoration(
        color: AppColors.blueDefaultColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
      ),
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...widget.headers
            .where((header) => header.show == true)
            .map((header) => Expanded(
          flex: header.flex,
          child: InkWell(
            onTap: () {
              if (widget.onSort != null && header.sortable) widget.onSort!(header.value);
            },
            child: header.headerBuilder != null
                ? header.headerBuilder!(header.value)
                : Container(
              alignment: headerAlignSwitch(header.textAlign),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(header.text, textAlign: header.textAlign, style: widget.headerTextStyle ?? AppFonts.bodyBoldDefault.copyWith(color: AppColors.whiteColor),),

                  if (widget.sortColumn != null && widget.sortColumn == header.value)
                    widget.sortAscending!
                      ? SvgPicture.asset(AppAssets.arrowDownIcon, width: 15, height: 15,)
                      : SvgPicture.asset(AppAssets.arrowUpIcon, width: 15, height: 15,)
                ],
              ),
            ),
          ),
        ),
        ),
      ],
    ),
  );

  List<Widget> desktopList() => widget.source?.map((data) => Column(
    children: [
      AppTappable(
        hasBorder: widget.source?.last == data,
        hoverColor: AppColors.blueDefaultColor.withOpacity(0.5),
        onTap: () => widget.onTabRow?.call(data),
        onDoubleTap: () => widget.onDoubleTabRow?.call(data),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: widget.rowDecoration ?? BoxDecoration(
            color: widget.selected != null && widget.selected?['number'] == data['number'] ? AppColors.blueDefaultColor.withOpacity(0.3) : null,
            border: widget.source?.last == data ? null : const Border(bottom: BorderSide(color: AppColors.greyColor, width: 0.5))
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...widget.headers
                  .where((header) => header.show == true)
                  .map((header) => Expanded(
                flex: header.flex,
                child: header.sourceBuilder != null
                    ? header.sourceBuilder!(data[header.value], data)
                    : Text("${data[header.value]}", textAlign: header.textAlign, style: widget.rowTextStyle ?? AppFonts.bodyRegularSmall.copyWith(color: AppColors.blackColor),),
              ),
              ),
            ],
          ),
        ),
      ),
    ],
  )).toList() ?? [];

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.whiteColor,
      elevation: 1,
      shadowColor: Colors.black,
      clipBehavior: Clip.none,
      child: Container(
      constraints: BoxConstraints(
          maxHeight: widget.maxHeight,
        ),
        child: SingleChildScrollView(
          child: widget.responseScreenSizes.isNotEmpty && widget.responseScreenSizes.contains(context.screenSize)
              ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (widget.title != null || widget.actions != null)
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey[300]!))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (widget.title != null) widget.title!,
                      if (widget.actions != null) ...widget.actions!
                    ],
                  ),
                ),
              if (widget.autoHeight)
                Column(
                  children: [
                    if (widget.isLoading) const LinearProgressIndicator(),
                    ...mobileList(),
                  ],
                ),
              if (!widget.autoHeight)
                Expanded(
                  child: ListView(
                    children: [
                      if (widget.isLoading) const LinearProgressIndicator(),
                      ...mobileList(),
                    ],
                  ),
                ),
              if (widget.footers != null)
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [...widget.footers!],
                )
            ],
          )
              : Column(
            children: [
              if (widget.title != null || widget.actions != null)
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: AppColors.greyColor, width: 0.5))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (widget.title != null) widget.title!,
                      if (widget.actions != null) ...widget.actions!
                    ],
                  ),
                ),

              if (widget.headers.isNotEmpty) desktopHeader(),

              if (widget.isLoading) const LinearProgressIndicator(),

              if (widget.autoHeight) Column(children: desktopList()),

              if (!widget.autoHeight)
                if (widget.source != null && widget.source!.isNotEmpty)
                  Expanded(child: ListView(children: desktopList())),

              if (widget.footers != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [...widget.footers!],
                )
            ],
          ),
        ),
      ),
    );
  }
}