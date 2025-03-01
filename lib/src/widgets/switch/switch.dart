import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:moon_flutter/src/theme/colors.dart';
import 'package:moon_flutter/src/theme/effects/focus_effects.dart';
import 'package:moon_flutter/src/theme/opacity.dart';
import 'package:moon_flutter/src/theme/shadows.dart';
import 'package:moon_flutter/src/theme/switch/switch_size_properties.dart';
import 'package:moon_flutter/src/theme/theme.dart';
import 'package:moon_flutter/src/widgets/common/animated_icon_theme.dart';
import 'package:moon_flutter/src/widgets/common/effects/focus_effect.dart';

enum MoonSwitchSize {
  x2s,
  xs,
  sm,
}

class MoonSwitch extends StatefulWidget {
  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// Whether the switch has haptic feedback (vibration) when toggled.
  final bool hasHapticFeedback;

  /// Determines if the switch is on or off.
  final bool value;

  /// The color to use on the switch when the switch is on.
  final Color? activeTrackColor;

  /// The color to use on the switch when the switch is off.
  final Color? inactiveTrackColor;

  /// The color of the thumb.
  final Color? thumbColor;

  /// The height of the switch.
  final double? height;

  /// The width of the switch.
  final double? width;

  /// The size of the thumb.
  final double? thumbSizeValue;

  /// The duration for the switch animation.
  final Duration? duration;

  /// The curve for the switch animation.
  final Curve? curve;

  /// The padding of the switch.
  final EdgeInsetsGeometry? padding;

  /// {@macro flutter.widgets.Focus.focusNode}.
  final FocusNode? focusNode;

  /// The size of the switch.
  final MoonSwitchSize? switchSize;

  /// The semantic label for the switch.
  final String? semanticLabel;

  /// Callback when the switch is toggled on or off.
  final ValueChanged<bool>? onChanged;

  /// The widget to display when the switch is on (left slot).
  final Widget? activeTrackWidget;

  /// The widget to display when the switch is off (right slot).
  final Widget? inactiveTrackWidget;

  /// The widget inside the thumb when switch is on.
  final Widget? activeThumbWidget;

  /// The widget inside the thumb when the switch is off.
  final Widget? inactiveThumbWidget;

  /// MDS switch widget.
  const MoonSwitch({
    super.key,
    this.autofocus = false,
    this.hasHapticFeedback = true,
    required this.value,
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.thumbColor,
    this.height,
    this.width,
    this.thumbSizeValue,
    this.duration,
    this.curve,
    this.padding,
    this.focusNode,
    this.switchSize,
    this.semanticLabel,
    this.onChanged,
    this.activeTrackWidget,
    this.inactiveTrackWidget,
    this.activeThumbWidget,
    this.inactiveThumbWidget,
  });

  @override
  _MoonSwitchState createState() => _MoonSwitchState();
}

class _MoonSwitchState extends State<MoonSwitch> with SingleTickerProviderStateMixin {
  late final Map<Type, Action<Intent>> _actions = {
    ActivateIntent: CallbackAction<Intent>(onInvoke: (_) => _handleTap())
  };

  late Animation<Alignment>? _alignmentAnimation;
  late Animation<Decoration>? _trackDecorationAnimation;

  AnimationController? _animationController;
  Animation<double>? _thumbFadeAnimation;
  Animation<double>? _activeTrackWidgetFadeAnimation;
  Animation<double>? _inactiveTrackWidgetFadeAnimation;
  CurvedAnimation? _curvedAnimation;
  CurvedAnimation? _curvedAnimationWithOvershoot;

  FocusNode? _focusNode;

  bool _isFocused = false;

  // A non-null boolean value that changes to true at the end of a drag if the
  // switch must be animated to the _curvedAnimationWithOvershoot indicated by the widget's value.
  bool _needsPositionAnimation = false;

  FocusNode get _effectiveFocusNode => widget.focusNode ?? (_focusNode ??= FocusNode());

  bool get _isInteractive => widget.onChanged != null;

