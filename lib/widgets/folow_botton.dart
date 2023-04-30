import 'package:flutter/material.dart';

class FlollowButton extends StatelessWidget {
  final Color borderColor;
  final Color backgroundColor;
  final String text;
  final Color textColor;
  final Function()? function;
  const FlollowButton({
    Key? key,
    required this.borderColor,
    required this.text,
    required this.textColor,
    required this.backgroundColor,
    this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      child: TextButton(
        onPressed: function,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.center,
          height: 27,
          width: 250,
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
