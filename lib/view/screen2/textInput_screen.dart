import 'package:flutter/material.dart';

class TextInputScreen extends StatefulWidget {
  const TextInputScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<TextInputScreen> createState() => _TextInputScreenState();
}

class _TextInputScreenState extends State<TextInputScreen> {
  double groesse = 180;
  double gewicht = 80.0;

  @override
  Widget build(BuildContext context) {
    final bmi = gewicht / ((groesse * groesse) / 10000);
    var bmiSlider = bmi;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
                        'Körpergröße (m)  :',
                        style: TextStyle(
                          fontSize: 19.00,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          style: const TextStyle(
                            fontSize: 19.00,
                            fontWeight: FontWeight.w600,
                          ),
                          onChanged: (value) {
                            setState(() {
                              final groesseDbl = double.tryParse(value);
                              if (groesseDbl != null) {
                                groesse = groesseDbl;
                              }
                            });
                          },
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: '',
                          ),
                        ),
                      ),
                    ]),
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
                            style: const TextStyle(
                              fontSize: 19.00,
                              fontWeight: FontWeight.w600,
                            ),
                            onChanged: (value) {
                              setState(() {
                                final gewichtDbl = double.tryParse(value);
                                if (gewichtDbl != null) {
                                  gewicht = gewichtDbl;
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
                    Icon((bmi > 28 || bmi < 19)
                        ? Icons.build_circle_sharp
                        : Icons.check),
                    Text(
                      'Der BMI : ${bmi.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontWeight: bmiSlider > 28 || bmiSlider < 19
                            ? FontWeight.w700
                            : FontWeight.w600,
                        fontSize:
                            bmiSlider > 28 || bmiSlider < 19 ? 23.00 : 21.00,
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
                        min: 0.00,
                        max: 15000000000000000000000.00,
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
