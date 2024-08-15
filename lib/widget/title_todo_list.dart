import 'package:flutter/material.dart';
import 'package:todo/model/carousel_task.dart';

class TitleToDoList extends StatelessWidget {
  const TitleToDoList({super.key, required this.task, required this.index});
  final CarouselTask task;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'task_title_$index',
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.text,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              '${task.list.length} items',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}