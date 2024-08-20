import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/state/provider.dart';
import 'package:todo/widget/float_button.dart';
import 'package:todo/widget/item_list.dart';
import 'package:todo/widget/progress_todo_list.dart';
import 'package:todo/widget/title_todo_list.dart';

class DetailScreen extends HookConsumerWidget {
  const DetailScreen({Key? key, required this.mIndex, required this.realIndex}) : super(key: key);
  final int mIndex;
  final int realIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final opacity = useState(1.0);
    final size = MediaQuery.of(context).size;
    final task = ref.watch(listProvider)[mIndex];

    AnimationController controller = useAnimationController(
      duration: const Duration(milliseconds: 1200),
    );

    Animation animation = Tween(
        begin: 0.0,
        end: 1.0
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutBack,
      ),
    );

    useEffect(() {
      Future.delayed(const Duration(milliseconds: 600), () {
        controller.forward();
      });
      return null;
    }, []);

    return Stack(
      children: [
        Hero(
          tag: 'task_bg_$realIndex',
          child: Container(
            color: Colors.white,
          ),
        ),

        AnimatedOpacity(
          opacity: opacity.value,
          duration: const Duration(milliseconds: 200),
          child: Scaffold(
            appBar: AppBar(
              leading: Hero(
                tag: 'task_back_$realIndex',
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.lightBlue,
                    size: 25,
                  ),
                  onPressed: () {
                    opacity.value = 0.0;
                    Navigator.of(context).pop();
                  },
                ),
              ),

              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Hero(
                    tag: 'task_menu_$realIndex',
                    child: const Icon(
                      Icons.more_vert,
                      color: Colors.lightBlue,
                      size: 25,
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

                  const SizedBox(height: 50),

                  TitleToDoList(ref: ref, index: mIndex, realIndex: realIndex),
                  ProgressToDoList(ref: ref, index: mIndex, realIndex: realIndex),

                  ListView.builder(
                    itemCount: task.list.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ItemListTask(
                        size: size,
                        index: index,
                        animation: animation,
                        task: task,
                        ref: ref,
                      );
                    },
                  ),
                ],
              ),
            ),

            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: FloatButton(code: false, index: mIndex),
          ),
        ),
      ],
    );
  }
}