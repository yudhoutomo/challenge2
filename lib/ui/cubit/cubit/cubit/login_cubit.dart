import 'package:bloc/bloc.dart';
import 'package:challenge2/gen/core/data/model/login/login/login.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/data/datasource/api/user_api.dart';
import '../../../../core/utils/status.dart';

part 'login_state.dart';

@Injectable()
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._api) : super(LoginInitial());

  final UserApi _api;
  //var data = <Login>[];

  void login(String email, String password) async {
    emit(LoginInitialState(status: Status.loading));
    try {
      final response = await _api.login(email, password);

      emit(LoginInitialState(status: Status.success, data: response.data));
      //data = response.data;
    } catch (e) {
      emit(LoginInitialState(status: Status.error));
    }
  }

  // void filter(String query) {
  //   final result = data.where((element) => element.airportName.contains(query));
  //   emit(FlightInitialState(status: Status.success, data: result.toList()));
  // }
}
