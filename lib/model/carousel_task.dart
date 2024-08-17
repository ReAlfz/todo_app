import 'package:todo/model/task.dart';

class CarouselTask {
  final String id, text;
  List<Task> list;

  CarouselTask({
    required this.id,
    required this.text,
    required this.list,
  });
}