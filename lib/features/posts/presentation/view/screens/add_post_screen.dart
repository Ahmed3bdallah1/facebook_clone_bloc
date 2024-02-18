import 'dart:io';
import 'package:facebook_clone_bloc/core/constants/color_constants.dart';
import 'package:facebook_clone_bloc/core/constants/values.dart';
import 'package:facebook_clone_bloc/core/utils/picker_file.dart';
import 'package:facebook_clone_bloc/core/widgets/bottom.dart';
import 'package:facebook_clone_bloc/core/widgets/toast.dart';
import 'package:facebook_clone_bloc/features/posts/presentation/managers/posts_cubit.dart';
import 'package:facebook_clone_bloc/features/posts/presentation/view/widgets/image_video_widgets/image_video_container.dart';
import 'package:facebook_clone_bloc/features/posts/presentation/view/widgets/profile_info.dart';
import 'package:flutter/material.dart';
import '../widgets/pick_image_video.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  late final TextEditingController controller;
  File? file;
  String fileType = 'image';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
  }

  Future<void> uploadPost() async {
    await PostsCubit.get(context)
        .post(post: controller.text, file: file!, postType: fileType)
        .then((value) {
      print(value);
      showToastMessage(text: "post uploaded successfully");
      Navigator.pop(context);
    }).catchError((e) {
      showToastMessage(text: e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: Container(
              decoration: BoxDecoration(
                color: ColorsConstants.greyColor.withOpacity(.6),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey),
              ),
              child: TextButton(
                onPressed: uploadPost,
                child: const Text('Post'),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: Values.defaultPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProfileInfo(),
              // post text field
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'What\'s on your mind?',
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: ColorsConstants.darkGreyColor,
                  ),
                ),
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 10,
              ),
              const SizedBox(height: 20),
              file != null
                  ? ImageVideoContainer(fileType: fileType, file: file!)
                  : PickImageOrVideo(
                      pickImage: () async {
                        fileType = 'image';
                        file = await pickImage();
                        setState(() {});
                      },
                      pickVideo: () async {
                        fileType = 'video';
                        file = await pickVideo();
                        setState(() {});
                      },
                    ),
              const SizedBox(height: 20),
              GeneralButton(
                onPressed: uploadPost,
                label: 'Post',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
