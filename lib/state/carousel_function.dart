import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/model/carousel_task.dart';
import 'package:todo/model/task.dart';
import 'package:todo/screen/detail.dart';
import 'package:todo/widget/carousel_item_list.dart';

final carouselListProvider = StateNotifierProvider<CarouselFunction, List<CarouselTask>>((ref) {
  return CarouselFunction([
    const CarouselTask(
        id: '0',
        text: 'healing',
        list: [
          Task(id: '0', description: 'Hello there', isDone: true),
          Task(id: '1', description: 'Hello there', isDone: false),
          Task(id: '2', description: 'Hello there', isDone: false),
        ]
    ),

    const CarouselTask(
        id: '1',
        text: 'workout',
        list: [
          Task(id: '1', description: 'Hello there')
        ]
    ),

    const CarouselTask(
        id: '2',
        text: 'Study',
        list: []
    ),
  ]);
});

class CarouselFunction extends StateNotifier<List<CarouselTask>>{
  CarouselFunction(List<CarouselTask>? initialData) : super(initialData ?? []);

  List<Widget> getCard(context) {
    return List.generate(state.length, (index) {
      return GestureDetector(
        child: CarouselItemList(task: state[index], index: index),
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return DetailScreen(task: state[index], index: index);
              },
              transitionDuration: const Duration(milliseconds: 800),
              reverseTransitionDuration: const Duration(milliseconds: 800),
            ),
          );
        },
      );
    });
  }
}