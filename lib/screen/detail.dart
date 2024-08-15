import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/model/carousel_task.dart';
import 'package:todo/model/task.dart';
import 'package:todo/widget/progress_todo_list.dart';
import 'package:todo/widget/title_todo_list.dart';

class DetailScreen extends HookConsumerWidget {
  const DetailScreen({Key? key, required this.task, required this.index}) : super(key: key);
  final int index;
  final CarouselTask task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Hero(
          tag: 'task_bg_$index',
          child: Container(
            color: Colors.white,
          ),
        ),

        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: Hero(
              tag: 'task_back_$index',
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 25,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Hero(
                  tag: 'task_menu_$index',
                  child: const Icon(
                    Icons.more_vert,
                    color: Colors.lightBlue,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),

          body: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'task_icon_$index',
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.lightBlue,
                        ),
                        shape: BoxShape.circle),
                    child: const Icon(
                      Icons.ac_unit,
                      color: Colors.lightBlue,
                    ),
                  ),
                ),

                const SizedBox(height: 50),

                TitleToDoList(task: task, index: index),
                ProgressToDoList(task: task, index: index),
              ],
            ),
          ),
        ),
      ],
    );
  }
}