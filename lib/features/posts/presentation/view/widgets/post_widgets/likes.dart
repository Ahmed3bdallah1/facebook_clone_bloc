import 'package:facebook_clone_bloc/core/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Likes extends StatelessWidget {
  const Likes({
    super.key,
    required this.likes,
  });

  final List<String> likes;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const CircleAvatar(
          radius: 10,
          backgroundColor: ColorsConstants.blueColor,
          child: FaIcon(
            FontAwesomeIcons.solidThumbsUp,
            color: Colors.white,
            size: 12,
          ),
        ),
        const SizedBox(width: 5),
        Text('${likes.length}', style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}
