import 'package:bmi_app/models/bmi.dart';
import 'package:bmi_app/view/screen2/textInput_screen.dart';
import 'package:flutter/material.dart';

class SliderInputScreen extends StatefulWidget {
  const SliderInputScreen(
    this.bmi, {
    Key? key,
  }) : super(key: key);

  final BodyMassIndex bmi;

  @override
  State<SliderInputScreen> createState() => _SliderInputScreenState();
}

class _SliderInputScreenState extends State<SliderInputScreen> {
  @override
  Widget build(BuildContext context) {
    final bmi = widget.bmi;

    final bmiWithouNutll = bmi.bmi ?? BodyMassIndex.bmiMin;
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator(slider)'),
        leading: IconButton(
          icon: const Icon(Icons.switch_right),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => TextInputScreen(
                  bmi,
                ),
              ),
            );
          },
        ),
      ),
      body: LayoutBuilder(
        builder: ((context, constraints) {
          double maxW = constraints.maxWidth * 0.75;
          double maxH = constraints.maxHeight * 0.4;
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
                        'Größe in Meter:',
                        style: TextStyle(
                          fontSize: 19.00,
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
                            setState(() {
                              bmi.height = value;
                            });
                          },
                          min: 01.10,
                          max: 02.20,
                          value: bmi.height,
                        ),
                      ),
                    ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Gewicht in Kg:',
                          style: TextStyle(
                            fontSize: 19.00,
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
                              setState(
                                () {
                                  bmi.weight = value;
                                },
                              );
                            },
                            min: 21.0,
                            max: 180.0,
                            value: bmi.weight,
                          ),
                        ),
                      ],
                    ),
                    Icon((bmiWithouNutll > 28 || bmiWithouNutll < 19)
                        ? Icons.build_circle_sharp
                        : Icons.check),
                    Text(
                      'Der BMI ist: ${bmiWithouNutll.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontWeight: bmiWithouNutll > 28 || bmiWithouNutll < 19
                            ? FontWeight.w700
                            : FontWeight.w600,
                        fontSize: bmiWithouNutll > 28 || bmiWithouNutll < 19
                            ? 21.00
                            : 21.00,
                        color: bmiWithouNutll > 28 || bmiWithouNutll < 19
                            ? Colors.red
                            : Colors.black,
                      ),
                    ),
                    Expanded(
                      child: Slider(
                        activeColor: bmiWithouNutll > 28 || bmiWithouNutll < 19
                            ? Colors.red
                            : Colors.black,
                        value: bmiWithouNutll,
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
