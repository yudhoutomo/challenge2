import 'package:bloc/bloc.dart';
import 'package:challenge2/gen/core/data/model/addrequest/add_request/add_request.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/data/datasource/api/user_api.dart';
import '../../../../../../core/utils/status.dart';

part 'add_request_state.dart';

@Injectable()
class AddRequestCubit extends Cubit<AddRequestState> {
  AddRequestCubit(this._api) : super(AddRequestInitial());

  final UserApi _api;

  void addNote(String title, String content) async {
    emit(AddRequestInitialState(status: Status.loading));
    try {
      final response = await _api.addNote(title, content);
      debugPrint('messageRESPONSE');
      debugPrint(response.message);
      if (response.message.contains("success")) {
        emit(AddRequestInitialState(
            status: Status.success, data: response.data));
      } else {
        emit(AddRequestInitialState(status: Status.error));
      }
    } catch (e) {
      emit(AddRequestInitialState(status: Status.success));
      debugPrint('messageRESPONSECatch');
    }
  }
}

@Injectable()
class AddRequestUpdateCubit extends Cubit<AddRequestState> {
  AddRequestUpdateCubit(this._api) : super(AddRequestInitial());

  final UserApi _api;

  void updateNote(String id, String title, String content) async {
    emit(AddRequestInitialState(status: Status.loading));

    try {
      final response = await _api.updateNote(id, title, content);
      debugPrint('messageRESPONSE');
      debugPrint(response.message);
      if (response.message.contains("success")) {
        emit(AddRequestInitialState(
            status: Status.success,
            data: AddRequest(message: response.message)));
      } else {
        emit(AddRequestInitialState(status: Status.error));
      }
    } catch (e) {
      emit(AddRequestInitialState(status: Status.success));
      debugPrint('messageRESPONSECatch');
      debugPrint(e.toString());
    }
  }

  void deleteNote(String id) async {
    emit(AddRequestInitialState(status: Status.loading));
    try {
      final response = await _api.deleteNote(id);
      debugPrint('messageRESPONSE');
      debugPrint(response.message);
      if (response.message.contains("success")) {
        emit(AddRequestInitialState(
            status: Status.success, data: response.data));
      } else {
        emit(AddRequestInitialState(status: Status.error));
      }
    } catch (e) {
      emit(AddRequestInitialState(status: Status.success));
      debugPrint('messageRESPONSECatch');
      debugPrint(e.toString());
    }
  }

  void addUser(String name, String email, String password) async {
    emit(AddRequestInitialState(status: Status.loading));

    try {
      final response = await _api.addUser(name, email, password);
      debugPrint('messageRESPONSE');
      debugPrint(response.message);
      if (response.message.contains("success")) {
        emit(AddRequestInitialState(
            status: Status.success,
            data: AddRequest(message: response.message)));
      } else {
        emit(AddRequestInitialState(status: Status.error));
      }
    } catch (e) {
      emit(AddRequestInitialState(status: Status.success));
      debugPrint('messageRESPONSECatch');
      debugPrint(e.toString());
    }
  }
}
