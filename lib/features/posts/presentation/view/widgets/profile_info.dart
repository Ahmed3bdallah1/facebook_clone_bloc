import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_clone_bloc/features/auth/presentation/managers/auth_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder(
        stream: AuthCubit.get(context).getUserInfoAsStream(currentUser),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            final user = snapshot.data;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipOval(
                  child: CachedNetworkImage(
                    height: 40,
                    width: 40,
                    fit: BoxFit.fitWidth,
                    imageUrl: user!.profilePicUrl,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.fullName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Text(
                      'Public',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    )
                  ],
                )
              ],
            );
          }

          return Center(child: Text(snapshot.error.toString()));
        });
  }
}
