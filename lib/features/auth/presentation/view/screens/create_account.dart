import 'dart:io';
import 'package:facebook_clone_bloc/core/constants/values.dart';
import 'package:facebook_clone_bloc/core/utils/picker_file.dart';
import 'package:facebook_clone_bloc/core/widgets/bottom.dart';
import 'package:facebook_clone_bloc/core/widgets/text_form_field.dart';
import 'package:facebook_clone_bloc/features/auth/presentation/managers/auth_cubit.dart';
import 'package:facebook_clone_bloc/features/auth/presentation/managers/auth_state.dart';
import 'package:facebook_clone_bloc/features/auth/presentation/view/widgets/birthday_picker.dart';
import 'package:facebook_clone_bloc/features/auth/presentation/view/widgets/gender_picker.dart';
import 'package:facebook_clone_bloc/features/auth/presentation/view/widgets/image_picker_widget.dart';
import 'package:facebook_clone_bloc/features/auth/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    File? image;
    DateTime? birthday;
    String gender = "male";
    final TextEditingController firstNameController = TextEditingController();
    final TextEditingController lastNameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is CreateAccountSuccess) {
          Navigator.pop(context);
          if (!state.user.emailVerified) {
            Navigator.pop(context);
          }
        }
      },
      builder: (context, state) {
        final AuthCubit cubit = AuthCubit.get(context);

        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        image = await pickImage();
                      },
                      child: ImagePickerWidget(image: image),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: GeneralTextField(
                            controller: firstNameController,
                            hintText: 'First name',
                            textInputAction: TextInputAction.next,
                            validator: validateName,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: GeneralTextField(
                            controller: lastNameController,
                            hintText: 'Last name',
                            textInputAction: TextInputAction.next,
                            validator: validateName,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: Values.generalPaddingValue),
                      child: BirthdayPicker(
                        dateTime: birthday ?? DateTime.now(),
                        onPressed: () async {
                          birthday = await pickDate(
                            context: context,
                            date: birthday,
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: Values.generalPaddingValue),
                      child: GenderPicker(
                        gender: gender,
                        onChanged: (value) {
                          gender = value ?? "male";
                        },
                      ),
                    ),
                    GeneralTextField(
                      controller: emailController,
                      hintText: 'Email',
                      textInputAction: TextInputAction.next,
                      validator: validateEmail,
                    ),
                    const SizedBox(height: 10),
                    GeneralTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      textInputAction: TextInputAction.next,
                      validator: validatePassword,
                      isPassword: true,
                    ),
                    const SizedBox(height: 20),
                    if (state is CreateAccountLoading)
                      const Center(child: CircularProgressIndicator())
                    else
                      GeneralButton(
                        onPressed: () {
                          cubit.signUp(
                            fullName:
                                '${firstNameController.text} ${lastNameController.text}',
                            birthday: birthday ?? DateTime.now(),
                            gender: gender,
                            email: emailController.text,
                            password: passwordController.text,
                            image: image,
                          );
                        },
                        label: 'Create Account',
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
