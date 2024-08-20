import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/state/provider.dart';

void showTaskDialog(BuildContext context, WidgetRef ref, TextEditingController controller, int index, bool code) {
  showGeneralDialog(
    context: context,
    barrierLabel: "Task Dialog",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (context, anim1, anim2) {
      return Align(
        alignment: Alignment.center,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(bottom: 20, left: 12, right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: 'Title task...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                FloatingActionButton(
                  heroTag: 'fab',
                  onPressed: () {
                    if (code) {
                      ref.read(listProvider.notifier).addInfoTask(title: controller.text);
                      controller.clear();
                    }
                    ref.read(listProvider.notifier).addListTask(text: controller.text, index: index);
                    controller.clear();
                    Navigator.of(context).pop(); // Close the dialog after adding the task
                  },
                  backgroundColor: Colors.lightBlue,
                  elevation: 8,
                  child: const Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: anim1,
          curve: Curves.easeInOut,
        )),
        child: child,
      );
    },
  );
}