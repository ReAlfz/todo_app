import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/state/provider.dart';

class TitleToDoList extends StatelessWidget {
  const TitleToDoList({super.key, required this.ref, required this.index, required this.realIndex});
  final int index;
  final int realIndex;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(listProvider)[index];
    return Hero(
      tag: 'task_title_$realIndex',
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.text,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              '${data.list.length} items',
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