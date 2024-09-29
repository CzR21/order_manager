import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../settings/app_colors.dart';
import '../../settings/app_fonts.dart';

class AppTextFieldController {
  late bool _isRequired;
  final bool Function(String val)? validator;
  late final FocusNode _focusNode;
  late final TextEditingController _textEditingController;
  void Function()? onValueChangedSetState;
  late bool _hasError;
  late bool _isDisposed;

  AppTextFieldController({
    bool isRequired = true,
    this.validator,
    String? initialValue,
  }) {
    _focusNode = FocusNode();
    _isRequired = isRequired;
    _textEditingController = TextEditingController(text: initialValue);
    _hasError = false;
    _isDisposed = false;
  }

  FocusNode get focusNode => _focusNode;

  bool get isRequired => _isRequired;

  set isRequired(bool val) {
    _isRequired = val;
    _hasError = false;
    onValueChangedSetState?.call();
  }

  TextEditingController get textEditingController => _textEditingController;

  bool get hasError => _hasError;

  set hasError(bool value) {
    _hasError = value;
  }

  void validate() {
    if (!_isDisposed) {
      if (isRequired && _textEditingController.text.isEmpty) {
        _hasError = true;
      } else {
        _hasError = !(validator?.call(_textEditingController.text) ?? true);
      }
    }
  }

  void dispose() {
    if (!_isDisposed) {
      _textEditingController.dispose();
      _isDisposed = true;
    }
  }
}

class AppTextField extends StatefulWidget {
  final AppTextFieldController controller;
  final String? label;
  final String? hint;
  final bool isReadOnly;
  final bool isTextArea;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function(String val)? onChanged;
  final void Function()? onEditingComplete;
  final void Function()? onFocusOut;
  final TextInputAction textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final TextCapitalization textCapitalization;
  final int? maxLength;
  final TextInputType keyboardType;
  final double? width;
  final String? toolTipText;

  const AppTextField({
    super.key,
    required this.controller,
    this.label,
    this.hint,
    this.isReadOnly = false,
    this.isTextArea = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.onEditingComplete,
    this.onFocusOut,
    this.textInputAction = TextInputAction.done,
    this.inputFormatters,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.none,
    this.maxLength,
    this.keyboardType = TextInputType.text,
    this.width,
    this.toolTipText,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  void initState() {
    widget.controller.onValueChangedSetState = () => setState(() {});
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.zero,
      gapPadding: 0,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label != null
            ? Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: RichText(
                text: TextSpan(
                  text: widget.label,
                  style: AppFonts.bodyRegularDefault.copyWith(fontSize: 14),
                  children: <TextSpan>[
                    widget.controller.isRequired
                        ? TextSpan(
                      text: " *",
                      style: AppFonts.bodyRegularDefault.copyWith(color: AppColors.semanticRedColor),
                    )
                        : const TextSpan()
                  ],
                ),
              ),
            ),
            if (widget.toolTipText != null)
              Tooltip(
                richMessage: WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 305),
                    child: Text(
                      widget.toolTipText!,
                      style: AppFonts.bodyRegularSmall.copyWith(color: AppColors.whiteColor),
                    ),
                  ),
                ),
                preferBelow: false,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: AppColors.greyColor, borderRadius: BorderRadius.circular(8)),
                child: SvgPicture.asset('AppAssets.helpIconPath'),
              )
          ],
        )
            : const SizedBox(),
        widget.label != null ? const SizedBox(height: 5) : const SizedBox(),
        SizedBox(
          width: widget.width,
          child: TextField(
            controller: widget.controller.textEditingController,
            onTapOutside: (_) {
              widget.controller.focusNode.unfocus();
            },
            focusNode: widget.controller.focusNode,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: widget.controller.hasError ? AppColors.semanticRedColor : AppColors.greyColor),
                borderRadius: BorderRadius.circular(10),
                gapPadding: 0,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: widget.controller.hasError ? AppColors.semanticRedColor : AppColors.greyColor),
                borderRadius: BorderRadius.circular(10),
                gapPadding: 0,
              ),
              errorBorder: border,
              focusedErrorBorder: border,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: widget.controller.hasError ? AppColors.semanticRedColor : AppColors.greyColor),
                borderRadius: BorderRadius.circular(10),
                gapPadding: 0,
              ),
              disabledBorder: border,
              contentPadding: widget.isTextArea
                  ? const EdgeInsets.only(
                left: 20,
                top: 12,
              )
                  : const EdgeInsets.only(left: 20, top: 14, bottom: 14),
              fillColor: widget.isReadOnly ? AppColors.greyColor : AppColors.whiteColor,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              iconColor: Colors.transparent,
              filled: true,
              isCollapsed: true,
              isDense: true,
              hintText: widget.hint,
              hintStyle: AppFonts.bodyRegularDefault.copyWith(color: widget.controller.hasError ? AppColors.semanticRedColor : AppColors.greyColor),
              prefixIcon: widget.prefixIcon != null
                  ? Padding(
                padding: const EdgeInsets.only(left: 23, right: 13),
                child: widget.prefixIcon,
              )
                  : null,
              prefixIconConstraints: BoxConstraints.loose(
                const Size(double.infinity, 24),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(left: 20, right: 16),
                child: widget.suffixIcon,
              ),
              suffixIconConstraints: BoxConstraints.loose(
                const Size(double.infinity, 24),
              ),
            ),
            onChanged: widget.onChanged,
            onEditingComplete: () {
              widget.controller.focusNode.unfocus();
              widget.onEditingComplete?.call();
            },
            readOnly: widget.isReadOnly,
            textInputAction: widget.textInputAction,
            inputFormatters: widget.inputFormatters,
            obscureText: widget.obscureText,
            textCapitalization: widget.textCapitalization,
            maxLength: widget.maxLength,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            buildCounter: (
                BuildContext context, {
                  required int currentLength,
                  required int? maxLength,
                  required bool isFocused,
                }) =>
            null,
            minLines: widget.isTextArea ? 6 : 1,
            maxLines: widget.isTextArea ? 6 : 1,
            keyboardType: widget.isTextArea ? TextInputType.multiline : widget.keyboardType,
            cursorRadius: const Radius.circular(99999),
            cursorWidth: 2,
            cursorColor: widget.controller.hasError
                ? AppColors.semanticRedColor
                : widget.controller.focusNode.hasFocus
                ? AppColors.blueDefaultColor
                : AppColors.blueDefaultColor,
            textAlignVertical: TextAlignVertical.center,
            style: AppFonts.bodyRegularDefault.copyWith(
              color: AppColors.blackColor,
            ),
          ),
        ),
      ],
    );
  }
}
