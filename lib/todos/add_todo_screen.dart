import 'package:bloc_test/blocs/todos/todos_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/todo_model.dart';

class AddTodoScreen extends StatelessWidget {
  const AddTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerId = TextEditingController();
    TextEditingController controllerTask = TextEditingController();
    TextEditingController controllerDescription = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
      ),
      body: BlocListener<TodosBloc, TodosState>(
        listener: (context, state) {
          if (state is TodosLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('You have added todo')));
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
                      description: controllerDescription.text);
                  context.read<TodosBloc>().add(AddTodo(todo: todo));
                  Navigator.pop(context);
                },
                child: const Text('Add Todo'))
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
