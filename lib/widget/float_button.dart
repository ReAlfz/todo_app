import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/screen/create_info_task.dart';

class FloatButton extends HookConsumerWidget {
  final bool code;
  final int index;
  const FloatButton({super.key, required this.code, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    return FloatingActionButton(
      heroTag: 'fab',
      onPressed: () {
        showTaskDialog(context, ref, controller, index, code);
      },
      backgroundColor: Colors.lightBlue,
      child: const Icon(
        Icons.add,
        color: Colors.black,
        size: 30,
      ),
    );
  }
}