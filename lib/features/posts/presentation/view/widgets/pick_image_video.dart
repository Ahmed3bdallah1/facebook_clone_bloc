import 'package:flutter/material.dart';

class PickImageOrVideo extends StatelessWidget {
  const PickImageOrVideo({
    super.key,
    required this.pickImage,
    required this.pickVideo,
  });

  final VoidCallback pickImage;
  final VoidCallback pickVideo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: pickImage,
          child: const Text('Pick Image'),
        ),
        const Divider(),
        TextButton(
          onPressed: pickVideo,
          child: const Text('Pick Video'),
        ),
      ],
    );
  }
}
