import 'package:bmi_app/models/bmi.dart';
import 'package:bmi_app/view/screen2/textInput_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

final refBmi = StateNotifierProvider<BodyMassIndexNotifier, BodyMassIndex>(
    (ref) => BodyMassIndexNotifier());

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const TextInputScreen(),
    );
  }
}
