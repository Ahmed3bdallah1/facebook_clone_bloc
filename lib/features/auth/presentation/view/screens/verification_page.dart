import 'package:facebook_clone_bloc/config/routes/routes.dart';
import 'package:facebook_clone_bloc/core/constants/values.dart';
import 'package:facebook_clone_bloc/core/widgets/bottom.dart';
import 'package:facebook_clone_bloc/core/widgets/toast.dart';
import 'package:facebook_clone_bloc/features/auth/presentation/managers/auth_cubit.dart';
import 'package:facebook_clone_bloc/features/auth/presentation/managers/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: Values.defaultPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GeneralButton(
                  onPressed: () async {
                    await cubit.verifyEmail();
                  },
                  label: 'Verify Email',
                ),
                const SizedBox(height: 20),
                GeneralButton(
                  onPressed: () async {
                    final user = FirebaseAuth.instance.currentUser!;
                    await user.reload();
                    final emailVerified = user.emailVerified;
                    if (emailVerified == true) {
                      Navigator.pushReplacementNamed(context, Routes.home);
                    } else {
                      showToastMessage(
                          text: "Your account is not verified yet");
                    }
                  },
                  label: 'Refresh',
                ),
                const SizedBox(height: 20),
                GeneralButton(
                  onPressed: () {
                    cubit.signOut();
                  },
                  label: 'Change Email',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
