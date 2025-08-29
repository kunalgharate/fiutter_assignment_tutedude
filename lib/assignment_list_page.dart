import 'package:fiutter_assignment/features/displayimage/displayimage_page.dart';
import 'package:fiutter_assignment/features/cardconnect/card_connect_page.dart';
import 'package:fiutter_assignment/features/interactive_counter/interactive_counter_page.dart';
import 'package:fiutter_assignment/features/fun_packages/fun_packages_page.dart';
import 'package:flutter/material.dart';

class AssignmentListPage extends StatelessWidget {
  const AssignmentListPage({Key? key}) : super(key: key);

  // Static list of 8 assignment names
  static const List<String> assignmentNames = [
    'Display Image from Assets & Network',
    'Card Connect - Styling with Container',
    'Creative Use of setState()',
    'Creative Use of Packages - Build a Fun App',
    'Form Validation & Input Fields',
    'Navigation & Routing',
    'State Management Basics',
    'API Integration & HTTP Requests',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Assignments'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 1.2,
          ),
          itemCount: assignmentNames.length,
          itemBuilder: (context, index) {
            return AssignmentButton(
              assignmentNumber: index + 1,
              assignmentName: assignmentNames[index],
              onPressed: () => _navigateToAssignment(context, index + 1, assignmentNames[index]),
            );
          },
        ),
      ),
    );
  }

  void _navigateToAssignment(BuildContext context, int assignmentNumber, String assignmentName) {
    // Handle navigation to specific assignment pages
    switch (assignmentNumber) {
      case 1:
        // Navigate to Display Image assignment
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DisplayImagePage()),
        );
        break;
      case 2:
        // Navigate to Card Connect assignment
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CardConnectPage()),
        );
        break;
      case 3:
        // Navigate to Interactive Counter assignment
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const InteractiveCounterPage()),
        );
        break;
      case 4:
        // Navigate to Fun Packages assignment
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FunPackagesPage()),
        );
        break;
      case 5:
        // Navigate to Form Validation assignment
        _showAssignmentDialog(context, assignmentNumber, assignmentName, 'Form Validation Assignment - Coming Soon!');
        break;
      case 6:
        // Navigate to Navigation assignment
        _showAssignmentDialog(context, assignmentNumber, assignmentName, 'Navigation Assignment - Coming Soon!');
        break;
      case 7:
        // Navigate to State Management assignment
        _showAssignmentDialog(context, assignmentNumber, assignmentName, 'State Management Assignment - Coming Soon!');
        break;
      case 8:
        // Navigate to API Integration assignment
        _showAssignmentDialog(context, assignmentNumber, assignmentName, 'API Integration Assignment - Coming Soon!');
        break;
      default:
        _showAssignmentDialog(context, assignmentNumber, assignmentName, 'Assignment not implemented yet');
    }
  }

  void _showAssignmentDialog(BuildContext context, int assignmentNumber, String assignmentName, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$assignmentNumber',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Assignment $assignmentNumber',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Assignment Name:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      assignmentName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                message,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
            if (assignmentNumber >= 1 && assignmentNumber <= 4)
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (assignmentNumber == 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const DisplayImagePage()),
                    );
                  } else if (assignmentNumber == 2) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CardConnectPage()),
                    );
                  } else if (assignmentNumber == 3) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const InteractiveCounterPage()),
                    );
                  } else if (assignmentNumber == 4) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FunPackagesPage()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Open'),
              ),
          ],
        );
      },
    );
  }
}

class AssignmentButton extends StatelessWidget {
  final int assignmentNumber;
  final String assignmentName;
  final VoidCallback onPressed;

  const AssignmentButton({
    Key? key,
    required this.assignmentNumber,
    required this.assignmentName,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              colors: [
                Colors.blue.shade300,
                Colors.blue.shade600,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '$assignmentNumber',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  assignmentName,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: (assignmentNumber >= 1 && assignmentNumber <= 4) ? Colors.green : Colors.orange,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    (assignmentNumber >= 1 && assignmentNumber <= 4) ? 'Available' : 'Coming Soon',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