  MoonSwitchSizeProperties _getMoonSwitchSize(BuildContext context, MoonSwitchSize? moonSwitchSize) {
    switch (moonSwitchSize) {
      case MoonSwitchSize.x2s:
        return context.moonTheme?.switchTheme.sizes.x2s ?? MoonSwitchSizeProperties.x2s;
      case MoonSwitchSize.xs:
        return context.moonTheme?.switchTheme.sizes.xs ?? MoonSwitchSizeProperties.xs;
      case MoonSwitchSize.sm:
        return context.moonTheme?.switchTheme.sizes.sm ?? MoonSwitchSizeProperties.sm;
      default:
        return context.moonTheme?.switchTheme.sizes.xs ?? MoonSwitchSizeProperties.xs;
    }
  }

  Color _getTextOrIconColor({required Color backgroundColor}) {
    final backgroundLuminance = backgroundColor.computeLuminance();

    if (backgroundLuminance > 0.5) {
      return MoonColors.light.bulma;
    } else {
      return MoonColors.dark.bulma;
    }
  }

  // `isLinear` must be true if the _curvedAnimationWithOvershoot animation is trying to move the
  // thumb to the closest end after the most recent drag animation, so the curve
  // does not change when the controller's value is not 0 or 1.
  //
  // It can be set to false when it's an implicit animation triggered by
  // widget.value changes.
  void _resumePositionAnimation({bool isLinear = true}) {
    _needsPositionAnimation = false;

    _curvedAnimationWithOvershoot!
      ..curve = isLinear ? Curves.linear : Curves.ease
      ..reverseCurve = isLinear ? Curves.linear : Curves.ease.flipped;

    if (widget.value) {
      _animationController!.forward();
    } else {
      _animationController!.reverse();
    }
  }

  void _handleFocus(bool focus) {
    if (focus != _isFocused) {
      setState(() => _isFocused = focus);
    }
  }

  void _handleFocusChange(bool hasFocus) {
    setState(() => _isFocused = hasFocus);
  }

  void _handleTapDown(TapDownDetails details) {
    if (_isInteractive) {
      _needsPositionAnimation = false;
    }
  }

