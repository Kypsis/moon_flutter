import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:moon_flutter/src/theme/colors.dart';
import 'package:moon_flutter/src/theme/opacity.dart';
import 'package:moon_flutter/src/theme/theme.dart';
import 'package:moon_flutter/src/utils/extensions.dart';
import 'package:moon_flutter/src/widgets/common/animated_icon_theme.dart';

typedef MoonTextAreaErrorBuilder = Widget Function(BuildContext context, String? errorText);

class MoonTextArea extends StatefulWidget {
  /// Used to set the auto validation mode.
  final AutovalidateMode autovalidateMode;

  /// {@macro flutter.widgets.editableText.autocorrect}
  final bool autocorrect;

  /// {@macro flutter.widgets.editableText.autofocus}
  final bool autofocus;

  /// If false the widget is "disabled": it ignores taps and has a reduced opacity.
  final bool enabled;

  /// {@macro flutter.services.TextInputConfiguration.enableIMEPersonalizedLearning}
  final bool enableIMEPersonalizedLearning;

  /// {@macro flutter.widgets.editableText.enableInteractiveSelection}
  final bool? enableInteractiveSelection;

  /// {@macro flutter.services.TextInputConfiguration.enableSuggestions}
  final bool enableSuggestions;

  /// {@macro flutter.widgets.editableText.scribbleEnabled}
  final bool scribbleEnabled;

  /// {@macro flutter.widgets.editableText.readOnly}
  final bool readOnly;

  /// {@macro flutter.widgets.editableText.showCursor}
  final bool? showCursor;

  /// The border radius of the text area.
  final BorderRadiusGeometry? borderRadius;

  /// The appearance of the keyboard.
  ///
  /// This setting is only honored on iOS devices.
  ///
  /// If unset, defaults to [ThemeData.brightness].
  final Brightness? keyboardAppearance;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.hardEdge].
  final Clip? clipBehavior;

  /// The background color of the text area.
  final Color? backgroundColor;

  /// The border color of the active or focused text area.
  final Color? activeBorderColor;

  /// The border color of the inactive text area.
  final Color? inactiveBorderColor;

  /// The border color of the error text area.
  final Color? errorBorderColor;

  /// The text color of the text area.
  final Color? textColor;

  /// The text color of the hint in text area.
  final Color? hintTextColor;

  /// The height of the text area (this does not include the space taken by [MoonTextArea.errorBuilder]).
  final double? height;

  /// The transition duration for disable animation.
  final Duration? transitionDuration;

  /// The transition curve for disable animation.
  final Curve? transitionCurve;

  /// {@macro flutter.widgets.editableText.scrollPadding}
  final EdgeInsets scrollPadding;

  /// The padding around the text content.
  final EdgeInsetsGeometry? textPadding;

  /// {@macro flutter.widgets.Focus.focusNode}.
  final FocusNode? focusNode;

  /// Validator for the text area widget.
  final FormFieldValidator<String>? validator;

  /// The maximum number of characters (Unicode grapheme clusters) to allow in the text area.
  ///
  /// {@macro flutter.services.lengthLimitingTextInputFormatter.maxLength}
  final int? maxLength;

  /// {@macro flutter.widgets.editableText.minLines}
  ///  * [expands], which determines whether the field should fill the height of its parent.
  final int? minLines;

  /// {@macro flutter.widgets.editableText.autofillHints}
  /// {@macro flutter.services.AutofillConfiguration.autofillHints}
  final Iterable<String>? autofillHints;

  /// {@macro flutter.widgets.editableText.inputFormatters}
  final List<TextInputFormatter>? inputFormatters;

  /// Determines how the [maxLength] limit should be enforced.
  ///
  /// {@macro flutter.services.textFormatter.effectiveMaxLengthEnforcement}
  ///
  /// {@macro flutter.services.textFormatter.maxLengthEnforcement}
  final MaxLengthEnforcement? maxLengthEnforcement;

  /// Builder for the error widget.
  final MoonTextAreaErrorBuilder? errorBuilder;

  /// {@macro flutter.widgets.editableText.scrollController}
  final ScrollController? scrollController;

  /// {@macro flutter.widgets.editableText.scrollPhysics}
  final ScrollPhysics? scrollPhysics;

  /// The text for the hint.
  final String? hintText;

  /// The initial value of the text area.
  final String? initialValue;

  /// {@template flutter.material.textfield.restorationId}
  /// Restoration ID to save and restore the state of the text field.
  ///
  /// See also:
  ///
  ///  * [RestorationManager], which explains how state restoration works in
  ///    Flutter.
  /// {@endtemplate}
  final String? restorationId;

  /// The semantic label for the widget.
  final String? semanticLabel;

  /// {@macro flutter.widgets.editableText.strutStyle}
  final StrutStyle? strutStyle;

  /// {@macro flutter.widgets.editableText.textAlign}
  final TextAlign textAlign;

  /// {@macro flutter.widgets.editableText.textDirection}
  final TextDirection? textDirection;

  /// {@macro flutter.widgets.editableText.textCapitalization}
  final TextCapitalization textCapitalization;

  /// Controls the text being edited.
  final TextEditingController? controller;

  /// The type of action button to use for the keyboard.
  ///
  /// Defaults to [TextInputAction.newline] if [keyboardType] is
  /// [TextInputType.multiline] and [TextInputAction.done] otherwise.
  final TextInputAction? textInputAction;

  /// The style to use for the text being edited.
  ///
  /// This text style is also used as the base style for the [decoration].
  final TextStyle? textStyle;

  /// The style to use for the error state text.
  final TextStyle? errorTextStyle;

  /// A callback that is called when the user taps the text area widget.
  final GestureTapCallback? onTap;

  /// A callback that is called when the user taps outside the text area widget.
  final TapRegionCallback? onTapOutside;

  /// {@macro flutter.widgets.editableText.onChanged}
  ///
  /// See also:
  ///
  ///  * [inputFormatters]: which are called before [onChanged] runs and can validate and change ("format") the input
  ///    value.
  ///  * [onEditingComplete], [onSubmitted]: which are more specialized input change notifications.
  final ValueChanged<String>? onChanged;

  /// {@macro flutter.widgets.editableText.onEditingComplete}
  final VoidCallback? onEditingComplete;

  /// [FormState.save].
  final void Function(String?)? onSaved;

  /// {@macro flutter.widgets.editableText.onSubmitted}
  ///
  /// See also:
  ///
  ///  * [TextInputAction.next] and [TextInputAction.previous], which automatically shift the focus to the next/previous
  ///    focusable item when the user is done editing.
  final ValueChanged<String>? onSubmitted;

  const MoonTextArea({
    super.key,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.autocorrect = true,
    this.autofocus = false,
    this.enabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.enableInteractiveSelection,
    this.enableSuggestions = true,
    this.scribbleEnabled = true,
    this.readOnly = false,
    this.showCursor,
    this.borderRadius,
    this.keyboardAppearance,
    this.clipBehavior,
    this.backgroundColor,
    this.activeBorderColor,
    this.inactiveBorderColor,
    this.errorBorderColor,
    this.textColor,
    this.hintTextColor,
    this.height,
    this.transitionDuration,
    this.transitionCurve,
    this.scrollPadding = const EdgeInsets.all(24.0),
    this.textPadding,
    this.focusNode,
    this.validator,
    this.maxLength,
    this.minLines,
    this.autofillHints,
    this.inputFormatters,
    this.maxLengthEnforcement,
    this.errorBuilder,
    this.scrollController,
    this.scrollPhysics,
    this.hintText,
    this.initialValue,
    this.restorationId,
    this.semanticLabel,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.textCapitalization = TextCapitalization.none,
    this.controller,
    this.textInputAction,
    this.textStyle,
    this.errorTextStyle,
    this.onTap,
    this.onTapOutside,
    this.onChanged,
    this.onEditingComplete,
    this.onSaved,
    this.onSubmitted,
  });

  @override
  State<MoonTextArea> createState() => _MoonTextAreaState();
}

