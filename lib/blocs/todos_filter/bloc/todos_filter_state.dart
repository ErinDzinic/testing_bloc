part of 'todos_filter_bloc.dart';

sealed class TodosFilterState extends Equatable {
  const TodosFilterState();

  @override
  List<Object> get props => [];
}

class TodosFilterLoading extends TodosFilterState {}

class TodosFilterLoaded extends TodosFilterState {
  final List<Todo> pendingTodos;
  final List<Todo> completedTodos;

  const TodosFilterLoaded({
    required this.pendingTodos,
    required this.completedTodos,
  });

  @override
  List<Object> get props => [pendingTodos, completedTodos];
}
