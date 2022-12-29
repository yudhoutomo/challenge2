part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileInitialState extends ProfileState {
  final Status status;
  final Profile? data;

  const ProfileInitialState({
    required this.status,
    this.data,
  });
  @override
  List<Object?> get props => [status, data];
}

class UserProfileState extends ProfileState {}
