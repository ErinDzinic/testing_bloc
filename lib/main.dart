import 'package:bloc_test/repository/user_repository.dart';
import 'package:bloc_test/blocs/notes/bloc/notes_bloc.dart';
import 'package:bloc_test/blocs/todos/todos_bloc.dart';
import 'package:bloc_test/blocs/todos_filter/bloc/todos_filter_bloc.dart';
import 'package:bloc_test/blocs/users_bloc/bloc/users_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc_observer.dart';
import 'home.dart';
import 'models/notes_model.dart';
import 'models/todo_model.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => TodosBloc()..add(LoadTodos(todos: todoList))),
        BlocProvider(
            create: (context) =>
                TodosFilterBloc(todosBloc: BlocProvider.of<TodosBloc>(context))
                  ..add(const UpdateFilterTodos())),
        BlocProvider(
            create: (context) =>
                NotesBloc()..add(LoadNotes(notes: dummyNotes))),
        BlocProvider(create: (context) => UsersBloc(UserRepository())),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
