import 'dart:ui';

import 'package:challenge2/core/widgets/app_button.dart';
import 'package:challenge2/core/widgets/app_colors.dart';
import 'package:challenge2/core/widgets/app_textfield.dart';
import 'package:challenge2/di/injection.dart';
import 'package:challenge2/ui/cubit/cubit/cubit/addrequest/cubit/add_request_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

import '../../core/utils/status.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    setEmptyToken();
    return Container(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: Scaffold(
          backgroundColor: Colors.white,
          body: CustomScrollView(slivers: [
            SliverToBoxAdapter(
                child: Column(children: [_header(context), _body(context)]))
          ]),
        )));
  }

  Widget _header(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      title: Text("Register", style: TextStyle(color: Colors.black)),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => {context.pop()},
      ),
    );
  }

  Widget _body(BuildContext context) {
    final etNameController = TextEditingController();
    final etEmailController = TextEditingController();
    final etPasswordController = TextEditingController();
    final etConfirmPasswordController = TextEditingController();

    ProgressDialog pr = ProgressDialog(context,
        type: ProgressDialogType.normal, isDismissible: false, showLogs: true);
    pr.style(progressWidget: const RefreshProgressIndicator());

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        children: [
          SizedBox(height: 40),
          AppTextField(
            controller: etNameController,
            title: "Name",
            hint: "",
            textHintColor: Colors.black,
          ),
          SizedBox(height: 40),
          AppTextField(
            controller: etEmailController,
            title: "Email",
            hint: "",
            textHintColor: Colors.black,
          ),
          SizedBox(height: 40),
          AppTextField(
            controller: etPasswordController,
            title: "Password",
            hint: "",
            obscure: true,
            textHintColor: Colors.black,
          ),
          SizedBox(height: 40),
          AppTextField(
            controller: etConfirmPasswordController,
            title: "Confirm password",
            hint: "",
            obscure: true,
            textHintColor: Colors.black,
          ),
          SizedBox(height: 70),
          BlocProvider(
            create: (context) => getIt<AddRequestUpdateCubit>(),
            child: Container(
              width: double.infinity,
              height: 60,
              child: BlocConsumer<AddRequestUpdateCubit, AddRequestState>(
                listener: (context, state) {
                  if (state is AddRequestInitialState &&
                      state.status == Status.loading)
                    pr.show();
                  else
                    pr.hide();

                  if (state is AddRequestInitialState &&
                      state.status == Status.success) {
                    context.pop();
                  } else {}
                },
                builder: (context, state) {
                  return ElevatedButton(
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
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ))),
                      onPressed: () => {
                            if (etNameController.text.isEmpty ||
                                etEmailController.text.isEmpty ||
                                etPasswordController.text.isEmpty ||
                                etConfirmPasswordController.text.isEmpty)
                              {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: const Text(
                                      "Isikan Field Terlebih dahulu"),
                                ))
                              }
                            else
                              {
                                if (etPasswordController.text !=
                                    etConfirmPasswordController.text)
                                  {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: const Text(
                                          "Password tidak sama dengan confirm password"),
                                    ))
                                  }
                                else
                                  {
                                    context
                                        .read<AddRequestUpdateCubit>()
                                        .addUser(
                                          etNameController.text,
                                          etEmailController.text,
                                          etPasswordController.text,
                                        ),
                                  }
                              }
                          });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> setEmptyToken() async {
    await getIt<FlutterSecureStorage>().write(key: 'AUTH_TOKEN', value: null);
  }
}
