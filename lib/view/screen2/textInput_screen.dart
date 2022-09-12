// ignore_for_file: file_names
import 'package:bmi_app/main.dart';
import 'package:bmi_app/models/bmi.dart';
// import 'package:bmi_app/models/bmi.dart';
import 'package:bmi_app/view/screen1/sliderInput_screen.dart';
import 'package:bmi_app/widgets/bmiResult.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextInputScreen extends ConsumerStatefulWidget {
  const TextInputScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<TextInputScreen> createState() => _TextInputScreenState();
}

class _TextInputScreenState extends ConsumerState<TextInputScreen> {
  @override
  Widget build(BuildContext context) {
    final bmi = ref.watch(refBmi);

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

          return Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.teal,
            child: Center(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: maxW,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //Height
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              children: const [
                                Text(
                                  'Größe in Meter: ',
                                  style: TextStyle(
                                    fontSize: 19.00,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                    'min.${BodyMassIndex.heightMin}m - max.${BodyMassIndex.heightMax}m'),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              initialValue: bmi.height.toStringAsFixed(2),
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                fontSize: 19.00,
                                fontWeight: FontWeight.w600,
                              ),
                              onChanged: (height) {
                                var heightDbl = double.tryParse(height);
                                if (heightDbl != null) {
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
                      //Weight
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              children: const [
                                Text(
                                  ' Gewicht(kg) :',
                                  style: TextStyle(
                                    fontSize: 19.00,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'min.${BodyMassIndex.weightMin}kg - max.${BodyMassIndex.weightMax}kg',
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              initialValue: bmi.weight.toStringAsFixed(1),
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                fontSize: 19.00,
                                fontWeight: FontWeight.w600,
                              ),
                              onChanged: (value) {
                                var weightdbl = double.tryParse(value);
                                if (weightdbl != null) {
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
