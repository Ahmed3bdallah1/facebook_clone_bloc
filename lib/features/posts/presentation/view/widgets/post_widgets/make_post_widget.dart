import 'package:facebook_clone_bloc/config/routes/routes.dart';
import 'package:facebook_clone_bloc/core/constants/color_constants.dart';
import 'package:facebook_clone_bloc/features/posts/presentation/view/widgets/profile_small_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MakePostWidget extends StatelessWidget {
  const MakePostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(Routes.createPost);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ProfileImage(
                  userId: FirebaseAuth.instance.currentUser!.uid,
                ),
              ),
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: ColorsConstants.darkGreyColor),
                  ),
                  child: const Text(
                    "What's on your mind?",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Icon(
                  FontAwesomeIcons.solidImages,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
