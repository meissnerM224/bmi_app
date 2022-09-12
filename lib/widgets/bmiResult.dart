// ignore_for_file: avoid_unnecessary_containers, file_names, prefer_const_constructors

import 'package:bmi_app/main.dart';
import 'package:bmi_app/models/bmi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BmiResult extends ConsumerWidget {
  const BmiResult({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bmi = ref.watch(refBmi).bmi;
    return SizedBox(
      height: 250,
      child: Column(children: [
        Expanded(
          child:
              Icon((bmi > 28.0 || bmi < 19.0) ? Icons.back_hand : Icons.check),
        ),
        Expanded(
          child: Text(
            'Der BMI: ${bmi.toStringAsFixed(0)}',
            style: TextStyle(
              fontWeight:
                  bmi > 28.0 || bmi < 19.0 ? FontWeight.w700 : FontWeight.w600,
              fontSize: bmi > 28.0 || bmi < 19.0 ? 23.00 : 21.00,
              color: bmi > 28.0 || bmi < 19.0
                  ? Color.fromARGB(255, 210, 23, 10)
                  : Colors.black,
            ),
          ),
        ),
        Expanded(
          child: Text('ein BMI zwischen 19 und 28 ist wünschenswert, da dieser'
              ' ein Gesundes Gewicht / Körpergroesse verhältnis darstellt '),
        ),
        Expanded(
          child: Slider(
            activeColor: bmi > 28.0 || bmi < 19.0
                ? Color.fromARGB(255, 210, 23, 10)
                : Colors.black,
            value: bmi,
            onChanged: (value) {},
            min: BodyMassIndex.bmiMin,
            max: BodyMassIndex.bmiMax,
          ),
        ),
      ]),
    );
  }
}
