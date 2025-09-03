import 'dart:math';

class CalculatorBrain {
  final int height;
  final int weight;

  CalculatorBrain({required this.height, required this.weight});

  double _bmi = 0;

  String calculateBMI() {
    _bmi = weight / pow(height / 100, 2);
    return _bmi.toStringAsFixed(1);
  }

  String getResult() {
    if (_bmi >= 25) {
      return 'Overweight';
    } else if (_bmi > 18.5) {
      return 'Normal';
    } else {
      return 'Underweight';
    }
  }

  String getInterpretation() {
    if (_bmi >= 25) {
      return 'You have a higher than normal body weight. Try to exercise more and maintain a balanced diet.';
    } else if (_bmi >= 18.5) {
      return 'You have a normal body weight. Good job! Keep maintaining your healthy lifestyle.';
    } else {
      return 'You have a lower than normal body weight. Consider eating more nutritious foods and consult a healthcare provider.';
    }
  }

  String getIdealBMIRange() {
    return '18.5 - 24.9';
  }

  String getRecommendation() {
    if (_bmi >= 25) {
      double idealWeight = (22 * pow(height / 100, 2)).toDouble(); // Using BMI 22 as ideal
      double weightToLose = weight - idealWeight;
      return 'To reach ideal BMI, consider reducing ${weightToLose.toStringAsFixed(1)} kg through healthy diet and exercise.';
    } else if (_bmi < 18.5) {
      double idealWeight = (20 * pow(height / 100, 2)).toDouble(); // Using BMI 20 as ideal
      double weightToGain = idealWeight - weight;
      return 'To reach ideal BMI, consider gaining ${weightToGain.toStringAsFixed(1)} kg through nutritious meals and strength training.';
    } else {
      return 'Your BMI is in the healthy range. Maintain your current lifestyle with regular exercise and balanced nutrition.';
    }
  }
}
