import 'package:bloc_test/blocs/todos/todos_bloc.dart';
import 'package:bloc_test/todos/add_todo_screen.dart';
import 'package:bloc_test/todos/edit_todo.dart';
import 'package:bloc_test/users_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/todos_filter/bloc/todos_filter_bloc.dart';
import 'models/todo_model.dart';
import 'notes/add_notes_screen.dart';
import 'notes/notes_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.format_list_bulleted),
      label: 'Todos',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.note),
      label: 'Notes',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.people),
      label: 'Users',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc Test'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => _currentIndex == 0
                        ? const AddTodoScreen()
                        : const AddNotesScreen()));
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: _buildBody(_currentIndex),
    );
  }
}

class TodosScreen extends StatelessWidget {
  const TodosScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosFilterBloc, TodosFilterState>(
      builder: (context, state) {
        if (state is TodosFilterLoading) {
          return const CircularProgressIndicator();
        }
        if (state is TodosFilterLoaded) {
          return Column(
            children: [
              if (state.pendingTodos.isNotEmpty)
                TodosListWidget(
                    todos: state.pendingTodos,
                    title: 'Pending ToDos'.toUpperCase()),
              if (state.completedTodos.isNotEmpty)
                TodosListWidget(
                    todos: state.completedTodos,
                    title: 'Completed ToDos'.toUpperCase()),
            ],
          );
        } else {
          return const Text('Nothing');
        }
      },
    );
  }
}

Widget _buildBody(int index) {
  switch (index) {
    case 0:
      return const TodosScreen();
    case 1:
      return const NotesScreen();
    case 2:
      return const UsersScreen();
    default:
      return const Center(child: Text('Not Implemented Yet'));
  }
}

class TodosListWidget extends StatelessWidget {
  final List<Todo> todos;
  final String title;
  const TodosListWidget({super.key, required this.todos, required this.title});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosFilterBloc, TodosFilterState>(
      builder: (context, state) {
        if (state is TodosFilterLoading) {
          return const CircularProgressIndicator();
        }
        if (state is TodosFilterLoaded) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: todos.length,
                    itemBuilder: (BuildContext context, index) => InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  EditTodoScreen(todo: todos[index])));
                        },
                        child: TodoCard(todo: todos[index]))),
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

class TodoCard extends StatelessWidget {
  final Todo todo;
  const TodoCard({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${todo.id} ${todo.task}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () async {
                      context.read<TodosBloc>().add(
                          UpdateTodo(todo: todo.copyWith(isCompleted: true)));
                    },
                    icon: const Icon(Icons.add_task)),
                IconButton(
                    onPressed: () {
                      context.read<TodosBloc>().add(
                          DeleteTodo(todo: todo.copyWith(isCancelled: true)));
                    },
                    icon: const Icon(Icons.cancel))
              ],
            )
          ],
        ),
      ),
    );
  }
}
