import 'package:facebook_clone_bloc/core/constants/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(BuildContext context) => BlocProvider.of(context);
  int currentIndex = 0;

  void changeTab(int value) {
    currentIndex = value;
    emit(ChangeNavigationState());
  }

  List<Tab> homeScreenTabs(int index) {
    return [
      Tab(
        icon: Icon(
          index == 0 ? Icons.home : Icons.home_outlined,
          color: index == 0 ? ColorsConstants.blueColor : Colors.grey,
          size: 30,
        ),
      ),
      Tab(
        icon: Icon(
          index == 1 ? Icons.group : Icons.group_outlined,
          color: index == 1 ? ColorsConstants.blueColor : Colors.grey,
          size: 30,
        ),
      ),
      Tab(
        icon: Icon(
          index == 2
              ? CupertinoIcons.videocam_circle_fill
              : CupertinoIcons.videocam_circle,
          color: index == 2 ? ColorsConstants.blueColor : Colors.grey,
          size: 30,
        ),
      ),
      Tab(
        icon: Icon(
          index == 3 ? CupertinoIcons.bell_fill : CupertinoIcons.bell,
          color: index == 3 ? ColorsConstants.blueColor : Colors.grey,
          size: 30,
        ),
      ),
      Tab(
        icon: Icon(
          index == 4 ? Icons.account_circle : Icons.account_circle_outlined,
          color: index == 4 ? ColorsConstants.blueColor : Colors.grey,
          size: 30,
        ),
      ),
    ];
  }

  List<Widget> screens = [
    SizedBox(),
    SizedBox(),
    SizedBox(),
    SizedBox(),
    SizedBox(),
    // const PostsPage(),
    // const FriendsScreen(),
    // const VideosScreen(),
    // const Center(
    //   child: Text('Notifications Screen'),
    // ),
    // ProfileScreen(userId: userId),
  ];
}
