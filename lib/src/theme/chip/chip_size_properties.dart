import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_flutter/src/theme/borders.dart';
import 'package:moon_flutter/src/theme/sizes.dart';
import 'package:moon_flutter/src/theme/typography/text_styles.dart';

@immutable
class MoonChipSizeProperties extends ThemeExtension<MoonChipSizeProperties> with DiagnosticableTreeMixin {
  static final sm = MoonChipSizeProperties(
    borderRadius: MoonBorders.borders.interactiveXs,
    gap: MoonSizes.sizes.x5s,
    height: MoonSizes.sizes.sm,
    iconSizeValue: MoonSizes.sizes.x2s,
    padding: EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x3s),
    textStyle: MoonTextStyles.heading.text14,
  );

  static final md = MoonChipSizeProperties(
    borderRadius: MoonBorders.borders.interactiveSm,
    gap: MoonSizes.sizes.x4s,
    height: MoonSizes.sizes.md,
    iconSizeValue: MoonSizes.sizes.xs,
    padding: EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x3s),
    textStyle: MoonTextStyles.heading.text14,
  );

  /// Chip border radius.
  final BorderRadiusGeometry borderRadius;

  /// Space between chip children.
  final double gap;

  /// Chip height.
  final double height;

  /// Chip icon size value.
  final double iconSizeValue;

  /// Padding around chip children.
  final EdgeInsetsGeometry padding;

  /// Chip text style.
  final TextStyle textStyle;

  const MoonChipSizeProperties({
    required this.borderRadius,
    required this.gap,
    required this.height,
    required this.iconSizeValue,
    required this.padding,
    required this.textStyle,
  });

  @override
  MoonChipSizeProperties copyWith({
    BorderRadiusGeometry? borderRadius,
    double? gap,
    double? height,
    double? iconSizeValue,
    EdgeInsetsGeometry? padding,
    TextStyle? textStyle,
  }) {
    return MoonChipSizeProperties(
      borderRadius: borderRadius ?? this.borderRadius,
      gap: gap ?? this.gap,
      height: height ?? this.height,
      iconSizeValue: iconSizeValue ?? this.iconSizeValue,
      padding: padding ?? this.padding,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  @override
  MoonChipSizeProperties lerp(ThemeExtension<MoonChipSizeProperties>? other, double t) {
    if (other is! MoonChipSizeProperties) return this;

    return MoonChipSizeProperties(
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      gap: lerpDouble(gap, other.gap, t)!,
      height: lerpDouble(height, other.height, t)!,
      iconSizeValue: lerpDouble(iconSizeValue, other.iconSizeValue, t)!,
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonChipSizeProperties"))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("borderRadius", borderRadius))
      ..add(DoubleProperty("gap", gap))
      ..add(DoubleProperty("height", height))
      ..add(DoubleProperty("iconSizeValue", iconSizeValue))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>("padding", padding))
      ..add(DiagnosticsProperty<TextStyle>("textStyle", textStyle));
  }
}
