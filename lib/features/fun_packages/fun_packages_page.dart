import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FunPackagesPage extends StatefulWidget {
  const FunPackagesPage({Key? key}) : super(key: key);

  @override
  State<FunPackagesPage> createState() => _FunPackagesPageState();
}

class _FunPackagesPageState extends State<FunPackagesPage>
    with TickerProviderStateMixin {
  String _currentImage = '';
  bool _isLoading = false;
  String _selectedAnimal = 'cat';
  int _diceValue = 1;
  Color _backgroundColor = Colors.blue.shade100;
  String _randomQuote = 'Tap to get started!';
  
  late AnimationController _diceAnimationController;
  late AnimationController _imageAnimationController;
  late Animation<double> _diceRotation;
  late Animation<double> _imageScale;
  
  final Random _random = Random();
  
  final List<Color> _backgroundColors = [
    Colors.red.shade100,
    Colors.blue.shade100,
    Colors.green.shade100,
    Colors.purple.shade100,
    Colors.orange.shade100,
    Colors.pink.shade100,
    Colors.teal.shade100,
    Colors.indigo.shade100,
    Colors.amber.shade100,
    Colors.cyan.shade100,
  ];
  
  final List<String> _funQuotes = [
    'Life is pawsome! 🐾',
    'Stay purrfect! 😸',
    'Woof-derful day ahead! 🐕',
    'Feeling lucky today! 🍀',
    'Roll with it! 🎲',
    'Paws and reflect! 🐾',
    'Fur real fun! 🎉',
    'Tail-wagging good time! 🐕‍🦺',
    'Meow-nificent vibes! 😺',
    'Dice to meet you! 🎯',
  ];

  @override
  void initState() {
    super.initState();
    _diceAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _imageAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _diceRotation = Tween<double>(
      begin: 0,
      end: 4 * 3.14159, // 2 full rotations
    ).animate(CurvedAnimation(
      parent: _diceAnimationController,
      curve: Curves.elasticOut,
    ));
    
    _imageScale = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _imageAnimationController,
      curve: Curves.bounceOut,
    ));
    
    _fetchRandomImage();
  }

  @override
  void dispose() {
    _diceAnimationController.dispose();
    _imageAnimationController.dispose();
    super.dispose();
  }

  Future<void> _fetchRandomImage() async {
    setState(() {
      _isLoading = true;
    });

    try {
      String url;
      if (_selectedAnimal == 'cat') {
        url = 'https://api.thecatapi.com/v1/images/search';
      } else {
        url = 'https://dog.ceo/api/breeds/image/random';
      }

      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        String imageUrl;
        
        if (_selectedAnimal == 'cat') {
          imageUrl = data[0]['url'];
        } else {
          imageUrl = data['message'];
        }
        
        setState(() {
          _currentImage = imageUrl;
          _isLoading = false;
        });
        
        _imageAnimationController.forward().then((_) {
          _imageAnimationController.reverse();
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _currentImage = '';
      });
    }
  }

  void _rollDice() {
    _diceAnimationController.forward().then((_) {
      _diceAnimationController.reset();
    });
    
    setState(() {
      _diceValue = _random.nextInt(6) + 1;
      _backgroundColor = _backgroundColors[_random.nextInt(_backgroundColors.length)];
      _randomQuote = _funQuotes[_random.nextInt(_funQuotes.length)];
    });
  }

  void _switchAnimal() {
    setState(() {
      _selectedAnimal = _selectedAnimal == 'cat' ? 'dog' : 'cat';
    });
    _fetchRandomImage();
  }

  void _randomizeEverything() {
    _rollDice();
    _fetchRandomImage();
    setState(() {
      _backgroundColor = _backgroundColors[_random.nextInt(_backgroundColors.length)];
      _randomQuote = _funQuotes[_random.nextInt(_funQuotes.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fun Packages App'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.shuffle),
            onPressed: _randomizeEverything,
            tooltip: 'Randomize All',
          ),
        ],
      ),
      backgroundColor: _backgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Animal Image Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Random ${_selectedAnimal == 'cat' ? '🐱 Cat' : '🐶 Dog'}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Switch(
                        value: _selectedAnimal == 'dog',
                        onChanged: (value) => _switchAnimal(),
                        activeColor: Colors.deepPurple,
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Image Display
                  AnimatedBuilder(
                    animation: _imageScale,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _imageScale.value,
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.deepPurple.withOpacity(0.3), width: 2),
                          ),
                          child: _isLoading
                              ? const Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator(color: Colors.deepPurple),
                                      SizedBox(height: 10),
                                      Text('Fetching cute image...'),
                                    ],
                                  ),
                                )
                              : _currentImage.isNotEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(13),
                                      child: Image.network(
                                        _currentImage,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            color: Colors.grey.shade200,
                                            child: const Center(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.error_outline, size: 50, color: Colors.grey),
                                                  Text('Failed to load image'),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                      child: const Center(
                                        child: Text('Tap button to load image'),
                                      ),
                                    ),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  ElevatedButton.icon(
                    onPressed: _fetchRandomImage,
                    icon: const Icon(Icons.refresh),
                    label: Text('New ${_selectedAnimal == 'cat' ? 'Cat' : 'Dog'}!'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Dice Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    '🎲 Lucky Dice',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  AnimatedBuilder(
                    animation: _diceRotation,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _diceRotation.value,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.deepPurple, width: 3),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              _getDiceEmoji(_diceValue),
                              style: const TextStyle(fontSize: 40),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  Text(
                    'You rolled: $_diceValue',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.deepPurple,
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  ElevatedButton.icon(
                    onPressed: _rollDice,
                    icon: const Icon(Icons.casino),
                    label: const Text('Roll Dice!'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Quote Section
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.deepPurple.withOpacity(0.8),
                    Colors.purple.withOpacity(0.6),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.format_quote,
                    color: Colors.white,
                    size: 30,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _randomQuote,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton.extended(
                  onPressed: _randomizeEverything,
                  heroTag: "randomize",
                  backgroundColor: Colors.green,
                  icon: const Icon(Icons.shuffle, color: Colors.white),
                  label: const Text(
                    'Surprise Me!',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getDiceEmoji(int value) {
    switch (value) {
      case 1:
        return '⚀';
      case 2:
        return '⚁';
      case 3:
        return '⚂';
      case 4:
        return '⚃';
      case 5:
        return '⚄';
      case 6:
        return '⚅';
      default:
        return '⚀';
    }
  }
}
