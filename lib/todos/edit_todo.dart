import 'package:bloc_test/blocs/todos/todos_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/todo_model.dart';

class EditTodoScreen extends StatefulWidget {
  final Todo todo;

  const EditTodoScreen({Key? key, required this.todo}) : super(key: key);

  @override
  State<EditTodoScreen> createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  late TextEditingController controllerId;
  late TextEditingController controllerTask;
  late TextEditingController controllerDescription;

  @override
  void initState() {
    super.initState();
    controllerId = TextEditingController(text: widget.todo.id);
    controllerTask = TextEditingController(text: widget.todo.task);
    controllerDescription =
        TextEditingController(text: widget.todo.description);
  }

  @override
  void dispose() {
    controllerId.dispose();
    controllerTask.dispose();
    controllerDescription.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Todo'),
      ),
      body: BlocListener<TodosBloc, TodosState>(
        listener: (context, state) {
          if (state is TodosLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('You have edited todo')));
          }
        },
        child: Column(
          children: [
            _inputField('ID', controllerId),
            _inputField('Task', controllerTask),
            _inputField('Description', controllerDescription),
            ElevatedButton(
              onPressed: () {
                var todo = Todo(
                  id: controllerId.text,
                  task: controllerTask.text,
                  description: controllerDescription.text,
                );
                context.read<TodosBloc>().add(EditTodo(todo: todo));
                Navigator.pop(context);
              },
              child: const Text('Edit Todo'),
            ),
          ],
        ),
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
