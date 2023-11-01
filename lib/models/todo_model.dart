import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Todo extends Equatable {
  final String id;
  final String task;
  final String description;
  bool? isCompleted;
  bool? isCancelled;

  Todo({
    required this.id,
    required this.task,
    required this.description,
    this.isCompleted,
    this.isCancelled,
  }) {
    isCompleted = isCompleted ?? false;
    isCancelled = isCancelled ?? false;
  }

  Todo copyWith({
    String? id,
    String? task,
    String? description,
    bool? isCompleted,
    bool? isCancelled,
  }) {
    return Todo(
      id: id ?? this.id,
      task: task ?? this.task,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      isCancelled: isCancelled ?? this.isCancelled,
    );
  }

  @override
  List<Object?> get props => [
        id,
        task,
        description,
        isCompleted,
        isCancelled,
      ];
}

List<Todo> todoList = [
  Todo(
    id: "1",
    task: "Complete Homework",
    description: "Finish the math and science assignments by 6 PM.",
  ),
  Todo(
    id: "2",
    task: "Grocery Shopping",
    description: "Buy fruits, vegetables, and milk.",
  ),
  Todo(
    id: "3",
    task: "Shabaliba dingdong",
    description: "What ever you want to do with it.",
  ),
];
