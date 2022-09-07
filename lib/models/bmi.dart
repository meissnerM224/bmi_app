// ignore_for_file: unnecessary_getters_setters

class BodyMassIndex {
  double _weight;
  double _height;

  BodyMassIndex({
    double weight = 80,
    double heigth = 1.8,
  })  : _weight = weight,
        _height = heigth;
  set height(double height) {
    _height = height;
  }

  set weight(double weight) {
    _weight = weight;
  }

  double get height => _height;
  double get weight => _weight;

  double? get bmi {
    if ((_height < 0.9 || _height > 2.21) ||
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

  static const bmiMin = 10.0;
  static const bmiMax = 60.0;
}
