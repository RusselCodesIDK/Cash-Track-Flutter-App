import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButtonWidget extends StatelessWidget {
  ButtonWidget({
    super.key,

    required this.buttonDecoration,
    required this.onTapped,
    required this.content,

    this.textColor = Colors.white,
    this.inkWellBorderRadius = 16.0,
  });

  Color textColor;
  double inkWellBorderRadius;
  Widget content;

  final BoxDecoration buttonDecoration;

  final Function()? onTapped;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(inkWellBorderRadius),
      onTap: () {
        onTapped?.call();
      },
      child: Ink(decoration: buttonDecoration, child: content),
    );
  }
}
