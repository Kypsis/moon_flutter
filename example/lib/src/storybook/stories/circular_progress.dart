import 'package:example/src/storybook/common/color_options.dart';
import 'package:flutter/material.dart';
import 'package:moon_flutter/moon_flutter.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class CircularProgressStory extends Story {
  CircularProgressStory()
      : super(
          name: "Progress/CircularProgress",
          builder: (context) {
            final circularProgressSizesKnob = context.knobs.nullable.options(
              label: "circularProgressSize",
              description: "Size variants for CircularProgress.",
              enabled: false,
              initial: MoonCircularProgressSize.md,
              options: const [
                Option(label: "x2s", value: MoonCircularProgressSize.x2s),
                Option(label: "xs", value: MoonCircularProgressSize.xs),
                Option(label: "sm", value: MoonCircularProgressSize.sm),
                Option(label: "md", value: MoonCircularProgressSize.md),
                Option(label: "lg", value: MoonCircularProgressSize.lg),
              ],
            );

            final circularProgressColorKnob = context.knobs.nullable.options(
              label: "color",
              description: "MoonColors variants for CircularProgress color.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final color = colorTable(context)[circularProgressColorKnob ?? 40];

            final circularProgressBackgroundColorKnob = context.knobs.nullable.options(
              label: "backgroundColor",
              description: "MoonColors variants for CircularProgress background.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final backgroundColor = colorTable(context)[circularProgressBackgroundColorKnob ?? 40];

            final circularProgressStrokeCapKnob = context.knobs.nullable.options(
              label: "strokeCap",
              description: "Stroke gap for CircularProgress.",
              enabled: false,
              initial: StrokeCap.round,
              options: const [
                Option(label: "round", value: StrokeCap.round),
                Option(label: "square", value: StrokeCap.square),
                Option(label: "butt", value: StrokeCap.butt),
              ],
            );

            final circularProgressValueKnob = context.knobs.slider(
              label: "value",
              description: "Value for CircularProgress.",
              initial: 0.75,
            );

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 64),
                  MoonCircularProgress(
                    value: circularProgressValueKnob,
                    color: color,
                    backgroundColor: backgroundColor,
                    circularProgressSize: circularProgressSizesKnob,
                    strokeCap: circularProgressStrokeCapKnob,
                  ),
                  const SizedBox(height: 64),
                ],
              ),
            );
          },
        );
}
