import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../data/models/components/dropdown_model.dart';
import '../../settings/app_assets.dart';
import '../../settings/app_colors.dart';
import '../../settings/app_fonts.dart';

class AppDropdownController {

  final bool isRequired;
  late final FocusNode _focusNode;
  DropdownModel? _selectedValue;
  late bool _hasError;
  final void Function(DropdownModel? value)? onValueSelected;
  void Function()? onValueSelectedSetState;
  final List<DropdownModel> items;

  AppDropdownController({
    this.onValueSelected,
    this.isRequired = true,
    required this.items,
    DropdownModel? initialValue,
    bool initialValueFromList = false,
  }) {
    _focusNode = FocusNode();
    _hasError = false;
    _selectedValue = initialValueFromList ? items.first : initialValue;
  }

  FocusNode get focusNode => _focusNode;

  bool get hasError => _hasError;

  DropdownModel? get selectedValue => _selectedValue;

  set selectedValue(DropdownModel? value) {
    _selectedValue = value;
    onValueSelected?.call(value);
    onValueSelectedSetState?.call();
  }

  set selectedValueNoSetState(DropdownModel? value) => _selectedValue = value;

  void validate() {
    if (isRequired && selectedValue == null) {
      _hasError = true;
    } else {
      _hasError = false;
    }
  }
}

class AppDropdown extends StatefulWidget {

  final String? label;
  final String? hint;
  final AppDropdownController controller;
  final double? width;
  final Color borderColor;
  final Color contentColor;
  final Color backgroundColor;
  final bool isDisabled;

  const AppDropdown({
    super.key,
    required this.controller,
    this.label,
    this.hint,
    this.width,
    this.borderColor = AppColors.greyColor,
    this.contentColor = AppColors.blackColor,
    this.backgroundColor = AppColors.whiteColor,
    this.isDisabled = false,
  });

  @override
  State<AppDropdown> createState() => _AppDropdownState();
}

class _AppDropdownState extends State<AppDropdown> {

  @override
  void initState() {
    widget.controller.onValueSelectedSetState = () => setState(() {});
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.zero,
      gapPadding: 0,
    );

    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        decoration: BoxDecoration(
          color: widget.isDisabled ? AppColors.greyColor : null,
          borderRadius: BorderRadius.circular(10)
        ),
        width: widget.width ?? constraints.maxWidth,
        child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField2<DropdownModel>(
            decoration: InputDecoration(
              isCollapsed: true,
              suffixIconConstraints: const BoxConstraints(maxHeight: 24),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: widget.controller.hasError ? AppColors.semanticRedColor : widget.borderColor),
              ),
              errorBorder: border,
              focusedErrorBorder: border,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: widget.controller.hasError ? AppColors.semanticRedColor : widget.borderColor),
                borderRadius: BorderRadius.circular(10),
                gapPadding: 0,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: widget.controller.hasError ? AppColors.semanticRedColor : widget.borderColor),
                borderRadius: BorderRadius.circular(10),
                gapPadding: 0,
              ),
              contentPadding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
            ),
            focusNode: widget.controller.focusNode,
            isExpanded: true,
            menuItemStyleData: MenuItemStyleData(
              height: 36,
              overlayColor: WidgetStatePropertyAll(AppColors.blueDefaultColor.withOpacity(0.2),),
            ),
            iconStyleData: IconStyleData(
              icon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: widget.controller.selectedValue != null ? 10 : 0,),
                  SvgPicture.asset(
                    AppAssets.arrowDownIcon,
                    color: widget.contentColor,
                  )
                ],
              ),
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 200,
              elevation: 100,
              width: widget.width ?? constraints.maxWidth,
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.greyColor,
                ),
              ),
            ),
            hint: widget.hint != null
            ? Text(
              widget.controller.selectedValue == null ? widget.hint : widget.controller.selectedValue!.key,
              style: AppFonts.bodyRegularDefault.copyWith(
                color: widget.controller.selectedValue == null ? widget.contentColor : AppColors.blackColor,
                overflow: TextOverflow.ellipsis,
              ),
            ) : const SizedBox(),
            items: widget.controller.items.map((e) => DropdownMenuItem<DropdownModel>(
              value: e,
              child: Text(e.key, style: AppFonts.bodyRegularDefault.copyWith(color: widget.contentColor,), overflow: TextOverflow.ellipsis,),
            )).toList(),
            value: widget.controller.selectedValue == null ? null : widget.controller.items.firstWhere((e) => e.key == widget.controller.selectedValue!.key),
            onChanged: widget.isDisabled ? null : (value) => widget.controller.selectedValue = value,
          ),
        ),
      );
    });
  }
}