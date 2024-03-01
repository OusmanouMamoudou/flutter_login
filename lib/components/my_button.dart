import 'package:flutter/material.dart';
import 'package:login/const.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      // Material widget for button styling with elevation and rounded corners
      child: Material(
        elevation: 5,
        color: Colors.green,
        borderRadius: kRadius,
        // MaterialButton for user interaction
        child: MaterialButton(
          onPressed: onPressed,

          minWidth: double.infinity,
          height: 42,
          // Display button text with white color
          child: Text(text, style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
