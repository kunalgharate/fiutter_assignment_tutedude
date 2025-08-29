import 'package:flutter/material.dart';

class DisplayImagePage extends StatefulWidget {
  const DisplayImagePage({Key? key}) : super(key: key);

  @override
  State<DisplayImagePage> createState() => _DisplayImagePageState();
}

class _DisplayImagePageState extends State<DisplayImagePage> {
  double _imageWidth = 200.0;
  double _imageHeight = 200.0;
  BoxFit _selectedFit = BoxFit.cover;
  Alignment _selectedAlignment = Alignment.center;
  bool _showAssetImage = true; // Toggle between asset and network image

  // Network image URL
  final String _networkImageUrl = 'https://images.unsplash.com/photo-1697784442712-a9888c89d89d?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aXNoYSUyMGZvdW5kYXRpb258ZW58MHx8MHx8fDA%3D';

  final List<BoxFit> _fitOptions = [
    BoxFit.cover,
    BoxFit.contain,
    BoxFit.fill,
    BoxFit.fitWidth,
    BoxFit.fitHeight,
    BoxFit.scaleDown,
  ];

  final List<Alignment> _alignmentOptions = [
    Alignment.center,
    Alignment.topLeft,
    Alignment.topCenter,
    Alignment.topRight,
    Alignment.centerLeft,
    Alignment.centerRight,
    Alignment.bottomLeft,
    Alignment.bottomCenter,
    Alignment.bottomRight,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_showAssetImage ? 'Asset Image Display' : 'Network Image Display'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(_showAssetImage ? Icons.cloud : Icons.folder),
            onPressed: () {
              setState(() {
                _showAssetImage = !_showAssetImage;
              });
            },
            tooltip: _showAssetImage ? 'Switch to Network Image' : 'Switch to Asset Image',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image Type Toggle
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.image, color: Colors.teal),
                    const SizedBox(width: 8),
                    Text(
                      _showAssetImage ? 'Asset Image' : 'Network Image',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Switch(
                      value: !_showAssetImage,
                      onChanged: (value) {
                        setState(() {
                          _showAssetImage = !value;
                        });
                      },
                      activeColor: Colors.teal,
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Main Image Display
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300, width: 2),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 4), // Shadow position
                  ),
                ],
                color: Colors.white, // Background color for shadow
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: _showAssetImage ? _buildAssetImage() : _buildNetworkImage(),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Image Properties Card
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Image Properties',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    
                    const SizedBox(height: 16),
                    
                    // BoxFit Dropdown
                    _buildDropdown<BoxFit>(
                      label: 'Box Fit',
                      value: _selectedFit,
                      items: _fitOptions,
                      itemBuilder: (fit) => Text(_getBoxFitName(fit)),
                      onChanged: (fit) {
                        if (fit != null) {
                          setState(() {
                            _selectedFit = fit;
                          });
                        }
                      },
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Alignment Dropdown
                    _buildDropdown<Alignment>(
                      label: 'Alignment',
                      value: _selectedAlignment,
                      items: _alignmentOptions,
                      itemBuilder: (alignment) => Text(_getAlignmentName(alignment)),
                      onChanged: (alignment) {
                        if (alignment != null) {
                          setState(() {
                            _selectedAlignment = alignment;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Reset Button
            ElevatedButton.icon(
              onPressed: _resetToDefaults,
              icon: const Icon(Icons.refresh),
              label: const Text('Reset to Defaults'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
            
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildAssetImage() {
    return Image.asset(
      'assets/images/img.jpg',
      width: _imageWidth,
      height: _imageHeight,
      fit: _selectedFit,
      alignment: _selectedAlignment,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.grey.shade200,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.broken_image,
                size: 64,
                color: Colors.grey,
              ),
              SizedBox(height: 8),
              Text(
                'Asset Image not found\nPlease add image to assets/images/',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNetworkImage() {
    return Image.network(
      _networkImageUrl,
      width: _imageWidth,
      height: _imageHeight,
      fit: _selectedFit,
      alignment: _selectedAlignment,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Container(
          color: Colors.grey.shade100,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                  color: Colors.teal,
                ),
                const SizedBox(height: 16),
                Text(
                  'Loading image...',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
                if (loadingProgress.expectedTotalBytes != null)
                  Text(
                    '${(loadingProgress.cumulativeBytesLoaded / 1024).toStringAsFixed(1)} KB / ${(loadingProgress.expectedTotalBytes! / 1024).toStringAsFixed(1)} KB',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.red.shade50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red.shade400,
              ),
              const SizedBox(height: 8),
              Text(
                'Failed to load network image',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Check your internet connection',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red.shade400,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  Widget _buildDropdown<T>({
    required String label,
    required T value,
    required List<T> items,
    required Widget Function(T) itemBuilder,
    required ValueChanged<T?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        DropdownButtonFormField<T>(
          value: value,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          items: items.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: itemBuilder(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  String _getBoxFitName(BoxFit fit) {
    switch (fit) {
      case BoxFit.cover:
        return 'Cover';
      case BoxFit.contain:
        return 'Contain';
      case BoxFit.fill:
        return 'Fill';
      case BoxFit.fitWidth:
        return 'Fit Width';
      case BoxFit.fitHeight:
        return 'Fit Height';
      case BoxFit.scaleDown:
        return 'Scale Down';
      default:
        return 'None';
    }
  }

  String _getAlignmentName(Alignment alignment) {
    if (alignment == Alignment.center) return 'Center';
    if (alignment == Alignment.topLeft) return 'Top Left';
    if (alignment == Alignment.topCenter) return 'Top Center';
    if (alignment == Alignment.topRight) return 'Top Right';
    if (alignment == Alignment.centerLeft) return 'Center Left';
    if (alignment == Alignment.centerRight) return 'Center Right';
    if (alignment == Alignment.bottomLeft) return 'Bottom Left';
    if (alignment == Alignment.bottomCenter) return 'Bottom Center';
    if (alignment == Alignment.bottomRight) return 'Bottom Right';
    return 'Custom';
  }

  void _resetToDefaults() {
    setState(() {
      _imageWidth = 200.0;
      _imageHeight = 200.0;
      _selectedFit = BoxFit.cover;
      _selectedAlignment = Alignment.center;
    });
  }


}
