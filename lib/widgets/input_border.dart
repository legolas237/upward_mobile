import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:upward_mobile/config/config.dart';
import 'package:upward_mobile/theme/palette.dart';
import 'package:upward_mobile/theme/theme_provider.dart';

class StaterController extends ValueNotifier<bool> {
  StaterController() : super(false);

  void changeFocus(bool focus) => value = focus;

  void clear() => value = false;
}

// ignore: must_be_immutable
class InputBorderWidget extends StatefulWidget {
  InputBorderWidget({
    super.key,
    required this.placeHolder,
    this.obscureText = false,
    this.suffixIcon,
    this.controller,
    this.enabled = true,
    this.onChanged,
    this.keyboardType,
    this.label,
    this.suffix,
    this.minLines = 1,
    this.fontSize,
    this.inputFormatters = const [],
  });
  
  late Palette palette;

  final bool enabled;
  final String placeHolder;
  final String? label;
  final bool obscureText;
  final int minLines;
  final String? suffix;
  final double? fontSize;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final Function(String)? onChanged;

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<InputBorderWidget> {
  late FocusNode _focusNode;
  late StaterController _stateController;

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();
    _stateController = StaterController();
    _focusNode.addListener(() {
      _stateController.changeFocus(_focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Theme palette
    widget.palette = ThemeProvider.of(context)!.theme.palette;

    return ValueListenableBuilder(
      valueListenable: _stateController,
      builder: (context, bool hasFocus, child){
        final borderWidth = hasFocus ? 1.6 : 1.0;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(StringUtils.isNotNullOrEmpty(widget.label)) ... [
              Text(
                widget.label!,
                style: Theme.of(context).textTheme.bodyMedium!,
              ),
              const SizedBox(height: 8.0),
            ],
            TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              enableSuggestions: false,
              obscureText: widget.obscureText,
              enabled: widget.enabled,
              onChanged: widget.onChanged,
              keyboardType: widget.keyboardType,
              inputFormatters: widget.inputFormatters,
              minLines: widget.minLines,
              maxLines: widget.obscureText ? 1 : 6,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: widget.enabled ? widget.palette.textColor(1.0) : widget.palette.captionColor(1.0),
                fontSize: widget.fontSize ?? 16.0,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                labelText: widget.placeHolder,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 16.0,
                ),
                floatingLabelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: hasFocus ? widget.palette.textColor(1.0) : widget.palette.hintColor(1.0),
                  fontSize: hasFocus ? 18.0 : 16.0,
                  fontWeight: FontWeight.w600,
                ),
                labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: widget.palette.hintColor(1.0),
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
                hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: widget.palette.hintColor(1.0),
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
                fillColor: widget.enabled ? widget.palette.inputFillColor(1.0) : widget.palette.disableInputColor(1.0),
                filled: true,
                suffix: StringUtils.isNotNullOrEmpty(widget.suffix) ? Text(
                  widget.suffix!,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: widget.palette.textColor(1.0),
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                  ),
                ) : null,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.palette.inputBorderColor(1.0) ,
                    width: borderWidth,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(Constants.buttonRadius),
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.palette.inputBorderColor(0.6) ,
                    width: borderWidth,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(Constants.buttonRadius),
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.palette.inputBorderColor(1.0) ,
                    width: borderWidth,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(Constants.buttonRadius),
                  ),
                ), // Applies the
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.palette.primaryColor(1.0) ,
                    width: borderWidth,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(Constants.buttonRadius),
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.error,
                    width: borderWidth,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(Constants.buttonRadius),
                  ),
                ),
                suffixIcon: widget.suffixIcon,
              ),
            ),
          ],
        );
      },
    );
  }
}
