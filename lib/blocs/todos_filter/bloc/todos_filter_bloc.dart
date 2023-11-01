import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_test/blocs/todos/todos_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../models/todo_model.dart';
part 'todos_filter_event.dart';
part 'todos_filter_state.dart';

class TodosFilterBloc extends Bloc<TodosFilterEvent, TodosFilterState> {
  final TodosBloc _todosBloc;
  late StreamSubscription _todosSubscription;
  TodosFilterBloc({required TodosBloc todosBloc})
      : _todosBloc = todosBloc,
        super(TodosFilterLoading()) {
    on<UpdateFilterTodos>(_onUpdateTodoFilter);

    _todosSubscription = _todosBloc.stream.listen((state) {
      if (state is TodosLoaded) {
        add(
          UpdateFilterTodos(todos: state.todos),
        );
      }
    });
  }

  void _onUpdateTodoFilter(
      UpdateFilterTodos event, Emitter<TodosFilterState> emit) {
    final state = _todosBloc.state;
    if (state is TodosLoaded) {
      final List<Todo> pendingList = event.todos
          .where(
              (todo) => todo.isCompleted == false && todo.isCancelled == false)
          .toList();
      final List<Todo> completedList = event.todos
          .where(
              (todo) => todo.isCompleted == true && todo.isCancelled == false)
          .toList();

      emit(TodosFilterLoaded(
          pendingTodos: pendingList, completedTodos: completedList));
    }
  }

  @override
  Future<void> close() {
    _todosSubscription.cancel();
    return super.close();
  }
}
