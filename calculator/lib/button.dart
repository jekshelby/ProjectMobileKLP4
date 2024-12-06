import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  final Color color;
  final Color textColor;
  final String buttonText;
  final VoidCallback? buttonTapped;

  const MyButton({
    Key? key,
    this.color = Colors.blue,
    this.textColor = Colors.white,
    this.buttonText = "Button",
    this.buttonTapped,
  }) : super(key: key);

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.buttonTapped,
      child: Padding(
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
      ),
    );
  }
}
