import 'package:facebook_clone_bloc/config/routes/routes.dart';
import 'package:facebook_clone_bloc/core/constants/values.dart';
import 'package:facebook_clone_bloc/core/widgets/bottom.dart';
import 'package:facebook_clone_bloc/core/widgets/text_form_field.dart';
import 'package:facebook_clone_bloc/features/auth/presentation/managers/auth_cubit.dart';
import 'package:facebook_clone_bloc/features/auth/presentation/managers/auth_state.dart';
import 'package:facebook_clone_bloc/features/auth/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          AuthCubit cubit = AuthCubit.get(context);

          void login(BuildContext context) async {
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
              cubit.signIn(
                email: emailController.text,
                password: passwordController.text,
              );
            }
          }

          return SingleChildScrollView(
            child: Padding(
              padding: Values.defaultPadding,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: height * .05, bottom: height * .09),
                    child: Image.asset(
                      'assets/facebook.png',
                      width: 60,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          GeneralTextField(
                            controller: emailController,
                            hintText: 'Email',
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validator: validateEmail,
                          ),
                          const SizedBox(height: 15),
                          GeneralTextField(
                            controller: passwordController,
                            hintText: 'Password',
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            isPassword: true,
                            validator: validatePassword,
                          ),
                          const SizedBox(height: 15),
                          GeneralButton(
                            onPressed: () => login(context),
                            label: 'Login',
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            'Forget Password',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * .1,
                  ),
                  Column(
                    children: [
                      GeneralButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            Routes.createAccount,
                          );
                        },
                        label: 'Create new account',
                        color: Colors.transparent,
                      ),
                      Image.asset(
                        'assets/meta.png',
                        height: 50,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
