/// Copyright (C) 2021 Intel Corporation
/// SPDX-License-Identifier: BSD-3-Clause
///
/// tree.dart
/// An example taking advantage of some of ROHD's generation capabilities.
///
/// 2021 September 17
/// Author: Max Korbel <max.korbel@intel.com>
///

// ignore_for_file: avoid_print

import 'package:rohd/rohd.dart';

import 'package:tree/tree.dart' as Tree;

Future<void> main({bool noPrint = false}) async {
  // You could instantiate this module with some code such as:
  final tree = Tree.TreeOfTwoInputModules(
      List<Logic>.generate(16, (index) => Logic(width: 8)),
      (a, b) => mux(a > b, a, b));

  /// This instantiation code generates a list of sixteen 8-bit logic signals.
  /// The operation to be performed (`_op`) is to create a `Mux` which returns
  ///  `a` if `a` is greater than `b`, otherwise `b`.  Therefore, this
  /// instantiation creates a logarithmic-height tree of modules which outputs
  /// the largest 8-bit value.  Note that `Mux` also needs no parameters, as it
  /// can automatically determine the appropriate size of `y` based on the
  /// inputs.
  ///
  /// A SystemVerilog implementation of this requires numerous module
  /// definitions and substantially more code.

  // Below will generate an output of the ROHD-generated SystemVerilog:
  await tree.build();
  final generatedSystemVerilog = tree.generateSynth();
  if (!noPrint) {
    print(generatedSystemVerilog);
  }
}
