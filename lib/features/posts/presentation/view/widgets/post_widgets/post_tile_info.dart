import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_clone_bloc/config/routes/routes.dart';
import 'package:facebook_clone_bloc/features/auth/presentation/managers/auth_cubit.dart';
import 'package:facebook_clone_bloc/features/auth/presentation/managers/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostTileInfo extends StatelessWidget {
  final DateTime datePublished;
  final String userId;

  const PostTileInfo(
      {super.key, required this.datePublished, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);

        final data = cubit.getUserInfoAsStream(userId);

        return StreamBuilder(
          stream: data,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipOval(
                      child: Image.asset(
                        "assets/new_account.jpg",
                        height: 40,
                        width: 40,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "User",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "unknown",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Icon(Icons.more_horiz),
                  ],
                ),
              );
            } else if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            Routes.profileScreen,
                            arguments: snapshot.data!.uid,
                          );
                        },
                        child: snapshot.data!.profilePicUrl == ""
                            ? ClipOval(
                                child: Image.asset(
                                "assets/new_account.jpg",
                                height: 40,
                              ))
                            : ClipOval(
                                child: CachedNetworkImage(
                                    height: 40,
                                    width: 40,
                                    fit: BoxFit.fitWidth,
                                    imageUrl: snapshot.data!.profilePicUrl,
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error)))),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              Routes.profileScreen,
                              arguments: snapshot.data!.uid,
                            );
                          },
                          child: Text(snapshot.data!.fullName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                        Text(
                          datePublished.toString().substring(5, 16),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Icon(Icons.more_horiz),
                  ],
                ),
              );
            } else {
              return Center(child: Text(snapshot.error.toString()));
            }
          },
        );
      },
    );
  }
}

// class PostInfoTile extends ConsumerWidget {
//   const PostInfoTile({
//     Key? key,
//     required this.datePublished,
//     required this.userId,
//   }) : super(key: key);
//
//   final DateTime datePublished;
//   final String userId;
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final userInfo = ref.watch(getUsersIdInfoProvider(userId));
//     return userInfo.when(
//       data: (user) {
//
//       },
//       error: (error, stackTrace) {
//
//       },
//       loading: () {

//   }
// }
