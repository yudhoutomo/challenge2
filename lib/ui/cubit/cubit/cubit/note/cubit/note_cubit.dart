import 'package:bloc/bloc.dart';
import 'package:challenge2/gen/core/data/model/note/note/note.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/data/datasource/api/user_api.dart';
import '../../../../../../core/utils/status.dart';
import '../../login_cubit.dart';

part 'note_state.dart';

@Injectable()
class NoteCubit extends Cubit<NoteState> {
  NoteCubit(this._api) : super(NoteInitial());

  final UserApi _api;
  var data = <Note>[];

  void getNote() async {
    emit(NoteInitialState(status: Status.loading));
    try {
      final response = await _api.getNote();
      emit(NoteInitialState(status: Status.success, data: response.data));
      data = response.data;
    } catch (e) {
      emit(NoteInitialState(status: Status.error));
    }
  }

  void filter(String query) {
    final result = data.where((element) => element.title.contains(query));
    emit(NoteInitialState(status: Status.success, data: result.toList()));
  }
}
