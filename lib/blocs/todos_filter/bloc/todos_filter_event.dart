part of 'todos_filter_bloc.dart';

sealed class TodosFilterEvent extends Equatable {
  const TodosFilterEvent();

  @override
  List<Object> get props => [];
}

class UpdateFilter extends TodosFilterEvent {
  const UpdateFilter();
  @override
  List<Object> get props => [];
}

class UpdateFilterTodos extends TodosFilterEvent {
  final List<Todo> todos;

  const UpdateFilterTodos({this.todos = const <Todo>[]});
  @override
  List<Object> get props => [todos];
}
