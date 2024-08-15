import 'package:todo/model/task.dart';

class CarouselTask {
  final String id, text;
  final List<Task> list;

  const CarouselTask({
    required this.id,
    required this.text,
    required this.list
  });
}