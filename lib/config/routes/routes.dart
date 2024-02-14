import 'package:facebook_clone_bloc/app/home/home_page.dart';
import 'package:facebook_clone_bloc/features/auth/presentation/view/screens/create_account.dart';
import 'package:facebook_clone_bloc/features/auth/presentation/view/screens/login_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const createAccount = '/create-account';
  static const login = '/login';
  static const home = '/home';
  static const chatScreen = '/chat-screen';
  static const chatsScreen = '/chats-screen';
  static const storiesScreen = '/stories-screen';
  static const profileScreen = '/profile-screen';
  static const createPost = '/create-post';
  static const createStory = '/create-story';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case createAccount:
        return MaterialPageRoute(builder: (_) => const CreateAccountPage());
      //
      // case createPost:
      //   return MaterialPageRoute(builder: (_) => const AddPostScreen());
      //
      // case createStory:
      //   return MaterialPageRoute(builder: (_) => const CreateStoryScreen());

      case login:
        return MaterialPageRoute(builder: (_) => const Login());

      // case chatScreen:
      //   final arguments = settings.arguments as Map<String, dynamic>;
      //   return MaterialPageRoute(
      //       builder: (_) => ChatScreen(
      //             userId: arguments["userId"],
      //             user: arguments["user"],
      //           ));
      //
      // case chatsScreen:
      //   return MaterialPageRoute(builder: (_) => const ChatsScreen());
      //
      // case storiesScreen:
      //   final stories = settings.arguments as List<StoryModel>;
      //   return MaterialPageRoute(
      //       builder: (_) => StoriesScreen(stories: stories));
      //
      // case profileScreen:
      //   return MaterialPageRoute(
      //       builder: (_) =>
      //           ProfileScreen(userId: settings.arguments as String));
      //
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());

      default:
        return MaterialPageRoute(builder: (_) => const Login());
    }
  }
}
