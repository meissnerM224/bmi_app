// ignore_for_file: unnecessary_getters_setters

class BodyMassIndex {
  final double _weight;
  final double _height;

  BodyMassIndex({
    double weight = 19,
    double heigth = 0.9,
  })  : _weight = weight,
        _height = heigth;

  double get height => _height;
  double get weight => _weight;

  double? get bmi {
    if ((_height < 0.9 || _height > 2.20) ||
        (_weight < 19.0 || _weight > 180.0)) {
      return null;
    }
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
}
