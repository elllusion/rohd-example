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

import 'package:example/example.dart';
import '../bin/example.dart' as counter;

void main() {
  tearDown(Simulator.reset);
  test('counter example', () async {
    await counter.main(noPrint: true);
  });
}

