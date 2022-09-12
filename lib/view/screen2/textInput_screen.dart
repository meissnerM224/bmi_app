// ignore_for_file: file_names

import 'package:bmi_app/main.dart';
// import 'package:bmi_app/models/bmi.dart';
import 'package:bmi_app/view/screen1/sliderInput_screen.dart';
import 'package:bmi_app/widgets/bmi%20result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextInputScreen extends ConsumerStatefulWidget {
  const TextInputScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<TextInputScreen> createState() => _TextInputScreenState();
}

class _TextInputScreenState extends ConsumerState<TextInputScreen> {
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  var firstTime = true;

  @override
  Widget build(BuildContext context) {
    final bmi = ref.watch(refBmi);
    if (firstTime) {
      heightController.text = bmi.height.toStringAsFixed(2);
      weightController.text = bmi.weight.toStringAsFixed(0);
      firstTime = false;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator (text)'),
        leading: IconButton(
          icon: const Icon(Icons.switch_left),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const SliderInputScreen(),
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
            color: Colors.teal,
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: maxW,
                  maxHeight: maxH,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: const [
                            Text(
                              'Größe in Meter: ',
                              style: TextStyle(
                                fontSize: 19.00,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text('min.0.90m - max.2.2m   '),
                          ],
                        ),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: heightController,
                            style: const TextStyle(
                              fontSize: 19.00,
                              fontWeight: FontWeight.w500,
                            ),
                            onChanged: (value) {
                              var heightDbl = double.tryParse(value);
                              if (heightDbl != null) {
                                if (heightDbl >= 2.20) {
                                  heightDbl = 2.20;
                                }
                                if (heightDbl <= 0.90) {
                                  heightDbl = 0.9;
                                }
                                final notifier = ref.read(refBmi.notifier);
                                notifier.updateHeight(heightDbl);
                              }
                            },
                            decoration: const InputDecoration(
                              fillColor: Color.fromARGB(255, 77, 192, 167),
                              filled: true,
                              border: OutlineInputBorder(),
                              labelText: '',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: const [
                            Text(
                              ' Gewicht(kg) :',
                              style: TextStyle(
                                fontSize: 19.00,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'min.19kg - max.180kg   ',
                            ),
                          ],
                        ),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: weightController,
                            style: const TextStyle(
                              fontSize: 19.00,
                              fontWeight: FontWeight.w600,
                            ),
                            onChanged: (value) {
                              var weightdbl = double.tryParse(value);
                              if (weightdbl != null) {
                                if (weightdbl > 181) {
                                  weightdbl = 180;
                                }
                                if (weightdbl < 19) {
                                  weightdbl = 19;
                                }
                                final notifier = ref.read(refBmi.notifier);
                                notifier.updateWeight(weightdbl);
                              }
                            },
                            decoration: const InputDecoration(
                              fillColor: Color.fromARGB(255, 77, 192, 167),
                              filled: true,
                              border: OutlineInputBorder(),
                              labelText: '',
                            ),
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
