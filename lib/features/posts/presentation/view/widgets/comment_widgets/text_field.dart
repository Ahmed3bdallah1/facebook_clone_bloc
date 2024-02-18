import 'package:facebook_clone_bloc/core/constants/color_constants.dart';
import 'package:facebook_clone_bloc/features/posts/presentation/managers/posts_cubit.dart';
import 'package:flutter/material.dart';

class CommentTextField extends StatefulWidget {
  const CommentTextField({
    super.key,
    required this.postId,
  });

  final String postId;

  @override
  State<StatefulWidget> createState() => _CommentTextFieldState();
}

class _CommentTextFieldState extends State<CommentTextField> {
  late final TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> comment() async {
      final text = controller.text.trim();
      controller.clear();
      await PostsCubit.get(context).comment(
        text: text,
        postId: widget.postId,
      );
    }

    return Container(
      height: 60,
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.only(
          left: 15,
        ),
        decoration: BoxDecoration(
          color: ColorsConstants.greyColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Write a comment',
            // border: InputBorder.none,
            suffixIcon: IconButton(
              onPressed: comment,
              icon: const Icon(Icons.send),
            ),
          ),
        ),
      ),
    );
  }
}
