/// SPDX-License-Identifier: BSD-3-Clause
/// fir_filter.dart
/// A basic example of a FIR filter
///
/// 2022 February 02
/// Author: wswongat
///

// ignore_for_file: avoid_print

import 'dart:io';
import 'package:rohd/rohd.dart';

import 'package:fir_filter/fir_filter.dart' as fir_filter;

Future<void> main({bool noPrint = false}) async {
  const sumWidth = 8;
  final en = Logic(name: 'en');
  final resetB = Logic(name: 'resetB');
  final inputVal = Logic(name: 'inputVal', width: sumWidth);

  final clk = SimpleClockGenerator(5).clk;
  // 4-cycle delay coefficients
  final firFilter =
      fir_filter.FirFilter(en, resetB, clk, inputVal, [0, 0, 0, 1], bitWidth: sumWidth);

  await firFilter.build();

  // Generate systemverilog code to file
  final systemVerilogCode = firFilter.generateSynth();
  if (!noPrint) {
    // Print systemverilog code to console
    print(systemVerilogCode);
    // Save systemverilog code to file
    File('rtl.sv').writeAsStringSync(systemVerilogCode);
  }

  en.put(0);
  resetB.put(0);
  inputVal.put(1);

  // Attach a waveform dumper
  if (!noPrint) {
    WaveDumper(firFilter);
  }

  Simulator.registerAction(5, () => en.put(1));
  Simulator.registerAction(10, () => resetB.put(1));

  for (var i = 1; i < 10; i++) {
    Simulator.registerAction(5 + i * 4, () => inputVal.put(i));
  }

  // Print a message when we're done with the simulation!
  Simulator.registerAction(100, () {
    if (!noPrint) {
      print('Simulation completed!');
    }
  });

  // Set a maximum time for the simulation so it doesn't keep running forever
  Simulator.setMaxSimTime(100);

  // Kick off the simulation
  await Simulator.run();

  // We can take a look at the waves now
  if (!noPrint) {
    print('To view waves, check out waves.vcd with a'
        ' waveform viewer (e.g. `gtkwave waves.vcd`).');
  }
}

