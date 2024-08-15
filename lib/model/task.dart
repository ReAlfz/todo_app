import 'package:flutter/foundation.dart';

@immutable
class Task {
  final String id, description;
  final bool isDone;

  const Task({
    required this.id,
    required this.description,
    this.isDone = false,
  });
}