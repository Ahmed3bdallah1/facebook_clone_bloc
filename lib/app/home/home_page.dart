import 'package:facebook_clone_bloc/app/home/home_cubit.dart';
import 'package:facebook_clone_bloc/app/home/home_state.dart';
import 'package:facebook_clone_bloc/core/constants/color_constants.dart';
import 'package:facebook_clone_bloc/core/constants/tabs.dart';
import 'package:facebook_clone_bloc/core/widgets/circle_icon_button.dart';
import 'package:facebook_clone_bloc/features/auth/presentation/managers/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('facebook',
                style: TextStyle(
                  color: ColorsConstants.blueColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                )),
            actions: [
              const CircleIconButton(
                icon: FontAwesomeIcons.magnifyingGlass,
              ),
              CircleIconButton(
                onPressed: () {
                  // Navigator.pushNamed(context, Routes.chatsScreen);
                },
                icon: FontAwesomeIcons.facebookMessenger,
              ),
              CircleIconButton(
                onPressed: () {
                  AuthCubit.get(context).signOut();
                },
                icon: FontAwesomeIcons.arrowRightFromBracket,
              )
            ],
            bottom: TabBar(
              tabs: TabsConstants.homeScreenTabs(_tabController.index),
              controller: _tabController,
              onTap: (index) {
                cubit.changeTab(index);
              },
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: cubit.screens,
          ),
        );
      },
    );
  }
}
