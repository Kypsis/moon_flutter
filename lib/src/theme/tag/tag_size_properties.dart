import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_flutter/src/theme/borders.dart';
import 'package:moon_flutter/src/theme/sizes.dart';
import 'package:moon_flutter/src/theme/typography/text_styles.dart';

@immutable
class MoonTagSizeProperties extends ThemeExtension<MoonTagSizeProperties> with DiagnosticableTreeMixin {
  static final x2s = MoonTagSizeProperties(
    borderRadius: MoonBorders.borders.interactiveXs,
    gap: MoonSizes.sizes.x5s,
    height: MoonSizes.sizes.x2s,
    iconSizeValue: MoonSizes.sizes.x3s,
    padding: EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x4s),
    textStyle: MoonTextStyles.body.text10.copyWith(fontWeight: FontWeight.w400),
    upperCaseTextStyle: MoonTextStyles.caption.text9,
  );

  static final xs = MoonTagSizeProperties(
    borderRadius: MoonBorders.borders.interactiveXs,
    gap: MoonSizes.sizes.x5s,
    height: MoonSizes.sizes.xs,
    iconSizeValue: MoonSizes.sizes.x2s,
    padding: EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x4s),
    textStyle: MoonTextStyles.body.text12.copyWith(fontWeight: FontWeight.w400),
    upperCaseTextStyle: MoonTextStyles.caption.text10,
  );

  /// Tag border radius.
  final BorderRadiusGeometry borderRadius;

  /// Space between tag children.
  final double gap;

  /// Tag height.
  final double height;

  /// Tag icon size value.
  final double iconSizeValue;

  /// Padding around tag children.
  final EdgeInsetsGeometry padding;

  /// Tag body style.
  final TextStyle textStyle;

  /// Tag upper case body style.
  final TextStyle upperCaseTextStyle;

  const MoonTagSizeProperties({
    required this.borderRadius,
    required this.gap,
    required this.height,
    required this.iconSizeValue,
    required this.padding,
    required this.textStyle,
    required this.upperCaseTextStyle,
  });

  @override
  MoonTagSizeProperties copyWith({
    BorderRadiusGeometry? borderRadius,
    double? gap,
    double? height,
    double? iconSizeValue,
    EdgeInsetsGeometry? padding,
    TextStyle? textStyle,
    TextStyle? upperCaseTextStyle,
  }) {
    return MoonTagSizeProperties(
      borderRadius: borderRadius ?? this.borderRadius,
      gap: gap ?? this.gap,
      height: height ?? this.height,
      iconSizeValue: iconSizeValue ?? this.iconSizeValue,
      padding: padding ?? this.padding,
      textStyle: textStyle ?? this.textStyle,
      upperCaseTextStyle: upperCaseTextStyle ?? this.upperCaseTextStyle,
    );
  }

  @override
  MoonTagSizeProperties lerp(ThemeExtension<MoonTagSizeProperties>? other, double t) {
    if (other is! MoonTagSizeProperties) return this;

    return MoonTagSizeProperties(
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      gap: lerpDouble(gap, other.gap, t)!,
      height: lerpDouble(height, other.height, t)!,
      iconSizeValue: lerpDouble(iconSizeValue, other.iconSizeValue, t)!,
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
      upperCaseTextStyle: TextStyle.lerp(upperCaseTextStyle, other.upperCaseTextStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTagSizeProperties"))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("borderRadius", borderRadius))
      ..add(DoubleProperty("gap", gap))
      ..add(DoubleProperty("height", height))
      ..add(DoubleProperty("iconSizeValue", iconSizeValue))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>("padding", padding))
      ..add(DiagnosticsProperty<TextStyle>("textStyle", textStyle))
      ..add(DiagnosticsProperty<TextStyle>("upperCaseTextStyle", upperCaseTextStyle));
  }
}
