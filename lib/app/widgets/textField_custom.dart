// ignore: file_names
import 'package:flutter/material.dart';

class TextfieldCustom extends StatefulWidget {
  final String hintText;
  final dynamic labelText;
  final TextEditingController controller;
  final Color backgroundColor;
  bool isObscure = false;
  final TextInputType? textType;
  final TextInputAction? textInputAction;

  TextfieldCustom({
    super.key,
    required this.isObscure,
    required this.hintText,
    required this.labelText,
    required this.controller,
    required this.backgroundColor,
    this.textType,
    this.textInputAction,
  });

  @override
  State<TextfieldCustom> createState() => _TextfieldCustomState();
}

class _TextfieldCustomState extends State<TextfieldCustom> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.isObscure,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          color: Colors.black87,
        ),
        labelText: widget.labelText,
        labelStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        filled: true,
        fillColor: widget.backgroundColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 2,
            color: Colors.black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      keyboardType: widget.textType,
      textInputAction: widget.textInputAction,
    );
  }
}

class TextfieldCustomMultiline extends StatefulWidget {
  final String hintText;
  final dynamic labelText;
  final TextEditingController controller;
  final Color backgroundColor;
  final TextInputType? textType;
  final TextInputAction? textInputAction;

  const TextfieldCustomMultiline({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.controller,
    required this.backgroundColor,
    this.textType,
    this.textInputAction,
  });

  @override
  _TextfieldCustomStates createState() => _TextfieldCustomStates();
}

class _TextfieldCustomStates extends State<TextfieldCustomMultiline> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      maxLines: null,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          color: Colors.black87,
        ),
        labelText: widget.labelText,
        labelStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        filled: true,
        fillColor: widget.backgroundColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 2,
            color: Colors.black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
    );
  }
}
