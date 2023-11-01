import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/notes_model.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(NotesLoading()) {
    on<LoadNotes>(_onLoadNotes);
    on<AddNote>(_onAddNote);
    on<RemoveNote>(_onRemoveNote);
    on<UpdateNote>(_onUpdateNote);
  }
  void _onLoadNotes(LoadNotes event, Emitter<NotesState> emit) {
    emit(NotesLoaded(notes: event.notes));
  }

  void _onAddNote(AddNote event, Emitter<NotesState> emit) {
    final state = this.state;
    if (state is NotesLoaded) {
      emit(NotesLoaded(notes: List.from(state.notes)..add(event.note)));
    }
  }

  void _onRemoveNote(RemoveNote event, Emitter<NotesState> emit) {}

  void _onUpdateNote(UpdateNote event, Emitter<NotesState> emit) {
    final state = this.state;
    if (state is NotesLoaded) {
      List<Note> notes = (state.notes
              .map((note) => note.id == event.note.id ? event.note : note))
          .toList();
      emit(NotesLoaded(notes: notes));
    }
  }
}
