import 'dart:ui';

import 'package:challenge2/core/widgets/app_button.dart';
import 'package:challenge2/core/widgets/app_colors.dart';
import 'package:challenge2/core/widgets/app_textfield.dart';
import 'package:challenge2/di/injection.dart';
import 'package:challenge2/gen/core/data/model/note/note/note.dart';
import 'package:challenge2/ui/menu/note/note_update_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/status.dart';
import '../../cubit/cubit/cubit/note/cubit/note_cubit.dart';
import 'item_note.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<NoteCubit>()..getNote(),
      child: SafeArea(
        child: Scaffold(
          appBar: const MyCustomAppBar(height: 120),
          body: BlocBuilder<NoteCubit, NoteState>(
            builder: (context, state) {
              if (state is NoteInitialState && state.status == Status.success) {
                final notes = state.data!;
                return ListView.builder(
                    itemCount: notes.length,
                    itemBuilder: (BuildContext context, int index) => ItemNote(
                        data: notes[index],
                        onClick: (data) => goToSecondScreen(context, data)));
                // context.push(
                //     '/note_update',
                //     extra: notes[index],
                //   )));
              } else {
                return Text('Loading..');
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _layout(BuildContext context) {
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
    return Container(
      child: Column(
        children: [
          Container(
            //color: Color.fromARGB(255, 89, 174, 244),
            color: Colors.white,
            alignment: Alignment.centerLeft,
            height: 120,
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(12),
                    child: Container(
                      child: TextField(
                        onChanged: (value) =>
                            context.read<NoteCubit>().filter(value),
                        // context.read<FlightCubit>().filter(value),
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            filled: true,
                            fillColor: Color.fromARGB(255, 248, 245, 245),
                            border: OutlineInputBorder(),
                            hintText: 'Find Notes'),
                        cursorColor: Colors.black,
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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

  void goToSecondScreen(BuildContext _context, Note data) async {
    var result = await Navigator.push(
        _context,
        new MaterialPageRoute(
          builder: (BuildContext context) => new NoteUpdateScreen(data: data),
          fullscreenDialog: true,
        )).whenComplete(() => {_context.read<NoteCubit>()..getNote()});
  }
}

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const MyCustomAppBar({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Column(
            children: [
              Container(
                //color: Color.fromARGB(255, 89, 174, 244),
                color: Colors.white,
                alignment: Alignment.centerLeft,
                height: 120,
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(12),
                        child: Container(
                          child: TextField(
                            onChanged: (value) =>
                                context.read<NoteCubit>().filter(value),
                            // context.read<FlightCubit>().filter(value),
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.search),
                                filled: true,
                                fillColor: Color.fromARGB(255, 248, 245, 245),
                                border: OutlineInputBorder(),
                                hintText: 'Find Notes'),
                            cursorColor: Colors.black,
                            style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
