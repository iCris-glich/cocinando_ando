import 'package:flutter/material.dart';

class Botones extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Color? backgroundColor;
  final Color? textColor;

  const Botones({
    super.key,
    required this.onPressed,
    this.backgroundColor = const Color(0xffFFDAB9), // Color predeterminado
    this.textColor = Colors.black,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 5,
        shadowColor: Colors.black87,
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      child: child,
    );
  }
}

class FloatingBoton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Color? backgroundColor;

  const FloatingBoton({
    required this.onPressed,
    required this.child,
    this.backgroundColor = const Color(0xffFFA07A),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      child: child,
    );
  }
}

class TextbutonCustom extends StatelessWidget {
  final Widget widget;
  final VoidCallback? onPressed;
  final Color? textColor;

  const TextbutonCustom({
    required this.onPressed,
    required this.widget,
    this.textColor = Colors.black,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: textColor,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      ),
      child: widget,
    );
  }
}
