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

import 'package:fir_filter/fir_filter.dart' as firFilter;
import '../bin/fir_filter.dart' as fir_filter;

void main() {
  tearDown(Simulator.reset);
  test('fir filter example', () async {
    await fir_filter.main(noPrint: true);
  });
  
  test('fir filter test', () async {
    const sumWidth = 8;
    final en = Logic(name: 'en');
    final resetB = Logic(name: 'resetB');
    final inputVal = Logic(name: 'inputVal', width: sumWidth);
    final clk = SimpleClockGenerator(5).clk;
    
    await firFilter.FirFilter(en, resetB, clk, inputVal, [0, 0, 0, 1], bitWidth: sumWidth);
  });
}
