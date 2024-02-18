import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_clone_bloc/config/routes/routes.dart';
import 'package:facebook_clone_bloc/features/auth/presentation/managers/auth_cubit.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final String userId;
  final double? height;
  final double? width;

  const ProfileImage(
      {super.key, required this.userId, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AuthCubit.get(context).getUserInfoAsStream(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ClipOval(
              child: Image.asset(
                "assets/new_account.jpg",
                height: 40,
                width: 40,
              ),
            );
          }

          if (snapshot.hasData) {
            final user = snapshot.data;

            return InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                  Routes.profileScreen,
                  arguments: user.uid,
                );
              },
              child: ClipOval(
                child: CachedNetworkImage(
                  height: 40,
                  width: 40,
                  fit: BoxFit.fitWidth,
                  imageUrl: user!.profilePicUrl,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            );
          }

          return SizedBox(
              height: 40,
              width: 40,
              child: ClipOval(child: Image.asset("assets/new_account.jpg")));
        });
  }
}

class ProfileImageClipRect extends StatelessWidget {
  final String userId;
  final double? height;
  final double? width;

  const ProfileImageClipRect(
      {super.key, required this.userId, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AuthCubit.get(context).getUserInfoAsStream(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: 120,
              width: 120,
              child: Image.asset(
                "assets/new_account.jpg",
                height: height ?? 40,
                width: width ?? 40,
              ),
            );
          }

          if (snapshot.hasData) {
            final user = snapshot.data;

            return SizedBox(
                height: 120,
                width: 120,
                child: CachedNetworkImage(
                  fit: BoxFit.fitWidth,
                  imageUrl: user!.profilePicUrl,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ));
          }

          return SizedBox(
              height: 40,
              width: 40,
              child: ClipOval(child: Image.asset("assets/new_account.jpg")));
        });
  }
}
