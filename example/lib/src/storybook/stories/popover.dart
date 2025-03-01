import 'package:example/src/storybook/common/color_options.dart';
import 'package:flutter/material.dart';
import 'package:moon_flutter/moon_flutter.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

bool show = false;

class PopoverStory extends Story {
  PopoverStory()
      : super(
          name: "Popover",
          builder: (context) {
            final customLabelTextKnob = context.knobs.text(
              label: "label text",
              initial: "Custom MoonPopover text",
            );

            final popoverPositionsKnob = context.knobs.nullable.options(
              label: "popoverPosition",
              description: "Position variants for MoonPopover.",
              enabled: false,
              initial: MoonPopoverPosition.top,
              options: const [
                Option(label: "top", value: MoonPopoverPosition.top),
                Option(label: "bottom", value: MoonPopoverPosition.bottom),
                Option(label: "left", value: MoonPopoverPosition.left),
                Option(label: "right", value: MoonPopoverPosition.right),
                Option(label: "topLeft", value: MoonPopoverPosition.topLeft),
                Option(label: "topRight", value: MoonPopoverPosition.topRight),
                Option(label: "bottomLeft", value: MoonPopoverPosition.bottomLeft),
                Option(label: "bottomRight", value: MoonPopoverPosition.bottomRight),
                Option(label: "vertical", value: MoonPopoverPosition.vertical),
                Option(label: "horizontal", value: MoonPopoverPosition.horizontal),
              ],
            );

            final backgroundColorsKnob = context.knobs.nullable.options(
              label: "backgroundColor",
              description: "MoonColors variants for MoonPopover background.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final backgroundColor = colorTable(context)[backgroundColorsKnob ?? 40];

            final borderColorsKnob = context.knobs.nullable.options(
              label: "borderColor",
              description: "MoonColors variants for MoonPopover border.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final borderColor = colorTable(context)[borderColorsKnob ?? 40];

            final borderRadiusKnob = context.knobs.nullable.sliderInt(
              label: "borderRadius",
              description: "Border radius for MoonPopover.",
              enabled: false,
              initial: 8,
              max: 32,
            );

            final distanceToTargetKnob = context.knobs.nullable.slider(
              label: "distanceToTarget",
              description: "Set the distance to target child widget.",
              enabled: false,
              initial: 8,
              max: 100,
            );

            final showShadowKnob = context.knobs.boolean(
              label: "Show shadow",
              description: "Show shadows under MoonPopover.",
              initial: true,
            );

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 64),
                  StatefulBuilder(
                    builder: (context, setState) {
                      return MoonPopover(
                        show: show,
                        borderColor: borderColor ?? Colors.transparent,
                        backgroundColor: backgroundColor,
                        borderRadius:
                            borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null,
                        distanceToTarget: distanceToTargetKnob,
                        popoverPosition: popoverPositionsKnob ?? MoonPopoverPosition.top,
                        popoverShadows: showShadowKnob == true ? null : [],
                        content: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 190),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                textDirection: Directionality.of(context),
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  MoonAvatar(
                                    backgroundColor: context.moonColors?.heles,
                                    content: const MoonIcon(MoonIcons.rocket_24),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(child: Text(customLabelTextKnob)),
                                ],
                              ),
                              const SizedBox(height: 16),
                              MoonFilledButton(
                                buttonSize: MoonButtonSize.sm,
                                isFullWidth: true,
                                onTap: () {
                                  setState(() => show = false);
                                },
                                label: const Text("Close"),
                              ),
                            ],
                          ),
                        ),
                        child: MoonFilledButton(
                          onTap: () {
                            setState(() => show = true);
                          },
                          label: const Text("Tap me"),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 64),
                ],
              ),
            );
          },
        );
}
