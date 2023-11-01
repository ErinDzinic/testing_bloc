import 'package:bloc_test/blocs/notes/bloc/notes_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/notes_model.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        if (state is NotesLoading) {
          return const CircularProgressIndicator();
        }
        if (state is NotesLoaded) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Text('Notes'.toUpperCase()),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.notes.length,
                    itemBuilder: ((context, index) =>
                        NotesCardWidget(note: state.notes[index])))
              ],
            ),
          );
        } else {
          return const Text('Something went wrong');
        }
      },
    );
  }
}

class NotesCardWidget extends StatelessWidget {
  final Note note;

  const NotesCardWidget({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
          title: Text(
            note.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(note.note),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.remove)),
              Checkbox(
                value: note.isCompleted,
                onChanged: (value) {
                  context.read<NotesBloc>().add(UpdateNote(
                      note: note.copyWith(
                          note.id, note.title, note.note, !note.isCompleted)));
                },
              ),
            ],
          )),
    );
  }
}
