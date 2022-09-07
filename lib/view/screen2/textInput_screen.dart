// ignore_for_file: file_names

import 'package:bmi_app/models/bmi.dart';
import 'package:bmi_app/view/screen1/sliderInput_screen.dart';
import 'package:flutter/material.dart';

class TextInputScreen extends StatefulWidget {
  const TextInputScreen(this.bmi, {Key? key}) : super(key: key);

  final BodyMassIndex bmi;
  @override
  State<TextInputScreen> createState() => _TextInputScreenState();
}

class _TextInputScreenState extends State<TextInputScreen> {
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  var firstTime = true;

  @override
  Widget build(BuildContext context) {
    final bmi = widget.bmi;
    if (firstTime) {
      heightController.text = bmi.height.toStringAsFixed(2);
      weightController.text = bmi.weight.toStringAsFixed(0);
      firstTime = false;
    }
    final bmiWithoutNull = bmi.bmi ?? BodyMassIndex.bmiMin;
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator (text)'),
        leading: IconButton(
          icon: const Icon(Icons.switch_left),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SliderInputScreen(bmi),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Größe in Meter :',
                          style: TextStyle(
                            fontSize: 19.00,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: heightController,
                            style: const TextStyle(
                              fontSize: 19.00,
                              fontWeight: FontWeight.w500,
                            ),
                            onChanged: (value) {
                              setState(
                                () {
                                  final heightDbl = double.tryParse(value);
                                  if (heightDbl != null) {
                                    bmi.height = heightDbl;
                                  }
                                },
                              );
                            },
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: '',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Dein Gewicht(kg) :',
                          style: TextStyle(
                            fontSize: 19.00,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: weightController,
                            style: const TextStyle(
                              fontSize: 19.00,
                              fontWeight: FontWeight.w600,
                            ),
                            onChanged: (value) {
                              setState(() {
                                final weightdbl = double.tryParse(value);
                                if (weightdbl != null) {
                                  bmi.weight = weightdbl;
                                }
                              });
                            },
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: '',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Icon((bmiWithoutNull > 28.0 || bmiWithoutNull < 19.0)
                        ? Icons.build_circle_sharp
                        : Icons.check),
                    Text(
                      'Der BMI : ${bmiWithoutNull.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontWeight:
                            bmiWithoutNull > 28.0 || bmiWithoutNull < 19.0
                                ? FontWeight.w700
                                : FontWeight.w600,
                        fontSize: bmiWithoutNull > 28.0 || bmiWithoutNull < 19.0
                            ? 23.00
                            : 21.00,
                        color: bmiWithoutNull > 28.0 || bmiWithoutNull < 19.0
                            ? Colors.red
                            : Colors.black,
                      ),
                    ),
                    Expanded(
                      child: Slider(
                        activeColor:
                            bmiWithoutNull > 28.0 || bmiWithoutNull < 19.0
                                ? Colors.red
                                : Colors.black,
                        value: bmiWithoutNull,
                        onChanged: (value) {},
                        min: BodyMassIndex.bmiMin,
                        max: BodyMassIndex.bmiMax,
                      ),
                    ),
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
