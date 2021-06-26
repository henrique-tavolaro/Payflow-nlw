import 'package:flutter/material.dart';
import 'package:nwl/shared/theme/app_colors.dart';
import 'package:nwl/shared/theme/app_text_style.dart';

class DialogButton extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Color color;
  final VoidCallback onPressed;

  const DialogButton({Key? key,
    required this.text,
    required this.style,
    required this.color,
    required this.onPressed,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: color,
          border: Border.all(color: AppColors.stroke)
        ),
        width: 156,
        height: 55,
        child: Center(
            child: Text(text,
              style: style,)
        ),
      ),
    );
  }
}
