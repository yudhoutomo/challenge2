import 'dart:ui';

import 'package:challenge2/core/widgets/app_button.dart';
import 'package:challenge2/core/widgets/app_colors.dart';
import 'package:challenge2/core/widgets/app_textfield.dart';
import 'package:challenge2/gen/core/data/model/note/note/note.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

import '../../../core/utils/status.dart';
import '../../../di/injection.dart';
import '../../cubit/cubit/cubit/addrequest/cubit/add_request_cubit.dart';
import '../../splash/widget/loading.dart';

class NoteUpdateScreen extends StatelessWidget {
  const NoteUpdateScreen({super.key, required this.data});

  final Note data;

  @override
  Widget build(BuildContext buildContext) {
    final etTitleController = TextEditingController(text: data.title);
    final etContentController = TextEditingController(text: data.content);

    ProgressDialog pr = ProgressDialog(buildContext,
        type: ProgressDialogType.normal, isDismissible: true, showLogs: true);
    pr.style(progressWidget: const RefreshProgressIndicator());

    return Container(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: BlocProvider(
          create: (context) => getIt<AddRequestUpdateCubit>(),
          child: BlocConsumer<AddRequestUpdateCubit, AddRequestState>(
            listener: (context, state) {
              // TODO: implement listener
              if (state is AddRequestInitialState &&
                  state.status == Status.loading)
                pr.show();
              else {
                // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //   content: const Text("Sukses"),
                // ));
                Navigator.pop(context, "hello");
                pr.hide();
              }

              // if (state is AddRequestInitialState &&
              //     state.status == Status.success) {
              // } else {}
            },
            builder: (context, state) {
              return Scaffold(
                  appBar: AppBar(
                    toolbarHeight: 80,
                    title: Text(""),
                    centerTitle: true,
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => {
                        if (etTitleController.text.isEmpty &&
                            etContentController.text.isEmpty)
                          context
                              .read<AddRequestUpdateCubit>()
                              .deleteNote(data.id)
                        else
                          context.read<AddRequestUpdateCubit>().updateNote(
                                data.id,
                                etTitleController.text,
                                etContentController.text,
                              ),
                      },
                    ),
                  ),
                  backgroundColor: Colors.white,
                  body: Padding(
                      padding: EdgeInsets.fromLTRB(40, 0, 20, 0),
                      child: Column(children: <Widget>[
                        const SizedBox(height: 40),
                        TextField(
                          controller: etTitleController,
                          decoration: InputDecoration(
                            labelText: 'Title',
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                        SizedBox(height: 40),
                        TextField(
                          controller: etContentController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            labelText: 'Content',
                          ),
                        ),
                      ])));
            },
          ),
        )));
  }
}
