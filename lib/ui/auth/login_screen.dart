import 'dart:ui';

import 'package:challenge2/core/config/config.dart';
import 'package:challenge2/core/widgets/app_button.dart';
import 'package:challenge2/core/widgets/app_colors.dart';
import 'package:challenge2/core/widgets/app_snackbar.dart';
import 'package:challenge2/core/widgets/app_textfield.dart';
import 'package:challenge2/ui/cubit/cubit/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

import '../../core/utils/status.dart';
import '../../di/injection.dart';

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

  Widget _body(BuildContext buildcontext) {
    final etEmailController = TextEditingController();
    final etPasswordController = TextEditingController();

    ProgressDialog pr = ProgressDialog(buildcontext,
        type: ProgressDialogType.normal, isDismissible: true, showLogs: true);
    pr.style(progressWidget: const RefreshProgressIndicator());

    return BlocProvider(
      create: (context) => getIt<LoginCubit>(),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          children: [
            SizedBox(height: 40),
            //AppTextField(title: "Title", hint: "Email"),
            AppTextField(
              title: "Email",
              hint: "",
              textHintColor: Colors.black,
              controller: etEmailController,
            ),
            SizedBox(height: 40),
            AppTextField(
              title: "Password",
              hint: "",
              obscure: true,
              textHintColor: Colors.black,
              controller: etPasswordController,
            ),
            SizedBox(height: 70),
            BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is LoginInitialState &&
                    state.status == Status.loading)
                  pr.show();
                else
                  pr.hide();

                if (state is LoginInitialState &&
                    state.status == Status.success) {
                  setIsLogin();
                  buildcontext.go('/menu');
                } else {
                  // if (state is LoginInitialState)
                  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //     content: const Text('Login Failed'),
                  //   ));
                }
              },
              builder: (context, state) {
                return Container(
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
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ))),
                      onPressed: () => {
                            if (etEmailController.text.isEmpty ||
                                etPasswordController.text.isEmpty)
                              {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: const Text(
                                      "Isikan Field Terlebih dahulu"),
                                ))
                              }
                            else
                              {
                                context.read<LoginCubit>().login(
                                      etEmailController.text,
                                      etPasswordController.text,
                                    ),
                              }
                            // EasyLoading.show(
                            //   status: 'loading...',
                            //   maskType: EasyLoadingMaskType.black,
                            // )
                          }),
                );
              },
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
                  onPressed: () => {buildcontext.push('/register')}),
            ),
            SizedBox(height: 20)
          ],
        ),
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

  Future<void> setIsLogin() async {
    await getIt<FlutterSecureStorage>()
        .write(key: 'USER_AUTH_KEY', value: Config.IS_LOGIN);
  }
}
