import 'package:bloc/bloc.dart';
import 'package:challenge2/core/data/model/profile/profile/profile.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/data/datasource/api/user_api.dart';
import '../../../../../../core/utils/status.dart';

part 'profile_state.dart';

@Injectable()
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._api) : super(ProfileInitial());

  final UserApi _api;
  //var data = <Login>[];

  void getUser() async {
    emit(ProfileInitialState(status: Status.loading));
    try {
      final response = await _api.getProfile();
      emit(ProfileInitialState(status: Status.success, data: response.data));
      //data = response.data;
    } catch (e) {
      emit(ProfileInitialState(status: Status.error));
    }
  }

  // void filter(String query) {
  //   final result = data.where((element) => element.airportName.contains(query));
  //   emit(FlightInitialState(status: Status.success, data: result.toList()));
  // }
}
