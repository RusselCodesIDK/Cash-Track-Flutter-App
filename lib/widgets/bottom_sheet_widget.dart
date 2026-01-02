import 'package:flutter/material.dart';

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({super.key, required this.content, this.title = ''});

  final Widget content;
  final String title;

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.title.isNotEmpty)
            Text(
              widget.title,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          const SizedBox(height: 12),

          Flexible(child: widget.content),
        ],
      ),
    );
  }
}
