import 'package:facebook_clone_bloc/app/home/home_cubit.dart';
import 'package:facebook_clone_bloc/features/posts/data/repos/posts_repo_imp.dart';
import 'package:facebook_clone_bloc/features/posts/presentation/managers/posts_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home/home_page.dart';
import '../config/routes/routes.dart';
import '../config/themes/dark_theme.dart';
import '../config/themes/light_theme.dart';
import '../features/auth/data/repo/auth_repo_imp.dart';
import '../features/auth/presentation/managers/auth_cubit.dart';
import '../features/auth/presentation/view/screens/login_screen.dart';
import '../features/auth/presentation/view/screens/verification_page.dart';

class FaceBook extends StatelessWidget {
  const FaceBook({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(AuthRepoImp()),
        ),
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
        BlocProvider(
          create: (context) => PostsCubit(PostsRepoImp()),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: 'Facebook clone',
        theme: lightTheme,
        darkTheme: darkTheme,
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasData) {
              final User? user = snapshot.data;
              if (user!.emailVerified) {
                return const HomePage();
              } else {
                return const VerificationPage();
              }
            }

            return const Login();
          },
        ),
        onGenerateRoute: Routes.onGenerateRoute,
      ),
    );
  }
}
