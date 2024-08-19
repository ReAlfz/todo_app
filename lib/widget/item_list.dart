import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/model/carousel_task.dart';
import 'package:todo/state/provider.dart';

class ItemListTask extends StatelessWidget {
  final CarouselTask task;
  final Size size;
  final int index;
  final WidgetRef ref;
  final Animation animation;

  const ItemListTask({
    super.key,
    required this.size,
    required this.index,
    required this.animation,
    required this.task,
    required this.ref
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            (size.width + index * 100) * (animation.value -1),
            0,
          ),
          child: child,
        );
      },

      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Checkbox(
                value: task.list[index].isDone,
                onChanged: (value) {
                  ref.watch(listProvider.notifier).changeCheck(
                    idParent: task.id,
                    idChild: task.list[index].id,
                  );
                },
              ),
            ),

            const SizedBox(width: 10),

            Flexible(
              flex: 8,
              fit: FlexFit.tight,
              child: Text(
                task.list[index].description,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),

            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: AnimatedOpacity(
                opacity: task.list[index].isDone ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: IconButton(
                  onPressed: () {
                    ref.watch(listProvider.notifier).removeListTask(
                      idParent: task.id,
                      idChild: task.list[index].id,
                    );
                  },

                  icon: const Icon(
                    Icons.delete,
                    size: 20,
                    color: Colors.lightBlue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}