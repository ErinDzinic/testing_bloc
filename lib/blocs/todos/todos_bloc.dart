import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/todo_model.dart';
part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc() : super(const TodosLoaded()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodo>(_onAddTodo);
    on<UpdateTodo>(_onUpdateTodo);
    on<DeleteTodo>(_onDeleteTodo);
    on<EditTodo>(_onEditTodo);
  }

  void _onLoadTodos(LoadTodos event, Emitter<TodosState> emit) {
    emit(TodosLoaded(todos: event.todos));
  }

  void _onEditTodo(EditTodo event, Emitter<TodosState> emit) {
    final state = this.state;
    if (state is TodosLoaded) {
      final List<Todo> todos = state.todos
          .map((todo) => todo.id == event.todo.id ? event.todo : todo)
          .toList();
      emit(TodosLoaded(todos: todos));
    }
  }

  void _onAddTodo(AddTodo event, Emitter<TodosState> emit) {
    final state = this.state;
    if (state is TodosLoaded) {
      emit(TodosLoaded(todos: List.from(state.todos)..add(event.todo)));
    }
  }

  void _onUpdateTodo(UpdateTodo event, Emitter<TodosState> emit) {
    final state = this.state;
    if (state is TodosLoaded) {
      List<Todo> todos = (state.todos
              .map((todo) => todo.id == event.todo.id ? event.todo : todo))
          .toList();
      emit(TodosLoaded(todos: todos));
    }
  }

  void _onDeleteTodo(DeleteTodo event, Emitter<TodosState> emit) {
    final state = this.state;
    if (state is TodosLoaded) {
      List<Todo> todos =
          state.todos.where((todo) => todo.id != event.todo.id).toList();
      emit(TodosLoaded(todos: todos));
    }
  }
}
