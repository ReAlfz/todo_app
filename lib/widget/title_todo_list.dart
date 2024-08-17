import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/model/carousel_task.dart';
import 'package:todo/model/task.dart';
import 'package:todo/state/carousel_function.dart';

class TitleToDoList extends StatelessWidget {
  const TitleToDoList({super.key, required this.ref, required this.index});
  final WidgetRef ref;
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
              ref.watch(carouselListProvider)[index].text,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              '${ref.watch(carouselListProvider)[index].list.length} items',
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