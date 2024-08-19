import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/state/provider.dart';

class ProgressToDoList extends StatelessWidget {
  const ProgressToDoList({super.key, required this.ref, required this.index, required this.realIndex});
  final int index;
  final int realIndex;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Hero(
          tag: 'task_percentage_$realIndex',
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              ref.watch(listProvider.notifier).getPercentText(index),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),

        Hero(
          tag: 'task_progress_bar_$realIndex',
          child: Container(
            height: 10,
            margin: const EdgeInsets.only(top: 12, bottom: 10),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: TweenAnimationBuilder(
                tween: Tween<double>(
                  begin: 0.0,
                  end: ref.watch(listProvider.notifier).getLinear(index),
                ),
                duration: const Duration(milliseconds: 500),
                builder: (context, value, child) {
                  return LinearProgressIndicator(
                    valueColor: const AlwaysStoppedAnimation(Colors.amber),
                    value: value,
                    backgroundColor: const Color.fromRGBO(224, 224, 224, 1),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}