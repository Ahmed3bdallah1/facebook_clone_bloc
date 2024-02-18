import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_clone_bloc/config/routes/routes.dart';
import 'package:facebook_clone_bloc/core/constants/values.dart';
import 'package:facebook_clone_bloc/core/widgets/bottom.dart';
import 'package:facebook_clone_bloc/features/auth/presentation/managers/auth_cubit.dart';
import 'package:facebook_clone_bloc/features/posts/presentation/managers/posts_cubit.dart';
import 'package:facebook_clone_bloc/features/posts/presentation/managers/posts_state.dart';
import 'package:facebook_clone_bloc/features/posts/presentation/view/widgets/post_widgets/icon_button.dart';
import 'package:facebook_clone_bloc/features/posts/presentation/view/widgets/profile_posts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  final String? userId;

  const ProfileScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsCubit, PostsState>(
      listener: (context, state) {},
      builder: (context, state) {
        final myUid = FirebaseAuth.instance.currentUser!.uid;
        final userData =
            AuthCubit.get(context).getUserInfoAsStream(userId ?? myUid);
        return SafeArea(
          child: Scaffold(
            body: StreamBuilder(
                stream: userData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final user = snapshot.data;
                    return CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: Values.defaultPadding,
                            child: Column(
                              children: [
                                ClipOval(
                                  child: CachedNetworkImage(
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.fitWidth,
                                    imageUrl: user!.profilePicUrl,
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(user.fullName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 21)),
                                const SizedBox(height: 20),
                                userId == myUid
                                    ? GeneralButton(
                                        onPressed: () {}, label: 'Add to Story')
                                    : Container(), //AddFriend(user: user),
                                const SizedBox(height: 10),
                                userId == myUid
                                    ? Container()
                                    : GeneralButton(
                                        onPressed: () {
                                          Navigator.of(context).pushNamed(
                                            Routes.chatScreen,
                                            arguments: {
                                              "userId": userId,
                                              "user": user
                                            },
                                          );
                                        },
                                        label: 'Send Message',
                                        color: Colors.transparent,
                                      ),
                                const SizedBox(height: 10),
                                const Divider(color: Colors.grey, thickness: 1),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    children: [
                                      IconTextButton(
                                        icon: user.gender == 'male'
                                            ? Icons.male
                                            : Icons.female,
                                        label: user.gender,
                                      ),
                                      const SizedBox(height: 10),
                                      IconTextButton(
                                        icon: Icons.cake,
                                        label: user.birthDay
                                            .toString()
                                            .substring(0, 10),
                                      ),
                                      const SizedBox(height: 10),
                                      IconTextButton(
                                        icon: Icons.email,
                                        label: user.email,
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(color: Colors.grey, thickness: 1),
                              ],
                            ),
                          ),
                        ),
                        ProfilePosts(userId: userId ?? myUid)
                      ],
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return const Center(child: Icon(Icons.error));
                }),
          ),
        );
      },
    );
  }
}
