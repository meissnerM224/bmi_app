import 'package:flutter/material.dart';

class SliderInputScreen extends StatefulWidget {
  const SliderInputScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SliderInputScreen> createState() => _SliderInputScreenState();
}

class _SliderInputScreenState extends State<SliderInputScreen> {
  double _groesse = 1.80;
  double _gewicht = 80.0;

  @override
  Widget build(BuildContext context) {
    final bmi = _gewicht / (_groesse * _groesse);
    var bmiSlider = bmi;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Text(
                        'Größe in Meter:',
                        style: TextStyle(
                          fontSize: 21.00,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Expanded(
                        child: Slider(
                          activeColor: Colors.green,
                          inactiveColor: Colors.amber,
                          divisions: 220,
                          label: '${_groesse.toStringAsFixed(2)} m',
                          onChanged: (value) {
                            setState(() {
                              _groesse = value;
                            });
                          },
                          min: 01.10,
                          max: 02.20,
                          value: _groesse,
                        ),
                      ),
                    ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Gewicht in Kg:',
                          style: TextStyle(
                            fontSize: 21.00,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Expanded(
                          child: Slider(
                            activeColor: Colors.red,
                            inactiveColor: Colors.amber,
                            divisions: 180,
                            label: ' ${_gewicht.round()} Kg',
                            onChanged: (value) {
                              setState(() {
                                _gewicht = value;
                              });
                            },
                            min: 20.0,
                            max: 180.0,
                            value: _gewicht,
                          ),
                        ),
                      ],
                    ),
                    Icon((bmi > 28 || bmi < 19)
                        ? Icons.build_circle_sharp
                        : Icons.check),
                    Text(
                      'Der BMI ist: ${bmi.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontWeight: bmiSlider > 28 || bmiSlider < 19
                            ? FontWeight.w700
                            : FontWeight.w600,
                        fontSize:
                            bmiSlider > 28 || bmiSlider < 19 ? 21.00 : 21.00,
                        color: bmi > 28 || bmi < 19 ? Colors.red : Colors.black,
                      ),
                    ),
                    Expanded(
                      child: Slider(
                        activeColor: bmiSlider > 28 || bmiSlider < 19
                            ? Colors.red
                            : Colors.black,
                        value: bmiSlider,
                        onChanged: (value) {},
                        min: 4.00,
                        max: 150.00,
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
