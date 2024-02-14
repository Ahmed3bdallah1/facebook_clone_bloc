import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({super.key, required this.icon, this.onPressed});

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            InkWell(
              onTap: onPressed,
              child: ClipOval(
                child: Container(
                  height: 40,
                  width: 40,
                  color: Colors.grey.withOpacity(.3),
                  child: Icon(
                    icon,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
