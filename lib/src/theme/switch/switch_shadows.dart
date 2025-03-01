import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_flutter/src/theme/shadows.dart';

@immutable
class MoonSwitchShadows extends ThemeExtension<MoonSwitchShadows> with DiagnosticableTreeMixin {
  static final light = MoonSwitchShadows(
    thumbShadows: MoonShadows.light.sm,
  );

  static final dark = MoonSwitchShadows(
    thumbShadows: MoonShadows.dark.sm,
  );

  /// Switch thumb shadows.
  final List<BoxShadow> thumbShadows;

  const MoonSwitchShadows({
    required this.thumbShadows,
  });

  @override
  MoonSwitchShadows copyWith({List<BoxShadow>? thumbShadows}) {
    return MoonSwitchShadows(
      thumbShadows: thumbShadows ?? this.thumbShadows,
    );
  }

  @override
  MoonSwitchShadows lerp(ThemeExtension<MoonSwitchShadows>? other, double t) {
    if (other is! MoonSwitchShadows) return this;

    return MoonSwitchShadows(
      thumbShadows: BoxShadow.lerpList(thumbShadows, other.thumbShadows, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonSwitchShadows"))
      ..add(DiagnosticsProperty<List<BoxShadow>>("thumbShadows", thumbShadows));
  }
}
