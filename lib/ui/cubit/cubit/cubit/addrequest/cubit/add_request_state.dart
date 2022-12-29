part of 'add_request_cubit.dart';

abstract class AddRequestState extends Equatable {
  const AddRequestState();

  @override
  List<Object?> get props => [];
}

class AddRequestInitial extends AddRequestState {}

class AddRequestInitialState extends AddRequestState {
  final Status status;
  final AddRequest? data;

  const AddRequestInitialState({
    required this.status,
    this.data,
  });
  @override
  List<Object?> get props => [status, data];
}

class UserAddRequestState extends AddRequestState {}
