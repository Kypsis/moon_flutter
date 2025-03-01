import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_flutter/src/theme/colors.dart';

@immutable
class MoonAuthCodeColors extends ThemeExtension<MoonAuthCodeColors> with DiagnosticableTreeMixin {
  static final light = MoonAuthCodeColors(
    selectedBorderColor: MoonColors.light.piccolo,
    activeBorderColor: MoonColors.light.beerus,
    inactiveBorderColor: MoonColors.light.beerus,
    errorBorderColor: MoonColors.light.chiChi100,
    selectedFillColor: MoonColors.light.gohan,
    activeFillColor: MoonColors.light.gohan,
    inactiveFillColor: MoonColors.light.gohan,
    disabledColor: MoonColors.light.beerus,
    textColor: MoonColors.light.bulma,
  );

  static final dark = MoonAuthCodeColors(
    selectedBorderColor: MoonColors.dark.piccolo,
    activeBorderColor: MoonColors.dark.beerus,
    inactiveBorderColor: MoonColors.dark.beerus,
    errorBorderColor: MoonColors.dark.chiChi100,
    selectedFillColor: MoonColors.dark.gohan,
    activeFillColor: MoonColors.dark.gohan,
    inactiveFillColor: MoonColors.dark.gohan,
    disabledColor: MoonColors.dark.beerus,
    textColor: MoonColors.dark.bulma,
  );

  /// Border color of the selected auth input field.
  final Color selectedBorderColor;

  /// Border color of the active auth input field which has input, but is not selected.
  final Color activeBorderColor;

  /// Border color of the inactive auth input field which has no input.
  final Color inactiveBorderColor;

  /// Border color of the auth input field in error mode.
  final Color errorBorderColor;

  /// Fill color of the selected auth input field.
  final Color selectedFillColor;

  /// Fill color of the active auth input field which has input, but is not selected.
  final Color activeFillColor;

  /// Fill color of the inactive auth input field which has no input.
  final Color inactiveFillColor;

  /// Color of the auth input field when MoonAuthCode is disabled.
  final Color disabledColor;

  /// AuthCode text color.
  final Color textColor;

  const MoonAuthCodeColors({
    required this.selectedBorderColor,
    required this.activeBorderColor,
    required this.inactiveBorderColor,
    required this.errorBorderColor,
    required this.selectedFillColor,
    required this.activeFillColor,
    required this.inactiveFillColor,
    required this.disabledColor,
    required this.textColor,
  });

  @override
  MoonAuthCodeColors copyWith({
    Color? selectedBorderColor,
    Color? activeBorderColor,
    Color? inactiveBorderColor,
    Color? errorBorderColor,
    Color? selectedFillColor,
    Color? activeFillColor,
    Color? inactiveFillColor,
    Color? disabledColor,
    Color? textColor,
  }) {
    return MoonAuthCodeColors(
      selectedBorderColor: selectedBorderColor ?? this.selectedBorderColor,
      activeBorderColor: activeBorderColor ?? this.activeBorderColor,
      inactiveBorderColor: inactiveBorderColor ?? this.inactiveBorderColor,
      errorBorderColor: errorBorderColor ?? this.errorBorderColor,
      selectedFillColor: selectedFillColor ?? this.selectedFillColor,
      activeFillColor: activeFillColor ?? this.activeFillColor,
      inactiveFillColor: inactiveFillColor ?? this.inactiveFillColor,
      disabledColor: disabledColor ?? this.disabledColor,
      textColor: textColor ?? this.textColor,
    );
  }

  @override
  MoonAuthCodeColors lerp(ThemeExtension<MoonAuthCodeColors>? other, double t) {
    if (other is! MoonAuthCodeColors) return this;

    return MoonAuthCodeColors(
      selectedBorderColor: Color.lerp(selectedBorderColor, other.selectedBorderColor, t)!,
      activeBorderColor: Color.lerp(activeBorderColor, other.activeBorderColor, t)!,
      inactiveBorderColor: Color.lerp(inactiveBorderColor, other.inactiveBorderColor, t)!,
      errorBorderColor: Color.lerp(errorBorderColor, other.errorBorderColor, t)!,
      selectedFillColor: Color.lerp(selectedFillColor, other.selectedFillColor, t)!,
      activeFillColor: Color.lerp(activeFillColor, other.activeFillColor, t)!,
      inactiveFillColor: Color.lerp(inactiveFillColor, other.inactiveFillColor, t)!,
      disabledColor: Color.lerp(disabledColor, other.disabledColor, t)!,
      textColor: Color.lerp(textColor, other.textColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonAuthCodeColors"))
      ..add(ColorProperty("selectedBorderColor", selectedBorderColor))
      ..add(ColorProperty("activeBorderColor", activeBorderColor))
      ..add(ColorProperty("inactiveBorderColor", inactiveBorderColor))
      ..add(ColorProperty("errorBorderColor", errorBorderColor))
      ..add(ColorProperty("selectedFillColor", selectedFillColor))
      ..add(ColorProperty("activeFillColor", activeFillColor))
      ..add(ColorProperty("inactiveFillColor", inactiveFillColor))
      ..add(ColorProperty("disabledColor", disabledColor))
      ..add(ColorProperty("textColor", textColor));
  }
}
