import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Task extends Equatable {
  Task({required this.title, this.isDone, this.isDeleted}) {
    isDone = isDone ?? false;
    isDeleted = isDeleted ?? false;
  }
  final String title;
  bool? isDone;
  bool? isDeleted;

  Task copyWith({
    String? title,
    bool? isDone,
    bool? isDeleted,
  }) {
    return Task(
        title: title ?? this.title,
        isDone: isDone ?? this.isDone,
        isDeleted: isDeleted ?? this.isDeleted);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isDone': isDone,
      'isDeleted': isDeleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'],
      isDone: map['isDone'],
      isDeleted: map['isDeleted'],
    );
  }

  List<Object?> get props => [title, isDone, isDeleted];
}
