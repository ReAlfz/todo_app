import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/widget/progress_todo_list.dart';
import 'package:todo/widget/title_todo_list.dart';

class InfoCarousel extends StatelessWidget {
  final WidgetRef ref;
  final int index;

  const InfoCarousel({
    Key? key,
    required this.ref,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Stack(
        children: [
          Hero(
            tag: 'task_bg_$index',
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            ),
          ),

          Hero(
            tag: 'task_back_$index',
            child: const Opacity(
              opacity: 0,
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 25,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(top: 10),
                        child: Hero(
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
                      ),
                    ),


                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        margin: const EdgeInsets.only(top: 10),
                        child: Hero(
                          tag: 'task_menu_$index',
                          child: const Icon(
                            Icons.more_vert,
                            color: Colors.lightBlue,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleToDoList(ref: ref, index: index),
                    ProgressToDoList(ref: ref, index: index),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
