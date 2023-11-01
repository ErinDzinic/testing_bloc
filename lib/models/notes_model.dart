import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Note extends Equatable {
  final String id;
  final String title;
  final String note;
  bool isCompleted;

  Note(
      {required this.id,
      required this.title,
      required this.note,
      this.isCompleted = false});

  Note copyWith(
    String? id,
    String? title,
    String? note,
    bool? isCompleted,
  ) {
    return Note(
        id: id ?? this.id,
        title: title ?? this.title,
        note: note ?? this.note,
        isCompleted: isCompleted ?? false);
  }

  @override
  List<Object?> get props => [title, note, isCompleted];
}

final List<Note> dummyNotes = [
  Note(
    id: '1',
    title: 'Meeting Notes',
    note: 'Discuss project timeline and deliverables.',
  ),
  Note(
    id: '3',
    title: 'Workout Plan',
    note: '20 push-ups, 30 squats, 10-minute jog.',
  ),
];
