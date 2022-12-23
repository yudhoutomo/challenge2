import 'dart:ui';

import 'package:challenge2/core/widgets/app_button.dart';
import 'package:challenge2/core/widgets/app_colors.dart';
import 'package:challenge2/core/widgets/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: Scaffold(
          backgroundColor: Colors.white,
          body: CustomScrollView(slivers: [
            SliverToBoxAdapter(
                child: Column(children: [_header(), _body(context)]))
          ]),
        )));
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        children: [
          SizedBox(height: 40),
          //AppTextField(title: "Title", hint: "Email"),
          AppTextField(
            title: "Email",
            hint: "",
            textHintColor: Colors.black,
          ),
          SizedBox(height: 40),
          AppTextField(
            title: "Password",
            hint: "",
            obscure: true,
            textHintColor: Colors.black,
          ),
          SizedBox(height: 70),
          Container(
            width: double.infinity,
            height: 53,
            child: ElevatedButton(
                child: Text("Login",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    )),
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(AppColors.green),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppColors.green),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ))),
                onPressed: () => {context.go('/menu')}),
          ),
          SizedBox(height: 13),
          Container(
            width: double.infinity,
            height: 53,
            child: ElevatedButton(
                child: Text("Register",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                    )),
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: AppColors.green)))),
                onPressed: () => {context.push('/register')}),
          ),
          SizedBox(height: 20)
        ],
      ),
    );
  }

  Widget _header() {
    return Container(
      height: 250,
      width: double.infinity,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: AppColors.green,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(60),
        ),
        border: Border.all(
          width: 3,
          color: AppColors.green,
          style: BorderStyle.solid,
        ),
      ),
      child: Container(
        height: 80,
        alignment: Alignment.bottomRight,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 24, right: 20),
              alignment: Alignment.bottomLeft,
              child: Text('My Notes',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white)),
            ),
            Container(
              padding: EdgeInsets.only(left: 24, right: 20),
              alignment: Alignment.bottomLeft,
              child: Text('Please login with your email and password',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
