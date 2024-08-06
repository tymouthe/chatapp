import 'package:flutter/material.dart';

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // Determine the icon color based on the brightness of the current theme
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDarkMode ? Colors.grey : Colors.black;

    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        Icons.arrow_back,
        color: iconColor,
      ),
    );
  }
}
