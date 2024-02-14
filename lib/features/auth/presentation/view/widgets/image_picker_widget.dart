import 'dart:io';
import 'package:facebook_clone_bloc/core/constants/values.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ImagePickerWidget extends StatelessWidget {
  final File? image;

  const ImagePickerWidget({this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        image != null
            ? CircleAvatar(
                radius: 50,
                backgroundImage: FileImage(image!),
              )
            : const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(Values.profilePicBlank)),
        const Positioned(
          bottom: 0,
          right: 0,
          child: CircleAvatar(
              radius: 20,
              child: FaIcon(FontAwesomeIcons.camera,
                  size: 20, color: Colors.white)),
        )
      ],
    );
  }
}
