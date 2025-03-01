import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_flutter/src/theme/colors.dart';

@immutable
class MoonAlertColors extends ThemeExtension<MoonAlertColors> with DiagnosticableTreeMixin {
  static final light = MoonAlertColors(
    backgroundColor: MoonColors.light.gohan,
    borderColor: MoonColors.light.bulma,
    outlinedVariantColor: MoonColors.light.bulma,
  );

  static final dark = MoonAlertColors(
    backgroundColor: MoonColors.dark.gohan,
    borderColor: MoonColors.dark.trunks,
    outlinedVariantColor: MoonColors.dark.bulma,
  );

  /// Alert background color.
  final Color backgroundColor;

  /// Alert border color.
  final Color borderColor;

  /// Alert text color.
  final Color outlinedVariantColor;

  const MoonAlertColors({
    required this.backgroundColor,
    required this.borderColor,
    required this.outlinedVariantColor,
  });

  @override
  MoonAlertColors copyWith({
    Color? backgroundColor,
    Color? borderColor,
    Color? outlinedVariantColor,
  }) {
    return MoonAlertColors(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      outlinedVariantColor: outlinedVariantColor ?? this.outlinedVariantColor,
    );
  }

  @override
  MoonAlertColors lerp(ThemeExtension<MoonAlertColors>? other, double t) {
    if (other is! MoonAlertColors) return this;

    return MoonAlertColors(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      outlinedVariantColor: Color.lerp(outlinedVariantColor, other.outlinedVariantColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonAlertColors"))
      ..add(ColorProperty("backgroundColor", backgroundColor))
      ..add(ColorProperty("borderColor", borderColor))
      ..add(ColorProperty("outlinedVariantColor", outlinedVariantColor));
  }
}
