import 'package:example/src/storybook/common/color_options.dart';
import 'package:flutter/material.dart';
import 'package:moon_flutter/moon_flutter.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class CircularLoaderStory extends Story {
  CircularLoaderStory()
      : super(
          name: "Loader/CircularLoader",
          builder: (context) {
            final loaderSizesKnob = context.knobs.nullable.options(
              label: "circularLoaderSize",
              description: "Size variants for CircularLoader.",
              enabled: false,
              initial: MoonCircularLoaderSize.md,
              options: const [
                Option(label: "x2s", value: MoonCircularLoaderSize.x2s),
                Option(label: "xs", value: MoonCircularLoaderSize.xs),
                Option(label: "sm", value: MoonCircularLoaderSize.sm),
                Option(label: "md", value: MoonCircularLoaderSize.md),
                Option(label: "lg", value: MoonCircularLoaderSize.lg),
              ],
            );

            final loaderColorKnob = context.knobs.nullable.options(
              label: "color",
              description: "MoonColors variants for CircularLoader color.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final color = colorTable(context)[loaderColorKnob ?? 40];

            final loaderBackgroundColorKnob = context.knobs.nullable.options(
              label: "backgroundColor",
              description: "MoonColors variants for CircularLoader background.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final backgroundColor = colorTable(context)[loaderBackgroundColorKnob ?? 40];

            final loaderStrokeCapKnob = context.knobs.nullable.options(
              label: "strokeCap",
              description: "Stroke gap for CircularLoader.",
              enabled: false,
              initial: StrokeCap.round,
              options: const [
                Option(label: "round", value: StrokeCap.round),
                Option(label: "square", value: StrokeCap.square),
                Option(label: "butt", value: StrokeCap.butt),
              ],
            );

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 64),
                  MoonCircularLoader(
                    color: color,
                    backgroundColor: backgroundColor,
                    circularLoaderSize: loaderSizesKnob,
                    strokeCap: loaderStrokeCapKnob,
                  ),
                  const SizedBox(height: 64),
                ],
              ),
            );
          },
        );
}
