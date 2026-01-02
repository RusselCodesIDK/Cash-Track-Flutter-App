import 'package:cash_track/constants/box_shadow_decoration.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButtonWidget extends StatelessWidget {
  ButtonWidget({
    super.key,
    required this.title,
    this.buttonColor = Colors.deepPurple,
    this.textColor = Colors.white,
    required this.onTapped,
    this.buttonPadding = 20.0,
  });

  final String title;

  Color buttonColor;
  Color textColor;
  double buttonPadding;

  final Function()? onTapped;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(32.0),
      onTap: () {
        onTapped?.call();
      },
      child: Ink(
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [BoxShadowStyles.defualtBoxShadow],
        ),
        child: Padding(
          padding: EdgeInsets.all(buttonPadding),
          child: Center(
            child: Text(
              title,
              style: TextStyle(color: textColor, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
