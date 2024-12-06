import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  final Color color;
  final Color textColor;
  final String buttonText;

  MyButton({this.color = Colors.blue, this.buttonText = "Button", this.textColor = Colors.white});

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0), // Tambahkan padding
      child: Container(
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            widget.buttonText,
            style: TextStyle(color: widget.textColor),
          ),
        ),
      ),
    );
  }
}
