part of 'note_cubit.dart';

abstract class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object?> get props => [];
}

class NoteInitial extends NoteState {}

class NoteInitialState extends NoteState {
  final Status status;
  final List<Note>? data;

  const NoteInitialState({
    required this.status,
    this.data,
  });
  @override
  List<Object?> get props => [status, data];
}

class UserNoteState extends NoteState {}
