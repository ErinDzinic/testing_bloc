part of 'notes_bloc.dart';

sealed class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

class LoadNotes extends NotesEvent {
  final List<Note> notes;
  const LoadNotes({required this.notes});

  @override
  List<Object> get props => [notes];
}

class AddNote extends NotesEvent {
  final Note note;
  const AddNote({required this.note});

  @override
  List<Object> get props => [note];
}

class RemoveNote extends NotesEvent {
  final Note note;
  const RemoveNote({required this.note});

  @override
  List<Object> get props => [note];
}

class UpdateNote extends NotesEvent {
  final Note note;
  const UpdateNote({required this.note});

  @override
  List<Object> get props => [note];
}
