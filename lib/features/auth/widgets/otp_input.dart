import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:iron_track/core/constants/colors_manager.dart';
import 'package:iron_track/core/theme/theme_context.dart';

/// One-time-code input for verification and OTP screens.
class OtpInput extends StatefulWidget {
  const OtpInput({
    super.key,
    required this.controller,
    this.length = 5,
    this.hasError = false,
    this.autofocus = false,
    this.onChanged,
    this.onCompleted,
  });

  final TextEditingController controller;
  final int length;
  final bool hasError;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  final _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_rebuild);
    _focus.addListener(_rebuild);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_rebuild);
    _focus.dispose();
    super.dispose();
  }

  void _rebuild() {
    if (mounted) setState(() {});
  }

  void _handleChanged(String value) {
    widget.onChanged?.call(value);
    if (value.length == widget.length) widget.onCompleted?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    final text = widget.controller.text;
    final focused = _focus.hasFocus;

    return Semantics(
      label: 'Verification code, ${widget.length} digits',
      textField: true,
      child: Stack(
        children: [
          Row(
            children: [
              for (var i = 0; i < widget.length; i++) ...[
                if (i > 0) const Gap(10),
                Expanded(
                  child: _OtpBox(
                    char: i < text.length ? text[i] : '',
                    active: focused &&
                        (i == text.length ||
                            (text.length == widget.length &&
                                i == widget.length - 1)),
                    hasError: widget.hasError,
                  ),
                ),
              ],
            ],
          ),
          Positioned.fill(
            child: Opacity(
              opacity: 0,
              child: TextField(
                controller: widget.controller,
                focusNode: _focus,
                autofocus: widget.autofocus,
                keyboardType: TextInputType.number,
                autofillHints: const [AutofillHints.oneTimeCode],
                autocorrect: false,
                enableSuggestions: false,
                showCursor: false,
                maxLines: null,
                expands: true,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(widget.length),
                ],
                onChanged: _handleChanged,
                onTap: () => widget.controller.selection =
                    TextSelection.collapsed(
                  offset: widget.controller.text.length,
                ),
                style: const TextStyle(color: Colors.transparent),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  filled: false,
                  isCollapsed: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OtpBox extends StatelessWidget {
  const _OtpBox({
    required this.char,
    required this.active,
    required this.hasError,
  });

  final String char;
  final bool active;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    final glass = context.glass;
    final borderColor = hasError
        ? AppColor.danger
        : active
            ? AppColor.primary
            : glass.mutedBorder;

    return AspectRatio(
      aspectRatio: 0.85,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: glass.mutedBorder.withValues(alpha: 0.35),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: borderColor,
            width: active || hasError ? 1.8 : 1.2,
          ),
          boxShadow: active
              ? [
                  BoxShadow(
                    color: AppColor.primary.withValues(alpha: 0.25),
                    blurRadius: 12,
                  ),
                ]
              : null,
        ),
        child: Text(
          char,
          style: context.text.appBar.copyWith(color: glass.textPrimary),
        ),
      ),
    );
  }
}
