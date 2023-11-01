import 'package:bloc_test/blocs/notes/bloc/notes_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/notes_model.dart';

class AddNotesScreen extends StatefulWidget {
  const AddNotesScreen({Key? key}) : super(key: key);

  @override
  State<AddNotesScreen> createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen> {
  TextEditingController controllerId = TextEditingController();
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerNote = TextEditingController();
  @override
  void dispose() {
    controllerId.dispose();
    controllerTitle.dispose();
    controllerNote.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
      ),
      body: Column(
        children: [
          _inputField('ID', controllerId),
          _inputField('Title', controllerTitle),
          _inputField('Note', controllerNote),
          ElevatedButton(
              onPressed: () {
                var note = Note(
                    id: controllerId.text,
                    title: controllerTitle.text,
                    note: controllerNote.text);

                context.read<NotesBloc>().add(AddNote(note: note));
                Navigator.pop(context);
              },
              child: const Text('Add Note'))
        ],
      ),
    );
  }
}

Column _inputField(
  String field,
  TextEditingController controller,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '$field: ',
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      Container(
        height: 50,
        margin: const EdgeInsets.only(bottom: 10),
        width: double.infinity,
        child: TextFormField(
          controller: controller,
        ),
      ),
    ],
  );
}
