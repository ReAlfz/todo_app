import 'package:flutter/material.dart';
import 'package:todo/model/carousel_task.dart';
import 'package:todo/model/task.dart';

class ProgressToDoList extends StatelessWidget {
  const ProgressToDoList({super.key, required this.task, required this.index});
  final CarouselTask task;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Hero(
          tag: 'task_percentage_$index',
          child: Text(
            '${getValue(task.list, 0).round()}%',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),

        Hero(
          tag: 'task_progress_bar_$index',
          child: Container(
            height: 10,
            margin: const EdgeInsets.only(top: 12, bottom: 10),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: LinearProgressIndicator(
                valueColor: const AlwaysStoppedAnimation(Colors.amber),
                value: getValue(task.list, 1),
                backgroundColor: const Color.fromRGBO(224, 224, 224, 1),
              ),
            ),
          ),
        ),
      ],
    );
  }

  double getValue(List<Task> task, int choice) {
    if (task.isEmpty) {
      return 0;
    }

    if (choice == 0) {
      int result = task.where((task) => task.isDone).length;
      return (result/task.length) * 100.round();
    } else {
      int result = task.where((task) => task.isDone).length;
      return result/task.length;
    }
  }
}