import 'package:flutter/material.dart';

import 'package:moon_flutter/moon_flutter.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

// The below combination of "indexes" and colors in the colorTable() LUT is to bypass the stale closure that the knob
// would otherwise have.

/// Index of the color options.
List<Option<int>> colorOptions = const [
  Option(label: "piccolo", value: 0),
  Option(label: "hit", value: 1),
  Option(label: "beerus", value: 2),
  Option(label: "goku", value: 3),
  Option(label: "gohan", value: 4),
  Option(label: "bulma", value: 5),
  Option(label: "trunks", value: 6),
  Option(label: "goten", value: 7),
  Option(label: "popo", value: 8),
  Option(label: "jiren", value: 9),
  Option(label: "heles", value: 10),
  Option(label: "zeno", value: 11),
  Option(label: "krillin100", value: 12),
  Option(label: "krillin60", value: 13),
  Option(label: "krillin10", value: 14),
  Option(label: "chichi100", value: 15),
  Option(label: "chichi60", value: 16),
  Option(label: "chichi10", value: 17),
  Option(label: "roshi100", value: 18),
  Option(label: "roshi60", value: 19),
  Option(label: "roshi10", value: 20),
  Option(label: "frieza100", value: 21),
  Option(label: "frieza60", value: 22),
  Option(label: "frieza10", value: 23),
  Option(label: "dodoria100", value: 24),
  Option(label: "dodoria60", value: 25),
  Option(label: "dodoria10", value: 26),
  Option(label: "cell100", value: 27),
  Option(label: "cell60", value: 28),
  Option(label: "cell10", value: 29),
  Option(label: "raditz100", value: 30),
  Option(label: "raditz60", value: 31),
  Option(label: "raditz10", value: 32),
  Option(label: "nappa100", value: 33),
  Option(label: "nappa60", value: 34),
  Option(label: "nappa10", value: 35),
  Option(label: "whis100", value: 36),
  Option(label: "whis60", value: 37),
  Option(label: "whis10", value: 38),
  Option(label: "transparent", value: 39),
];

/// LUT for the color options.
List<Color?> colorTable(BuildContext context) => [
      context.moonColors!.piccolo,
      context.moonColors!.hit,
      context.moonColors!.beerus,
      context.moonColors!.goku,
      context.moonColors!.gohan,
      context.moonColors!.bulma,
      context.moonColors!.trunks,
      context.moonColors!.goten,
      context.moonColors!.popo,
      context.moonColors!.jiren,
      context.moonColors!.heles,
      context.moonColors!.zeno,
      context.moonColors!.krillin100,
      context.moonColors!.krillin60,
      context.moonColors!.krillin10,
      context.moonColors!.chiChi100,
      context.moonColors!.chiChi60,
      context.moonColors!.chiChi10,
      context.moonColors!.roshi100,
      context.moonColors!.roshi60,
      context.moonColors!.roshi10,
      context.moonColors!.frieza100,
      context.moonColors!.frieza60,
      context.moonColors!.frieza10,
      context.moonColors!.dodoria100,
      context.moonColors!.dodoria60,
      context.moonColors!.dodoria10,
      context.moonColors!.cell100,
      context.moonColors!.cell60,
      context.moonColors!.cell10,
      context.moonColors!.raditz100,
      context.moonColors!.raditz60,
      context.moonColors!.raditz10,
      context.moonColors!.nappa100,
      context.moonColors!.nappa60,
      context.moonColors!.nappa10,
      context.moonColors!.whis100,
      context.moonColors!.whis60,
      context.moonColors!.whis10,
      Colors.transparent,
      null,
    ];
