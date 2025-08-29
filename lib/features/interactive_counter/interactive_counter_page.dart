import 'package:flutter/material.dart';
import 'dart:math';

class InteractiveCounterPage extends StatefulWidget {
  const InteractiveCounterPage({Key? key}) : super(key: key);

  @override
  State<InteractiveCounterPage> createState() => _InteractiveCounterPageState();
}

class _InteractiveCounterPageState extends State<InteractiveCounterPage>
    with TickerProviderStateMixin {
  int _counter = 0;
  Color _backgroundColor = Colors.blue.shade100;
  String _currentEmoji = '😐';
  double _fontSize = 24.0;
  bool _isCircle = true;
  String _currentQuote = 'Tap to start counting!';
  
  final Random _random = Random();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  final List<Color> _colors = [
    Colors.red.shade100,
    Colors.blue.shade100,
    Colors.green.shade100,
    Colors.purple.shade100,
    Colors.orange.shade100,
    Colors.pink.shade100,
    Colors.teal.shade100,
    Colors.indigo.shade100,
  ];

  final List<String> _emojis = ['😐', '🙂', '😄', '🤩', '🥳', '🤯', '🚀', '⭐'];
  
  final List<String> _quotes = [
    'Keep going!',
    'You\'re doing great!',
    'Amazing progress!',
    'Fantastic work!',
    'Incredible dedication!',
    'You\'re unstoppable!',
    'Phenomenal effort!',
    'Absolutely brilliant!',
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      _backgroundColor = _colors[_random.nextInt(_colors.length)];
      _currentEmoji = _emojis[_counter % _emojis.length];
      _fontSize = 24.0 + (_counter * 2.0).clamp(0, 60);
      _isCircle = !_isCircle;
      _currentQuote = _quotes[_counter % _quotes.length];
    });
    
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
  }

  void _decrementCounter() {
    if (_counter > 0) {
      setState(() {
        _counter--;
        _backgroundColor = _colors[_random.nextInt(_colors.length)];
        _currentEmoji = _emojis[_counter % _emojis.length];
        _fontSize = (24.0 + (_counter * 2.0)).clamp(24, 84);
        _isCircle = !_isCircle;
        _currentQuote = _counter == 0 ? 'Back to the start!' : _quotes[_counter % _quotes.length];
      });
      
      _animationController.forward().then((_) {
        _animationController.reverse();
      });
    }
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
      _backgroundColor = Colors.blue.shade100;
      _currentEmoji = '😐';
      _fontSize = 24.0;
      _isCircle = true;
      _currentQuote = 'Fresh start!';
    });
  }

  void _randomizeAll() {
    setState(() {
      _backgroundColor = _colors[_random.nextInt(_colors.length)];
      _currentEmoji = _emojis[_random.nextInt(_emojis.length)];
      _fontSize = (20.0 + _random.nextDouble() * 40).clamp(20, 60);
      _isCircle = _random.nextBool();
      _currentQuote = _quotes[_random.nextInt(_quotes.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interactive Counter'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.shuffle),
            onPressed: _randomizeAll,
            tooltip: 'Randomize',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetCounter,
            tooltip: 'Reset',
          ),
        ],
      ),
      backgroundColor: _backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated Shape Container
            AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: _isCircle 
                          ? BorderRadius.circular(75) 
                          : BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 300),
                          style: TextStyle(
                            fontSize: _fontSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                          child: Text('$_counter'),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _currentEmoji,
                          style: const TextStyle(fontSize: 32),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 40),
            
            // Quote Display
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                _currentQuote,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.deepPurple,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            
            const SizedBox(height: 50),
            
            // Control Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Decrement Button
                FloatingActionButton(
                  onPressed: _decrementCounter,
                  heroTag: "decrement",
                  backgroundColor: Colors.red.shade400,
                  child: const Icon(Icons.remove, color: Colors.white),
                ),
                
                // Increment Button
                FloatingActionButton.extended(
                  onPressed: _incrementCounter,
                  heroTag: "increment",
                  backgroundColor: Colors.green.shade400,
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text(
                    'Tap Me!',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 30),
            
            // Stats Display
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.deepPurple.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem('Count', '$_counter'),
                  _buildStatItem('Font Size', '${_fontSize.toInt()}px'),
                  _buildStatItem('Shape', _isCircle ? 'Circle' : 'Square'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
      ],
    );
  }
}
