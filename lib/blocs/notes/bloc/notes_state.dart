part of 'notes_bloc.dart';

sealed class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object> get props => [];
}

final class NotesLoading extends NotesState {}

final class NotesLoaded extends NotesState {
  final List<Note> notes;

  const NotesLoaded({this.notes = const <Note>[]});

  @override
  List<Object> get props => [notes];
}