  void _handleTap() {
    if (_isInteractive) {
      widget.onChanged!(!widget.value);
      _emitVibration();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (_isInteractive) {
      _needsPositionAnimation = false;
    }
  }

  void _handleDragStart(DragStartDetails details) {
    if (_isInteractive) {
      _needsPositionAnimation = false;
      _emitVibration();
    }
  }

  void _handleDragUpdate({
    required DragUpdateDetails details,
    required double switchWidth,
    required double thumbSizeValue,
    required EdgeInsets padding,
  }) {
    if (_isInteractive) {
      _curvedAnimationWithOvershoot!
        ..curve = Curves.linear
        ..reverseCurve = Curves.linear;

      switch (Directionality.of(context)) {
        case TextDirection.rtl:
          _animationController!.value +=
              -details.primaryDelta! / (switchWidth - (thumbSizeValue + padding.right + padding.left));
          break;
        case TextDirection.ltr:
          _animationController!.value +=
              details.primaryDelta! / (switchWidth - (thumbSizeValue + padding.right + padding.left));
          break;
      }
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    // Deferring the animation to the next build phase.
    setState(() {
      _needsPositionAnimation = true;
    });
    // Call onChanged when the user's intent to change value is clear.
    if (_curvedAnimationWithOvershoot!.value >= 0.5 != widget.value) {
      widget.onChanged!(!widget.value);
    }
  }

  void _emitVibration() {
    if (widget.hasHapticFeedback) {
      HapticFeedback.lightImpact();
    }
  }

  @override
  void didUpdateWidget(MoonSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (_needsPositionAnimation || oldWidget.value != widget.value) {
      _resumePositionAnimation(isLinear: _needsPositionAnimation);
    }

    if (_curvedAnimationWithOvershoot!.value == 0.0 || _curvedAnimationWithOvershoot!.value == 1.0) {
      _curvedAnimationWithOvershoot!
        ..curve = Curves.easeOutBack
        ..reverseCurve = Curves.easeOutBack.flipped;
    }
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_needsPositionAnimation) {
      _resumePositionAnimation();
    }

    final MoonSwitchSizeProperties effectiveMoonSwitchSize = _getMoonSwitchSize(context, widget.switchSize);

    final Color effectiveActiveTrackColor =
        widget.activeTrackColor ?? context.moonTheme?.switchTheme.colors.activeTrackColor ?? MoonColors.light.piccolo;

    final Color effectiveInactiveTrackColor = widget.inactiveTrackColor ??
        context.moonTheme?.switchTheme.colors.inactiveTrackColor ??
        MoonColors.light.beerus;

    final Color effectiveThumbColor =
        widget.thumbColor ?? context.moonTheme?.switchTheme.colors.thumbColor ?? MoonColors.light.goten;

    final double effectiveHeight = widget.height ?? effectiveMoonSwitchSize.height;

    final double effectiveWidth = widget.width ?? effectiveMoonSwitchSize.width;

    final double effectiveThumbSizeValue = widget.thumbSizeValue ?? effectiveMoonSwitchSize.thumbSizeValue;

    final double effectiveDisabledOpacityValue = context.moonTheme?.opacity.disabled ?? MoonOpacity.opacities.disabled;

    final EdgeInsetsGeometry effectivePadding = widget.padding ?? effectiveMoonSwitchSize.padding;

    final EdgeInsets resolvedDirectionalPadding = effectivePadding.resolve(Directionality.of(context));

    final BorderRadiusGeometry effectiveBorderRadius = BorderRadius.circular(effectiveThumbSizeValue / 2);

    final List<BoxShadow> effectiveThumbShadow =
        context.moonTheme?.switchTheme.shadows.thumbShadows ?? MoonShadows.light.sm;

    final Duration effectiveDuration = widget.duration ??
        context.moonTheme?.switchTheme.properties.transitionDuration ??
        const Duration(milliseconds: 200);

    final Curve effectiveTransitionCurve =
        widget.curve ?? context.moonTheme?.switchTheme.properties.transitionCurve ?? Curves.easeInOutCubic;

    final double effectiveFocusEffectExtent =
        context.moonEffects?.controlFocusEffect.effectExtent ?? MoonFocusEffects.lightFocusEffect.effectExtent;

    final Color effectiveFocusEffectColor =
        context.moonEffects?.controlFocusEffect.effectColor ?? MoonFocusEffects.lightFocusEffect.effectColor;

    final Duration effectiveFocusEffectDuration =
        context.moonEffects?.controlFocusEffect.effectDuration ?? MoonFocusEffects.lightFocusEffect.effectDuration;

    final Curve effectiveFocusEffectCurve =
        context.moonEffects?.controlFocusEffect.effectCurve ?? MoonFocusEffects.lightFocusEffect.effectCurve;

    _animationController ??= AnimationController(
      vsync: this,
      value: widget.value ? 1.0 : 0.0,
      duration: effectiveDuration,
    );

    _curvedAnimation ??= CurvedAnimation(
      parent: _animationController!,
      curve: effectiveTransitionCurve,
    );

    _curvedAnimationWithOvershoot ??= CurvedAnimation(
      parent: _animationController!,
      curve: effectiveTransitionCurve,
    );

    _alignmentAnimation = AlignmentTween(
      begin: Directionality.of(context) == TextDirection.ltr ? Alignment.centerLeft : Alignment.centerRight,
      end: Directionality.of(context) == TextDirection.ltr ? Alignment.centerRight : Alignment.centerLeft,
    ).animate(_curvedAnimationWithOvershoot!);

    _trackDecorationAnimation = DecorationTween(
      begin: BoxDecoration(
        borderRadius: BorderRadius.circular(effectiveHeight / 2),
        color: effectiveInactiveTrackColor,
      ),
      end: BoxDecoration(
        borderRadius: BorderRadius.circular(effectiveHeight / 2),
        color: effectiveActiveTrackColor,
      ),
    ).animate(_curvedAnimation!);

    _thumbFadeAnimation ??= TweenSequence<double>([
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1.0, end: 0.0),
        weight: 50.0,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        weight: 50.0,
      ),
    ]).animate(_curvedAnimation!);

