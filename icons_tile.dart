import 'package:flutter/material.dart';

class IconsTile extends StatelessWidget {
  final String imagePath;
  const IconsTile({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[50],
      ),
      child: Image.asset(
        imagePath,
        height: 40,
      ),
    );
  }
}
