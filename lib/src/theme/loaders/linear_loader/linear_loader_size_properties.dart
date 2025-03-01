import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_flutter/src/theme/borders.dart';
import 'package:moon_flutter/src/theme/sizes.dart';

@immutable
class MoonLinearLoaderSizeProperties extends ThemeExtension<MoonLinearLoaderSizeProperties>
    with DiagnosticableTreeMixin {
  static final x6s = MoonLinearLoaderSizeProperties(
    borderRadius: MoonBorders.borders.surfaceXs,
    loaderHeight: MoonSizes.sizes.x6s,
  );

  static final x5s = MoonLinearLoaderSizeProperties(
    borderRadius: MoonBorders.borders.surfaceXs,
    loaderHeight: MoonSizes.sizes.x5s,
  );

  static final x4s = MoonLinearLoaderSizeProperties(
    borderRadius: MoonBorders.borders.surfaceSm,
    loaderHeight: MoonSizes.sizes.x4s,
  );

  static final x3s = MoonLinearLoaderSizeProperties(
    borderRadius: MoonBorders.borders.surfaceMd,
    loaderHeight: MoonSizes.sizes.x3s,
  );

  static final x2s = MoonLinearLoaderSizeProperties(
    borderRadius: MoonBorders.borders.surfaceLg,
    loaderHeight: MoonSizes.sizes.x2s,
  );

  /// Linear loader border radius.
  final BorderRadiusGeometry borderRadius;

  /// Linear loader height.
  final double loaderHeight;

  const MoonLinearLoaderSizeProperties({
    required this.borderRadius,
    required this.loaderHeight,
  });

  @override
  MoonLinearLoaderSizeProperties copyWith({
    BorderRadiusGeometry? borderRadius,
    double? loaderHeight,
  }) {
    return MoonLinearLoaderSizeProperties(
      borderRadius: borderRadius ?? this.borderRadius,
      loaderHeight: loaderHeight ?? this.loaderHeight,
    );
  }

  @override
  MoonLinearLoaderSizeProperties lerp(ThemeExtension<MoonLinearLoaderSizeProperties>? other, double t) {
    if (other is! MoonLinearLoaderSizeProperties) return this;

    return MoonLinearLoaderSizeProperties(
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      loaderHeight: lerpDouble(loaderHeight, other.loaderHeight, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonLinearLoaderSizeProperties"))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("borderRadius", borderRadius))
      ..add(DoubleProperty("loaderHeight", loaderHeight));
  }
}
