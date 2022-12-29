import 'package:challenge2/gen/core/data/model/note/note/note.dart';
import 'package:challenge2/ui/auth/login_screen.dart';
import 'package:challenge2/ui/auth/register_screen.dart';
import 'package:challenge2/ui/menu/editprofile_screen.dart';
import 'package:challenge2/ui/menu/note/home_screen.dart';
import 'package:challenge2/ui/menu/note/note_add_screen.dart';
import 'package:challenge2/ui/menu/note/note_update_screen.dart';
import 'package:flutter/material.dart';
import '../ui/menu_screen.dart';
import 'package:go_router/go_router.dart';
import 'splash/screen/splash_screen.dart';

var router = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const SplashScreen(),
  ),
  GoRoute(
    path: '/menu',
    builder: (context, state) => const MenuScreen(),
  ),
  GoRoute(
    path: '/login',
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    path: '/register',
    builder: (context, state) => const RegisterScreen(),
  ),
  GoRoute(
    path: '/home',
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    path: '/note_add',
    builder: (context, state) => const NoteAddScreen(),
  ),
  GoRoute(
    path: '/edit_profile',
    builder: (context, state) => const EditProfileScreen(),
  ),
  GoRoute(
      path: '/note_update',
      builder: (context, state) {
        final data = state.extra;
        if (data is Note) {
          return NoteUpdateScreen(data: data);
        }
        return const Scaffold(
          body: Center(
            child: Text('Not found'),
          ),
        );
      })
]);

Widget get errorPage => const Center(
      child: SizedBox(
        width: 200,
        child: Text('Error, maybe you forgot to include required obj'),
      ),
    );
