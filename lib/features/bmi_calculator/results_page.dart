import 'package:flutter/material.dart';
import 'constants.dart';
import 'reusable_card.dart';
import 'gender_theme.dart';

class ResultsPage extends StatelessWidget {
  final String bmiResult;
  final String resultText;
  final String interpretation;
  final String? gender;
  final String idealBMI;
  final String recommendation;

  const ResultsPage({
    Key? key,
    required this.bmiResult,
    required this.resultText,
    required this.interpretation,
    required this.idealBMI,
    required this.recommendation,
    this.gender,
  }) : super(key: key);

  Map<String, Color> get currentTheme => GenderTheme.getTheme(gender);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
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
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Your BMI value is',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      bmiResult,
                      style: const TextStyle(
                        fontSize: 60.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      resultText,
                      style: const TextStyle(
                        color: Color(0xFF24D876),
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: currentTheme['activeCard']!,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 15),
                      // Gender image
                      Container(
                        width: 100,
                        height: 120,
                        child: gender != null
                            ? Image.asset(
                                gender == 'male' 
                                    ? 'assets/images/male.jpg'
                                    : 'assets/images/female.jpg',
                                fit: BoxFit.contain,
                              )
                            : Container(
                                decoration: const BoxDecoration(
                                  color: Color(0xFF24D876),
                                ),
                                child: CustomPaint(
                                  painter: BodySilhouettePainter(),
                                ),
                              ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                children: [
                                  const Text(
                                    'Ideal BMI Range',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    idealBMI,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF000000),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              interpretation,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: currentTheme['button']!.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: currentTheme['button']!.withOpacity(0.5),
                                ),
                              ),
                              child: Column(
                                children: [
                                  const Text(
                                    'Recommendation',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    recommendation,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                color: currentTheme['button']!,
                margin: const EdgeInsets.only(top: 10.0),
                padding: const EdgeInsets.only(bottom: 20.0),
                width: double.infinity,
                height: kBottomContainerHeight,
                child: const Center(
                  child: Text(
                    'Calculate Again',
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

class BodySilhouettePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF24D876)
      ..style = PaintingStyle.fill;

    final path = Path();
    
    // Simple body silhouette
    double centerX = size.width / 2;
    double headRadius = size.width * 0.15;
    
    // Head
    canvas.drawCircle(Offset(centerX, headRadius + 10), headRadius, paint);
    
    // Body
    path.moveTo(centerX - size.width * 0.2, headRadius * 2 + 10);
    path.lineTo(centerX - size.width * 0.25, size.height * 0.6);
    path.lineTo(centerX - size.width * 0.15, size.height * 0.75);
    path.lineTo(centerX - size.width * 0.1, size.height * 0.95);
    path.lineTo(centerX + size.width * 0.1, size.height * 0.95);
    path.lineTo(centerX + size.width * 0.15, size.height * 0.75);
    path.lineTo(centerX + size.width * 0.25, size.height * 0.6);
    path.lineTo(centerX + size.width * 0.2, headRadius * 2 + 10);
    path.close();
    
    canvas.drawPath(path, paint);
    
    // Arms
    final armPaint = Paint()
      ..color = const Color(0xFF24D876)
      ..strokeWidth = size.width * 0.08
      ..strokeCap = StrokeCap.round;
    
    // Left arm
    canvas.drawLine(
      Offset(centerX - size.width * 0.2, size.height * 0.35),
      Offset(centerX - size.width * 0.4, size.height * 0.55),
      armPaint,
    );
    
    // Right arm
    canvas.drawLine(
      Offset(centerX + size.width * 0.2, size.height * 0.35),
      Offset(centerX + size.width * 0.4, size.height * 0.55),
      armPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
