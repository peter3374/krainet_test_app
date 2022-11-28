import 'package:flutter/material.dart';

class TextFieldWrapper extends StatelessWidget {
  final double width;
  final Widget child;
  const TextFieldWrapper({
    super.key,
    required this.child,
    this.width = 300,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: child,
      ),
    );
  }
}
