import 'dart:ui';

import 'package:challenge2/core/widgets/app_button.dart';
import 'package:challenge2/core/widgets/app_colors.dart';
import 'package:challenge2/core/widgets/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
                child: Column(children: [_header(context), _body()]))
          ]),
        )));
  }

  Widget _header(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      title: Text("Register"),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => {context.pop()},
      ),
    );
  }

  Widget _body() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        children: [
          SizedBox(height: 40),
          AppTextField(
            title: "Name",
            hint: "",
            textHintColor: Colors.black,
          ),
          SizedBox(height: 40),
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
          SizedBox(height: 40),
          AppTextField(
            title: "Confirm password",
            hint: "",
            obscure: true,
            textHintColor: Colors.black,
          ),
          SizedBox(height: 70),
          Container(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
                child: Text("Save",
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
                onPressed: () => null),
          ),
        ],
      ),
    );
  }
}
