import 'package:flutter/material.dart';
import 'icon_content.dart';
import 'reusable_card.dart';
import 'constants.dart';
import 'round_icon_button.dart';
import 'results_page.dart';
import 'calculator_brain.dart';
import 'gender_theme.dart';

enum Gender {
  male,
  female,
}

enum HeightUnit {
  cm,
  feet,
}

class BMICalculatorPage extends StatefulWidget {
  const BMICalculatorPage({Key? key}) : super(key: key);

  @override
  State<BMICalculatorPage> createState() => _BMICalculatorPageState();
}

class _BMICalculatorPageState extends State<BMICalculatorPage> {
  Gender? selectedGender;
  HeightUnit selectedHeightUnit = HeightUnit.cm;
  double height = 180.0;
  int weight = 60;
  int age = 20;

  Map<String, Color> get currentTheme {
    String? genderString = selectedGender == Gender.male ? 'male' : 
                          selectedGender == Gender.female ? 'female' : null;
    return GenderTheme.getTheme(genderString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI CALCULATOR'),
        backgroundColor: currentTheme['background']!,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        color: currentTheme['background']!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: selectedGender == Gender.male
                          ? BoxDecoration(
                              color: const Color(0xFF4AE1DD).withOpacity(0.3),
                              borderRadius: BorderRadius.circular(10),
                            )
                          : null,
                      child: ReusableCard(
                        onPress: () {
                          setState(() {
                            selectedGender = Gender.male;
                          });
                        },
                        color: selectedGender == Gender.male
                            ? kActiveCardColor
                            : kInactiveCardColor,
                        cardChild: const IconContent(
                          iconPath: 'assets/images/male_icon.jpg',
                          label: 'Male',
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: selectedGender == Gender.female
                          ? BoxDecoration(
                              color: const Color(0xFFFE719E).withOpacity(0.3),
                              borderRadius: BorderRadius.circular(10),
                            )
                          : null,
                      child: ReusableCard(
                        onPress: () {
                          setState(() {
                            selectedGender = Gender.female;
                          });
                        },
                        color: selectedGender == Gender.female
                            ? kActiveCardColor
                            : kInactiveCardColor,
                        cardChild: const IconContent(
                          iconPath: 'assets/images/female_icon.jpg',
                          label: 'Female',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ReusableCard(
                color: kActiveCardColor,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Height',
                      style: kLabelTextStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          selectedHeightUnit == HeightUnit.cm 
                              ? height.round().toString()
                              : height.toStringAsFixed(1),
                          style: kNumberTextStyle,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          selectedHeightUnit == HeightUnit.cm ? 'cm' : 'ft',
                          style: kLabelTextStyle,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (selectedHeightUnit == HeightUnit.feet) {
                                selectedHeightUnit = HeightUnit.cm;
                                height = height * 30.48; // Convert feet to cm
                              }
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: selectedHeightUnit == HeightUnit.cm
                                  ? currentTheme['accent']!
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Text(
                              'CM',
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (selectedHeightUnit == HeightUnit.cm) {
                                selectedHeightUnit = HeightUnit.feet;
                                height = height / 30.48; // Convert cm to feet
                              }
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: selectedHeightUnit == HeightUnit.feet
                                  ? currentTheme['accent']!
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Text(
                              'FEET',
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        inactiveTrackColor: const Color(0xFF8D8E98),
                        activeTrackColor: Colors.white,
                        thumbColor: currentTheme['accent']!,
                        overlayColor: currentTheme['accent']!.withOpacity(0.16),
                        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 15.0),
                        overlayShape: const RoundSliderOverlayShape(overlayRadius: 30.0),
                      ),
                      child: Slider(
                        value: height,
                        min: selectedHeightUnit == HeightUnit.cm ? 120.0 : 4.0,
                        max: selectedHeightUnit == HeightUnit.cm ? 220.0 : 7.0,
                        onChanged: (double newValue) {
                          setState(() {
                            height = newValue;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: ReusableCard(
                      color: kActiveCardColor,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Weight',
                            style: kLabelTextStyle,
                          ),
                          Text(
                            weight.toString(),
                            style: kNumberTextStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RoundIconButton(
                                icon: Icons.remove,
                                onPressed: () {
                                  setState(() {
                                    weight--;
                                  });
                                },
                              ),
                              const SizedBox(width: 10.0),
                              RoundIconButton(
                                icon: Icons.add,
                                onPressed: () {
                                  setState(() {
                                    weight++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ReusableCard(
                      color: kActiveCardColor,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Age',
                            style: kLabelTextStyle,
                          ),
                          Text(
                            age.toString(),
                            style: kNumberTextStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RoundIconButton(
                                icon: Icons.remove,
                                onPressed: () {
                                  setState(() {
                                    age--;
                                  });
                                },
                              ),
                              const SizedBox(width: 10.0),
                              RoundIconButton(
                                icon: Icons.add,
                                onPressed: () {
                                  setState(() {
                                    age++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                CalculatorBrain calc = CalculatorBrain(
                  height: selectedHeightUnit == HeightUnit.cm ? height.round() : (height * 30.48).round(),
                  weight: weight,
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultsPage(
                      bmiResult: calc.calculateBMI(),
                      resultText: calc.getResult(),
                      interpretation: calc.getInterpretation(),
                      idealBMI: calc.getIdealBMIRange(),
                      recommendation: calc.getRecommendation(),
                      gender: selectedGender == Gender.male ? 'male' : 'female',
                    ),
                  ),
                );
              },
              child: Container(
                color: currentTheme['button']!,
                margin: const EdgeInsets.only(top: 10.0),
                padding: const EdgeInsets.only(bottom: 20.0),
                width: double.infinity,
                height: kBottomContainerHeight,
                child: const Center(
                  child: Text(
                    'Calculate BMI',
                    style: kLargeButtonTextStyle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
