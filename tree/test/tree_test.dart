/// Copyright (C) 2021 Intel Corporation
/// SPDX-License-Identifier: BSD-3-Clause
///
/// example_test.dart
/// Tests to make sure that the examples don't break.
///
/// 2021 September 17
/// Author: Max Korbel <max.korbel@intel.com>
///
import 'package:rohd/rohd.dart';
import 'package:test/test.dart';

import 'package:tree/tree.dart';
import '../bin/tree.dart' as tree;

void main() {
  tearDown(Simulator.reset);
  test('tree example', () async {
    await tree.main(noPrint: true);
  });
}