    _activeTrackWidgetFadeAnimation ??= Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: const Interval(0.7, 1.0),
      ),
    );

    _inactiveTrackWidgetFadeAnimation ??= Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: const Interval(0.0, 0.3),
      ),
    );

    final Color iconColor = _getTextOrIconColor(backgroundColor: effectiveThumbColor);

    final Color activeTextColor = _getTextOrIconColor(backgroundColor: effectiveActiveTrackColor);

    final Color inactiveTextColor = _getTextOrIconColor(backgroundColor: effectiveInactiveTrackColor);

    return Semantics(
      label: widget.semanticLabel,
      toggled: widget.value,
      child: FocusableActionDetector(
        enabled: _isInteractive,
        actions: _actions,
        autofocus: widget.autofocus,
        focusNode: _effectiveFocusNode,
        onFocusChange: _handleFocusChange,
        onShowFocusHighlight: _handleFocus,
        mouseCursor: _isInteractive ? SystemMouseCursors.click : SystemMouseCursors.basic,
        child: GestureDetector(
          excludeFromSemantics: true,
          onTap: _handleTap,
          onTapDown: _handleTapDown,
          onTapUp: _handleTapUp,
          onHorizontalDragStart: _handleDragStart,
          onHorizontalDragUpdate: (DragUpdateDetails details) => _handleDragUpdate(
            details: details,
            switchWidth: effectiveWidth,
            thumbSizeValue: effectiveThumbSizeValue,
            padding: resolvedDirectionalPadding,
          ),
          onHorizontalDragEnd: _handleDragEnd,
          child: RepaintBoundary(
            child: AnimatedBuilder(
              animation: _animationController!,
              builder: (context, child) {
                return AnimatedOpacity(
                  opacity: _isInteractive ? 1 : effectiveDisabledOpacityValue,
                  duration: effectiveDuration,
                  curve: effectiveTransitionCurve,
                  child: SizedBox(
                    width: effectiveWidth,
                    height: effectiveHeight,
                    child: DecoratedBoxTransition(
                      decoration: _trackDecorationAnimation!,
                      child: Padding(
                        padding: resolvedDirectionalPadding,
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconTheme(
                                  data: IconThemeData(color: activeTextColor),
                                  child: AnimatedDefaultTextStyle(
                                    style: TextStyle(color: activeTextColor),
                                    duration: effectiveDuration,
                                    child: Expanded(
                                      child: FadeTransition(
                                        opacity: _activeTrackWidgetFadeAnimation!,
                                        child: widget.activeTrackWidget ?? const SizedBox.shrink(),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: resolvedDirectionalPadding.left),
                                IconTheme(
                                  data: IconThemeData(color: inactiveTextColor),
                                  child: AnimatedDefaultTextStyle(
                                    style: TextStyle(color: inactiveTextColor),
                                    duration: effectiveDuration,
                                    child: Expanded(
                                      child: FadeTransition(
                                        opacity: _inactiveTrackWidgetFadeAnimation!,
                                        child: widget.inactiveTrackWidget ?? const SizedBox.shrink(),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Align(
                              alignment: _alignmentAnimation!.value,
                              child: AnimatedIconTheme(
                                color: iconColor,
                                duration: effectiveDuration,
                                size: effectiveThumbSizeValue,
                                child: AnimatedDefaultTextStyle(
                                  style: TextStyle(color: inactiveTextColor),
                                  duration: effectiveDuration,
                                  child: MoonFocusEffect(
                                    show: _isFocused,
                                    effectColor: effectiveFocusEffectColor,
                                    childBorderRadius: effectiveBorderRadius,
                                    effectExtent: effectiveFocusEffectExtent,
                                    effectDuration: effectiveFocusEffectDuration,
                                    effectCurve: effectiveFocusEffectCurve,
                                    child: Container(
                                      width: effectiveThumbSizeValue,
                                      height: effectiveThumbSizeValue,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: effectiveBorderRadius,
                                        color: effectiveThumbColor,
                                        boxShadow: effectiveThumbShadow,
                                      ),
                                      child: FadeTransition(
                                        opacity: _thumbFadeAnimation!,
                                        child: _curvedAnimation!.value > 0.5
                                            ? widget.activeThumbWidget
                                            : widget.inactiveThumbWidget,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
