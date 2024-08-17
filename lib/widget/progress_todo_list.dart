import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/model/carousel_task.dart';
import 'package:todo/model/task.dart';
import 'package:todo/state/carousel_function.dart';

class ProgressToDoList extends StatelessWidget {
  const ProgressToDoList({super.key, required this.ref, required this.index});
  final WidgetRef ref;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Hero(
          tag: 'task_percentage_$index',
          child: Text(
            '${ref.watch(carouselListProvider.notifier).getValue(index, 0).round()}%',
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
                value: ref.watch(carouselListProvider.notifier).getValue(index, 1),
                backgroundColor: const Color.fromRGBO(224, 224, 224, 1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}