class _MoonTextAreaState extends State<MoonTextArea> {
  String? _errorText;

  String? _validateInput(String? value) {
    final validationResult = widget.validator?.call(value);
    _errorText = validationResult;

    return validationResult;
  }

  Color _getTextColor(BuildContext context, {required Color effectiveBackgroundColor}) {
    final backgroundLuminance = effectiveBackgroundColor.computeLuminance();
    if (backgroundLuminance > 0.5) {
      return MoonColors.light.bulma;
    } else {
      return MoonColors.dark.bulma;
    }
  }

  @override
  Widget build(BuildContext context) {
    final BorderRadiusGeometry effectiveBorderRadius =
        widget.borderRadius ?? context.moonTheme?.textAreaTheme.properties.borderRadius ?? BorderRadius.circular(8);

    final Color effectiveBackgroundColor =
        widget.backgroundColor ?? context.moonTheme?.textAreaTheme.colors.backgroundColor ?? MoonColors.light.gohan;

    final Color effectiveActiveBorderColor = widget.activeBorderColor ??
        context.moonTheme?.textAreaTheme.colors.activeBorderColor ??
        MoonColors.light.piccolo;

    final Color effectiveInactiveBorderColor = widget.inactiveBorderColor ??
        context.moonTheme?.textAreaTheme.colors.inactiveBorderColor ??
        MoonColors.light.beerus;

    final Color effectiveErrorBorderColor = widget.errorBorderColor ??
        context.moonTheme?.textAreaTheme.colors.errorBorderColor ??
        MoonColors.light.chiChi100;

    final Color effectiveTextColor =
        widget.textColor ?? _getTextColor(context, effectiveBackgroundColor: effectiveBackgroundColor);

    final Color effectiveHintTextColor =
        widget.hintTextColor ?? context.moonTheme?.textAreaTheme.colors.hintTextColor ?? MoonColors.light.trunks;

    final double effectiveDisabledOpacityValue = context.moonTheme?.opacity.disabled ?? MoonOpacity.opacities.disabled;

    final Duration effectiveTransitionDuration = widget.transitionDuration ??
        context.moonTheme?.textAreaTheme.properties.transitionDuration ??
        const Duration(milliseconds: 200);

    final Curve effectiveTransitionCurve =
        widget.transitionCurve ?? context.moonTheme?.textAreaTheme.properties.transitionCurve ?? Curves.easeInOutCubic;

    final EdgeInsetsGeometry effectiveTextPadding =
        widget.textPadding ?? context.moonTheme?.textAreaTheme.properties.textPadding ?? const EdgeInsets.all(16);

    final TextStyle effectiveTextStyle =
        widget.textStyle ?? context.moonTheme?.textAreaTheme.properties.textStyle ?? const TextStyle(fontSize: 16);

    final TextStyle effectiveErrorTextStyle = widget.errorTextStyle ??
        context.moonTheme?.textAreaTheme.properties.errorTextStyle ??
        const TextStyle(fontSize: 12);

    final OutlineInputBorder defaultBorder = OutlineInputBorder(
      borderRadius: effectiveBorderRadius.smoothBorderRadius(context),
      borderSide: BorderSide(color: effectiveInactiveBorderColor),
    );

    return Semantics(
      label: widget.semanticLabel,
      child: RepaintBoundary(
        child: AnimatedOpacity(
          opacity: widget.enabled ? 1.0 : effectiveDisabledOpacityValue,
          curve: effectiveTransitionCurve,
          duration: effectiveTransitionDuration,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                autocorrect: widget.autocorrect,
                autofillHints: widget.autofillHints,
                autofocus: widget.autofocus,
                autovalidateMode: widget.autovalidateMode,
                controller: widget.controller,
                cursorColor: effectiveTextColor,
                enabled: widget.enabled,
                enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
                enableInteractiveSelection: widget.enableInteractiveSelection,
                enableSuggestions: widget.enableSuggestions,
                expands: true,
                focusNode: widget.focusNode,
                initialValue: widget.initialValue,
                inputFormatters: widget.inputFormatters,
                keyboardAppearance: widget.keyboardAppearance,
                keyboardType: TextInputType.multiline,
                maxLength: widget.maxLength,
                maxLengthEnforcement: widget.maxLengthEnforcement,
                maxLines: null,
                minLines: widget.minLines,
                onChanged: widget.onChanged,
                onEditingComplete: widget.onEditingComplete,
                onFieldSubmitted: widget.onSubmitted,
                onSaved: widget.onSaved,
                onTap: widget.onTap,
                onTapOutside: widget.onTapOutside,
                readOnly: widget.readOnly,
                restorationId: widget.restorationId,
                scrollController: widget.scrollController,
                scrollPadding: widget.scrollPadding,
                scrollPhysics: widget.scrollPhysics,
                showCursor: widget.showCursor,
                strutStyle: widget.strutStyle,
                style: effectiveTextStyle.copyWith(color: effectiveTextColor),
                textAlign: widget.textAlign,
                textAlignVertical: TextAlignVertical.top,
                textCapitalization: widget.textCapitalization,
                textDirection: widget.textDirection,
                textInputAction: widget.textInputAction,
                validator: _validateInput,
                decoration: InputDecoration(
                  contentPadding: effectiveTextPadding,
                  filled: true,
                  hintText: widget.hintText,
                  hintStyle: effectiveTextStyle.copyWith(color: effectiveHintTextColor),
                  errorStyle: const TextStyle(height: 0, fontSize: 0),
                  constraints: BoxConstraints(
                    minHeight: widget.height ?? 0.0,
                    maxHeight: widget.height ?? double.infinity,
                  ),
                  fillColor: effectiveBackgroundColor,
                  focusColor: effectiveActiveBorderColor,
                  hoverColor: Colors.transparent,
                  border: defaultBorder,
                  enabledBorder: defaultBorder,
                  disabledBorder: defaultBorder,
                  errorBorder: OutlineInputBorder(
                    borderRadius: effectiveBorderRadius.smoothBorderRadius(context),
                    borderSide: BorderSide(
                      color: effectiveErrorBorderColor,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: effectiveBorderRadius.smoothBorderRadius(context),
                    borderSide: BorderSide(
                      color: effectiveActiveBorderColor,
                      width: 2,
                    ),
                  ),
                ),
              ),
              if (_errorText != null && widget.errorBuilder != null)
                RepaintBoundary(
                  child: AnimatedIconTheme(
                    color: effectiveErrorBorderColor,
                    duration: effectiveTransitionDuration,
                    child: AnimatedDefaultTextStyle(
                      style: effectiveErrorTextStyle.copyWith(color: effectiveErrorBorderColor),
                      duration: effectiveTransitionDuration,
                      child: widget.errorBuilder!(context, _errorText),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
