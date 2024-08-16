import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/state/carousel_function.dart';
import 'package:todo/widget/progress_todo_list.dart';
import 'package:todo/widget/title_todo_list.dart';

class DetailScreen extends HookConsumerWidget {
  const DetailScreen({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final opacity = useState(1.0);
    final size = MediaQuery.of(context).size;
    final task = ref.watch(carouselListProvider)[index];

    var controller = useAnimationController(
      duration: const Duration(milliseconds: 1200),
    );

    var animation = Tween(
        begin: 0.0,
        end: 1.0
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutBack,
      ),
    );

    useEffect(() {
      Future.delayed(const Duration(milliseconds: 800), () {
        controller.forward();
      });
      return null;
    }, []);

    return Stack(
      children: [
        Hero(
          tag: 'task_bg_$index',
          child: Container(
            color: Colors.white,
          ),
        ),

        AnimatedOpacity(
          opacity: opacity.value,
          duration: const Duration(milliseconds: 300),
          child: Scaffold(
            appBar: AppBar(
              leading: Hero(
                tag: 'task_back_$index',
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
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

                  ListView.builder(
                    itemCount: task.list.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
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
                          color: Colors.red,
                          height: 20,
                          margin: EdgeInsets.symmetric(vertical: 30),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}