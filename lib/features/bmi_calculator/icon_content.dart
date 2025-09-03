import 'package:flutter/material.dart';

class IconContent extends StatelessWidget {
  final String? iconPath;
  final IconData? icon;
  final String label;

  const IconContent({
    Key? key,
    this.iconPath,
    this.icon,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (iconPath != null)
          Image.asset(
            iconPath!,
            width: 80.0,
            height: 80.0,
          )
        else if (icon != null)
          Icon(
            icon!,
            size: 80.0,
            color: Colors.white,
          ),
        const SizedBox(height: 15.0),
        Text(
          label,
          style: const TextStyle(
            fontSize: 18.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
