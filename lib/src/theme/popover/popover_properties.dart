import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_flutter/src/theme/borders.dart';
import 'package:moon_flutter/src/theme/sizes.dart';

@immutable
class MoonPopoverProperties extends ThemeExtension<MoonPopoverProperties> with DiagnosticableTreeMixin {
  static final properties = MoonPopoverProperties(
    borderRadius: MoonBorders.borders.interactiveMd,
    distanceToTarget: MoonSizes.sizes.x4s,
    transitionDuration: const Duration(milliseconds: 150),
    transitionCurve: Curves.easeInOutCubic,
    contentPadding: EdgeInsets.all(MoonSizes.sizes.x3s),
  );

  /// Popover border radius.
  final BorderRadiusGeometry borderRadius;

  /// Popover distance to target child widget.
  final double distanceToTarget;

  /// Popover transition duration (fade in or out animation).
  final Duration transitionDuration;

  /// Popover transition curve (fade in or out animation).
  final Curve transitionCurve;

  /// Padding around popover content.
  final EdgeInsetsGeometry contentPadding;

  const MoonPopoverProperties({
    required this.borderRadius,
    required this.distanceToTarget,
    required this.transitionDuration,
    required this.transitionCurve,
    required this.contentPadding,
  });

  @override
  MoonPopoverProperties copyWith({
    BorderRadiusGeometry? borderRadius,
    double? distanceToTarget,
    Duration? transitionDuration,
    Curve? transitionCurve,
    EdgeInsetsGeometry? contentPadding,
  }) {
    return MoonPopoverProperties(
      borderRadius: borderRadius ?? this.borderRadius,
      distanceToTarget: distanceToTarget ?? this.distanceToTarget,
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
      contentPadding: contentPadding ?? this.contentPadding,
    );
  }

  @override
  MoonPopoverProperties lerp(ThemeExtension<MoonPopoverProperties>? other, double t) {
    if (other is! MoonPopoverProperties) return this;

    return MoonPopoverProperties(
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      distanceToTarget: lerpDouble(distanceToTarget, other.distanceToTarget, t)!,
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
      contentPadding: EdgeInsetsGeometry.lerp(contentPadding, other.contentPadding, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonPopoverProperties"))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("borderRadius", borderRadius))
      ..add(DoubleProperty("distanceToTarget", distanceToTarget))
      ..add(DiagnosticsProperty<Duration>("transitionDuration", transitionDuration))
      ..add(DiagnosticsProperty<Curve>("transitionCurve", transitionCurve))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>("contentPadding", contentPadding));
  }
}
