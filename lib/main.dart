import 'package:bmi_app/models/bmi.dart';
import 'package:bmi_app/view/screen2/textInput_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final bmi = BodyMassIndex();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: TextInputScreen(bmi),
    );
  }
}
