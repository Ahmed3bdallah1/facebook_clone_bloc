
import 'package:facebook_clone_bloc/core/constants/color_constants.dart';
import 'package:facebook_clone_bloc/core/constants/values.dart';
import 'package:flutter/material.dart';

class GenderPicker extends StatelessWidget {
  const GenderPicker({
    super.key,
    required this.gender,
    required this.onChanged,
  });

  final String? gender;
  final Function(String? value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Values.generalPaddingValue),
      decoration: BoxDecoration(
        color: ColorsConstants.darkWhiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          GenderTile(
            title: 'Male',
            value: 'male',
            selectedValue: gender,
            onChanged: onChanged,
          ),
          GenderTile(
            title: 'Female',
            value: 'female',
            selectedValue: gender,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class GenderTile extends StatelessWidget {
  const GenderTile({
    Key? key,
    required this.title,
    required this.value,
    required this.selectedValue,
    required this.onChanged,
  }) : super(key: key);

  final String title;
  final String value;
  final String? selectedValue;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Radio.adaptive(
          value: value,
          groupValue: selectedValue,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
