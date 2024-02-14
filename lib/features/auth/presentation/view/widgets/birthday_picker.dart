import 'package:facebook_clone_bloc/core/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BirthdayPicker extends StatelessWidget {
  const BirthdayPicker({
    super.key,
    required this.dateTime,
    required this.onPressed,
  });

  final DateTime dateTime;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat.yMMMEd().format(dateTime);
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: ColorsConstants.blackColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Birthday (${DateTime.now().year - dateTime.year} years old)',
              style: const TextStyle(
                color: ColorsConstants.blackColor,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              formattedDate,
              style: const TextStyle(
                fontSize: 18,
                color: ColorsConstants.blackColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
