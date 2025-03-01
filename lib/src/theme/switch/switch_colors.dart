import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_flutter/src/theme/colors.dart';

@immutable
class MoonSwitchColors extends ThemeExtension<MoonSwitchColors> with DiagnosticableTreeMixin {
  static final light = MoonSwitchColors(
    activeTrackColor: MoonColors.light.piccolo,
    inactiveTrackColor: MoonColors.light.beerus,
    thumbColor: MoonColors.light.goten,
  );

  static final dark = MoonSwitchColors(
    activeTrackColor: MoonColors.dark.piccolo,
    inactiveTrackColor: MoonColors.dark.beerus,
    thumbColor: MoonColors.dark.goten,
  );

  /// Switch active track color.
  final Color activeTrackColor;

  /// Switch inactive track color.
  final Color inactiveTrackColor;

  /// Switch thumbColor.
  final Color thumbColor;

  const MoonSwitchColors({
    required this.activeTrackColor,
    required this.inactiveTrackColor,
    required this.thumbColor,
  });

  @override
  MoonSwitchColors copyWith({
    Color? activeTrackColor,
    Color? inactiveTrackColor,
    Color? thumbColor,
  }) {
    return MoonSwitchColors(
      activeTrackColor: activeTrackColor ?? this.activeTrackColor,
      inactiveTrackColor: inactiveTrackColor ?? this.inactiveTrackColor,
      thumbColor: thumbColor ?? this.thumbColor,
    );
  }

  @override
  MoonSwitchColors lerp(ThemeExtension<MoonSwitchColors>? other, double t) {
    if (other is! MoonSwitchColors) return this;

    return MoonSwitchColors(
      activeTrackColor: Color.lerp(activeTrackColor, other.activeTrackColor, t)!,
      inactiveTrackColor: Color.lerp(inactiveTrackColor, other.inactiveTrackColor, t)!,
      thumbColor: Color.lerp(thumbColor, other.thumbColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonSwitchColors"))
      ..add(ColorProperty("activeTrackColor", activeTrackColor))
      ..add(ColorProperty("inactiveTrackColor", inactiveTrackColor))
      ..add(ColorProperty("thumbColor", thumbColor));
  }
}
