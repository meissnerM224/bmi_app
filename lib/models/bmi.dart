// ignore_for_file: unnecessary_getters_setters

import 'package:flutter_riverpod/flutter_riverpod.dart';

class BodyMassIndex {
  final double _weight;
  final double _height;

  const BodyMassIndex({
    double weight = 19,
    double height = 0.9,
  })  : _weight = weight < 19
            ? 19
            : weight > 180
                ? 180
                : weight,
        _height = height < 0.9
            ? 0.9
            : height > 2.2
                ? 2.2
                : height;

  BodyMassIndex copyWith({double? weight, double? height}) {
    return BodyMassIndex(weight: weight ?? _weight, height: height ?? _height);
  }

  double get height => _height;
  double get weight => _weight;

  double get bmi {
    double bmi = _weight / (_height * _height);
    if (bmi > bmiMax) {
      return bmiMax;
    }
    if (bmi < bmiMin) {
      return bmiMin;
    }
    return bmi;
  }

  static const bmiMin = 4.0;
  static const bmiMax = 70.0;
  static const heightMin = 0.9;
  static const heightMax = 2.2;
  static const weightMin = 19;
  static const weightMax = 180;
}

class BodyMassIndexNotifier extends StateNotifier<BodyMassIndex> {
  BodyMassIndexNotifier([super.state = const BodyMassIndex()]);
  void updateWeight(double weight) {
    state = state.copyWith(weight: weight);
  }

  void updateHeight(double height) {
    state = state.copyWith(height: height);
  }
}
