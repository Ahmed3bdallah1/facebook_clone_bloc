import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class GeneralButton extends StatelessWidget {
  const GeneralButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.color = ColorsConstants.lightBlueColor,
    this.height = 50,
  });

  final VoidCallback? onPressed;
  final String label;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: onPressed == null ? Colors.transparent : color,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: ColorsConstants.darkBlueColor,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color:
                  (color == ColorsConstants.lightBlueColor && onPressed != null)
                      ? ColorsConstants.realWhiteColor
                      : ColorsConstants.darkBlueColor,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
