import 'package:bmi_app/main.dart';
import 'package:bmi_app/models/bmi.dart';
import 'package:bmi_app/view/screen2/textInput_screen.dart';
import 'package:bmi_app/widgets/bmiResult.dart';
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
          return Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.cyan,
            child: Center(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: maxW,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        // Height
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '  Größe :',
                            style: TextStyle(
                              fontSize: 17.00,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Expanded(
                            child: Slider(
                              activeColor: Colors.green,
                              inactiveColor: Colors.amber,
                              divisions: (BodyMassIndex.heightMax * 100 -
                                      BodyMassIndex.heightMin * 100)
                                  .toInt(),
                              label: '${bmi.height.toStringAsFixed(2)} m',
                              onChanged: (value) {
                                final notifier = ref.read(refBmi.notifier);
                                notifier.updateHeight(value);
                              },
                              min: BodyMassIndex.heightMin,
                              max: BodyMassIndex.heightMax,
                              value: bmi.height,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        // Weight
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Gewicht:',
                            style: TextStyle(
                              fontSize: 17.00,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Expanded(
                            child: Slider(
                              activeColor: Colors.red,
                              inactiveColor: Colors.amber,
                              divisions: (BodyMassIndex.weightMax -
                                      BodyMassIndex.weightMin) *
                                  10,
                              label: ' ${bmi.weight.toStringAsFixed(1)} Kg',
                              onChanged: (value) {
                                final notifier = ref.read(refBmi.notifier);
                                notifier.updateWeight(value);
                              },
                              min: BodyMassIndex.weightMin.toDouble(),
                              max: BodyMassIndex.weightMax.toDouble(),
                              value: bmi.weight,
                            ),
                          ),
                        ],
                      ),
                      const BmiResult(),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
