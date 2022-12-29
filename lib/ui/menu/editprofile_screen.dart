import 'dart:ui';

import 'package:challenge2/core/widgets/app_button.dart';
import 'package:challenge2/core/widgets/app_colors.dart';
import 'package:challenge2/core/widgets/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

import '../../core/utils/status.dart';
import '../../di/injection.dart';
import '../cubit/cubit/cubit/profile/cubit/profile_cubit.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProgressDialog pr = ProgressDialog(context,
        type: ProgressDialogType.normal, isDismissible: true, showLogs: true);
    pr.style(progressWidget: const RefreshProgressIndicator());

    return BlocProvider(
      create: (context) => getIt<ProfileCubit>()..getUser(),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileInitialState && state.status == Status.success) {
            final profile = state.data!;

            final etNameController = TextEditingController(text: profile.name);

            return Container(
                width: double.infinity,
                height: double.infinity,
                child: SafeArea(
                    child: Scaffold(
                  appBar: AppBar(
                    toolbarHeight: 80,
                    title: const Text("Edit Profile",
                        style: TextStyle(color: Colors.black)),
                    centerTitle: true,
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => {context.pop()},
                    ),
                  ),
                  backgroundColor: Colors.white,
                  body: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(children: <Widget>[
                      Column(
                        children: [
                          const SizedBox(height: 20),
                          CircleAvatar(
                            radius: 48, // Image radius
                            backgroundImage: NetworkImage(profile.photo),
                          ),
                          const SizedBox(height: 50),
                          AppTextField(
                            title: "Name",
                            hint: "",
                            textHintColor: Colors.black,
                            controller: etNameController,
                          ),
                          const SizedBox(height: 70),
                        ],
                      ),
                      Expanded(
                          child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Container(
                            width: double.infinity,
                            height: 60,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            AppColors.green),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            AppColors.green),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ))),
                                onPressed: () => context.pop(),
                                child: const Text("Save",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                    ))),
                          ),
                        ),
                      ))
                    ]),
                  ),
                )));
          } else {
            return Text('Loading..');
          }
        },
      ),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        children: [
          const SizedBox(height: 40),
          const CircleAvatar(
            radius: 48, // Image radius
            // backgroundImage: NetworkImage(
            //     'https://pixabay.com/vectors/blank-profile-picture-mystery-man-973460/'),
          ),
          const SizedBox(height: 40),
          const AppTextField(
            title: "Name",
            hint: "",
            textHintColor: Colors.black,
          ),
          const SizedBox(height: 70),
          Container(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(AppColors.green),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppColors.green),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ))),
                onPressed: () => null,
                child: const Text("Save",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ))),
          ),
        ],
      ),
    );
  }
}
