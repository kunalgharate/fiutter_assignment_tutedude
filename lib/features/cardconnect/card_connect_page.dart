import 'package:flutter/material.dart';

class CardConnectPage extends StatefulWidget {
  const CardConnectPage({Key? key}) : super(key: key);

  @override
  State<CardConnectPage> createState() => _CardConnectPageState();
}

class _CardConnectPageState extends State<CardConnectPage> {
  // Customizable properties for the card
  double _cardWidth = 300.0;
  double _cardPadding = 16.0;
  double _cardMargin = 20.0;
  double _borderRadius = 12.0;
  double _shadowBlurRadius = 8.0;
  double _shadowSpreadRadius = 2.0;
  double _avatarRadius = 30.0;
  
  // Color properties
  Color _backgroundColor = Colors.blue.shade50;
  Color _shadowColor = Colors.grey;
  Color _nameColor = Colors.black87;
  Color _titleColor = Colors.blue;
  Color _descriptionColor = Colors.grey;
  
  // Content properties
  String _userName = 'John Doe';
  String _userTitle = 'Flutter Developer';
  String _userDescription = 'Passionate about creating beautiful mobile experiences with Flutter';
  String _avatarText = 'JD';
  Color _avatarBackgroundColor = Colors.blue;
  
  // Predefined user profiles for demo
  final List<Map<String, dynamic>> _userProfiles = [
    {
      'name': 'John Doe',
      'title': 'Flutter Developer',
      'description': 'Passionate about creating beautiful mobile experiences with Flutter',
      'avatar': 'JD',
      'avatarColor': Colors.blue,
    },
    {
      'name': 'Sarah Wilson',
      'title': 'UI/UX Designer',
      'description': 'Crafting intuitive and delightful user interfaces for mobile apps',
      'avatar': 'SW',
      'avatarColor': Colors.purple,
    },
    {
      'name': 'Mike Johnson',
      'title': 'Mobile Architect',
      'description': 'Building scalable and robust mobile applications with modern technologies',
      'avatar': 'MJ',
      'avatarColor': Colors.green,
    },
    {
      'name': 'Emily Chen',
      'title': 'Product Manager',
      'description': 'Leading product development and strategy for innovative mobile solutions',
      'avatar': 'EC',
      'avatarColor': Colors.orange,
    },
  ];
  
  int _selectedProfileIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Connect - Styling with Container'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetToDefaults,
            tooltip: 'Reset to Defaults',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),

            // Profile Selectionq
            _buildProfileSelection(),
            
            const SizedBox(height: 16),
            
            // Main Intro Card Display
            Center(
              child: _buildIntroCard(),
            ),
            
            const SizedBox(height: 16),
            
            // Customization Controls
            _buildCustomizationControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildAssignmentInfoCard() {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '2',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Assignment 2: Card Connect',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Objective: Design a visually appealing Intro Card using Container, Row, Column, and Text widgets.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSelection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Profile:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: _userProfiles.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> profile = entry.value;
                
                return ChoiceChip(
                  label: Text(profile['name']),
                  selected: _selectedProfileIndex == index,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _selectedProfileIndex = index;
                        _userName = profile['name'];
                        _userTitle = profile['title'];
                        _userDescription = profile['description'];
                        _avatarText = profile['avatar'];
                        _avatarBackgroundColor = profile['avatarColor'];
                      });
                    }
                  },
                  selectedColor: Colors.indigo.shade100,
                  labelStyle: TextStyle(
                    color: _selectedProfileIndex == index ? Colors.indigo : Colors.grey.shade700,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIntroCard() {
    return Container(
      width: _cardWidth,
      margin: EdgeInsets.all(_cardMargin),
      padding: EdgeInsets.all(_cardPadding),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(_borderRadius),
        boxShadow: [
          BoxShadow(
            color: _shadowColor.withOpacity(0.3),
            spreadRadius: _shadowSpreadRadius,
            blurRadius: _shadowBlurRadius,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Left Side - Profile Picture (CircleAvatar)
          CircleAvatar(
            radius: _avatarRadius,
            backgroundColor: _avatarBackgroundColor,
            child: Text(
              _avatarText,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Right Side - User Information (Column)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Name
                Text(
                  _userName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _nameColor,
                  ),
                ),
                
                const SizedBox(height: 4),
                
                // Title/Role
                Text(
                  _userTitle,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _titleColor,
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // Description/Quote
                Text(
                  _userDescription,
                  style: TextStyle(
                    fontSize: 12,
                    color: _descriptionColor,
                    height: 1.3,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomizationControls() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Customization Controls',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // Card Dimensions
            _buildSlider(
              label: 'Card Width: ${_cardWidth.toInt()}px',
              value: _cardWidth,
              min: 250.0,
              max: 400.0,
              onChanged: (value) => setState(() => _cardWidth = value),
            ),
            
            _buildSlider(
              label: 'Padding: ${_cardPadding.toInt()}px',
              value: _cardPadding,
              min: 8.0,
              max: 32.0,
              onChanged: (value) => setState(() => _cardPadding = value),
            ),
            
            _buildSlider(
              label: 'Margin: ${_cardMargin.toInt()}px',
              value: _cardMargin,
              min: 8.0,
              max: 40.0,
              onChanged: (value) => setState(() => _cardMargin = value),
            ),
            
            const SizedBox(height: 16),
            
            // Color Selection
            const Text(
              'Background Colors:',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            
            Wrap(
              spacing: 8,
              children: [
                Colors.blue.shade50,
                Colors.green.shade50,
                Colors.purple.shade50,
                Colors.orange.shade50,
                Colors.pink.shade50,
                Colors.teal.shade50,
              ].map((color) {
                return GestureDetector(
                  onTap: () => setState(() => _backgroundColor = color),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: _backgroundColor == color ? Colors.black : Colors.grey.shade300,
                        width: _backgroundColor == color ? 2 : 1,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlider({
    required String label,
    required double value,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: ((max - min) / 2).round(),
          activeColor: Colors.indigo,
          onChanged: onChanged,
        ),
      ],
    );
  }

  void _resetToDefaults() {
    setState(() {
      _cardWidth = 300.0;
      _cardPadding = 16.0;
      _cardMargin = 20.0;
      _borderRadius = 12.0;
      _shadowBlurRadius = 8.0;
      _shadowSpreadRadius = 2.0;
      _avatarRadius = 30.0;
      _backgroundColor = Colors.blue.shade50;
      _shadowColor = Colors.grey;
      _selectedProfileIndex = 0;
      _userName = _userProfiles[0]['name'];
      _userTitle = _userProfiles[0]['title'];
      _userDescription = _userProfiles[0]['description'];
      _avatarText = _userProfiles[0]['avatar'];
      _avatarBackgroundColor = _userProfiles[0]['avatarColor'];
    });
  }
}
