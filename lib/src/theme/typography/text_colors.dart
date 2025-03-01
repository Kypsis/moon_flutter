import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_flutter/src/theme/colors.dart';

@immutable
class MoonTextColors extends ThemeExtension<MoonTextColors> with DiagnosticableTreeMixin {
  static final light = MoonTextColors(
    bodyPrimary: MoonColors.light.bulma,
    bodySecondary: MoonColors.light.trunks,
    controlPrimary: MoonColors.light.goten,
    controlSecondary: MoonColors.light.popo,
  );

  static final dark = MoonTextColors(
    bodyPrimary: MoonColors.dark.bulma,
    bodySecondary: MoonColors.dark.trunks,
    controlPrimary: MoonColors.dark.goten,
    controlSecondary: MoonColors.dark.popo,
  );

  /// Primary body text and icon color.
  final Color bodyPrimary;

  /// Primary body text and icon color.
  final Color bodySecondary;

  /// Primary control element (button, chip, etc) text and icon color.
  final Color controlPrimary;

  /// Secondary control element (button, chip, etc) text and icon color.
  final Color controlSecondary;

  const MoonTextColors({
    required this.bodyPrimary,
    required this.bodySecondary,
    required this.controlPrimary,
    required this.controlSecondary,
  });

  @override
  MoonTextColors copyWith({
    Color? bodyPrimary,
    Color? bodySecondary,
    Color? controlPrimary,
    Color? controlSecondary,
  }) {
    return MoonTextColors(
      bodyPrimary: bodyPrimary ?? this.bodyPrimary,
      bodySecondary: bodySecondary ?? this.bodySecondary,
      controlPrimary: controlPrimary ?? this.controlPrimary,
      controlSecondary: controlSecondary ?? this.controlSecondary,
    );
  }

  @override
  MoonTextColors lerp(ThemeExtension<MoonTextColors>? other, double t) {
    if (other is! MoonTextColors) return this;

    return MoonTextColors(
      bodyPrimary: Color.lerp(bodyPrimary, other.bodyPrimary, t)!,
      bodySecondary: Color.lerp(bodySecondary, other.bodySecondary, t)!,
      controlPrimary: Color.lerp(controlPrimary, other.controlPrimary, t)!,
      controlSecondary: Color.lerp(controlSecondary, other.controlSecondary, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTextColors"))
      ..add(ColorProperty("bodyPrimary", bodyPrimary))
      ..add(ColorProperty("bodySecondary", bodySecondary))
      ..add(ColorProperty("controlPrimary", controlPrimary))
      ..add(ColorProperty("controlSecondary", controlSecondary));
  }
}
