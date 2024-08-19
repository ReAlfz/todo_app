import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/state/provider.dart';
import 'package:todo/widget/progress_todo_list.dart';
import 'package:todo/widget/title_todo_list.dart';

class InfoCarousel extends StatelessWidget {
  final WidgetRef ref;
  final int index;
  final int realIndex;
  const InfoCarousel({Key? key, required this.ref, required this.index, required this.realIndex,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Stack(
        children: [
          Hero(
            tag: 'task_bg_$realIndex',
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            ),
          ),

          Hero(
            tag: 'task_back_$realIndex',
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
                          tag: 'task_icon_$realIndex',
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
                          tag: 'task_menu_$realIndex',
                          child: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.lightBlue,
                              size: 30,
                            ),
                            onPressed: () {
                              ref.watch(listProvider.notifier).removeInfoTask(
                                id: ref.read(listProvider)[index].id,
                              );
                            },
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
                    TitleToDoList(ref: ref, index: index, realIndex: realIndex),
                    ProgressToDoList(ref: ref, index: index, realIndex: realIndex),
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
