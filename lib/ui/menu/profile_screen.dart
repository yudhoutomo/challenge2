import 'dart:ui';

import 'package:challenge2/core/widgets/app_button.dart';
import 'package:challenge2/core/widgets/app_colors.dart';
import 'package:challenge2/core/widgets/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

import '../../core/config/config.dart';
import '../../core/data/model/profile/profile/profile.dart';
import '../../core/utils/status.dart';
import '../../di/injection.dart';
import '../cubit/cubit/cubit/profile/cubit/profile_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [_layout(context)],
    );
  }

  Widget _layout(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileCubit>()..getUser(),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileInitialState && state.status == Status.success) {
            final profile = state.data!;
            return Container(
                width: double.infinity,
                height: double.infinity,
                child: SafeArea(
                    child: Scaffold(
                  backgroundColor: Colors.white,
                  body: CustomScrollView(slivers: [
                    SliverToBoxAdapter(
                        child: Column(children: [_body(context, profile)]))
                  ]),
                )));
          } else {
            return Text('Loading..');
          }
        },
      ),
    );
  }

  Widget _header(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      title: Text("Profile"),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => {context.pop()},
      ),
    );
  }

  Widget _body(BuildContext context, Profile profile) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40),
          Text('Profile',
              textAlign: TextAlign.left,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 21,
                  color: Colors.black)),
          Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(height: 60),
                CircleAvatar(
                  radius: 48, // Image radius
                  backgroundImage: NetworkImage(profile.photo),
                ),
                SizedBox(height: 13),
                Text(profile.name,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black)),
                Text(profile.email,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Colors.black))
              ],
            ),
          ),
          SizedBox(height: 60),
          GestureDetector(
            onTap: () => {context.push('/edit_profile')},
            child: Container(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                  ),
                  Icon(
                    Icons.person,
                    color: Color.fromARGB(255, 111, 109, 109),
                    size: 30.0,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 33),
          GestureDetector(
              onTap: () => {setIsLogout(), context.go('/login')},
              child: Container(
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Logout',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.black),
                      ),
                    ),
                    // ignore: prefer_const_constructors
                    Icon(
                      Icons.logout,
                      color: Colors.red,
                      size: 30.0,
                    ),
                  ],
                ),
              )),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Future<void> setIsLogout() async {
    await getIt<FlutterSecureStorage>()
        .write(key: Config.IS_LOGIN, value: null);
  }
}
