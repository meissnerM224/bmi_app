// ignore_for_file: file_names

import 'package:bmi_app/main.dart';
import 'package:bmi_app/models/bmi.dart';
import 'package:bmi_app/view/screen2/textInput_screen.dart';
import 'package:bmi_app/widgets/bmi%20result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SliderInputScreen extends ConsumerStatefulWidget {
  const SliderInputScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<SliderInputScreen> createState() => _SliderInputScreenState();
}

class _SliderInputScreenState extends ConsumerState<SliderInputScreen> {
  @override
  Widget build(BuildContext context) {
    final bmi = ref.watch(refBmi);

    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator(slider)'),
        leading: IconButton(
          icon: const Icon(Icons.switch_right),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const TextInputScreen(),
              ),
            );
          },
        ),
      ),
      body: LayoutBuilder(
        builder: ((context, constraints) {
          double maxW = constraints.maxWidth * 0.75;
          double maxH = constraints.maxHeight * 0.5;
          return Container(
            color: Colors.cyan,
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: maxW,
                  maxHeight: maxH,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Text(
                        '  Größe :',
                        style: TextStyle(
                          fontSize: 15.00,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Expanded(
                        child: Slider(
                          activeColor: Colors.green,
                          inactiveColor: Colors.amber,
                          divisions: 220,
                          label: '${bmi.height.toStringAsFixed(2)} m',
                          onChanged: (value) {
                            var height = value;
                            final provider = ref.read(refBmi.notifier);
                            provider.state = BodyMassIndex(
                              heigth: height,
                              weight: provider.state.weight,
                            );
                          },
                          min: 00.890,
                          max: 02.20,
                          value: bmi.height,
                        ),
                      ),
                    ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Gewicht:',
                          style: TextStyle(
                            fontSize: 15.00,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Expanded(
                          child: Slider(
                            activeColor: Colors.red,
                            inactiveColor: Colors.amber,
                            divisions: 180,
                            label: ' ${bmi.weight.round()} Kg',
                            onChanged: (value) {
                              var weight = value;
                              final provider = ref.read(refBmi.notifier);
                              provider.state = BodyMassIndex(
                                weight: weight,
                                heigth: provider.state.height,
                              );
                            },
                            min: 19.0,
                            max: 180.0,
                            value: bmi.weight,
                          ),
                        ),
                      ],
                    ),
                    const Expanded(child: BmiResult()),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
