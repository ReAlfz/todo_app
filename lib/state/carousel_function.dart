import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/model/carousel_task.dart';
import 'package:todo/model/task.dart';

final carouselListProvider = StateNotifierProvider<CarouselFunction, List<CarouselTask>>((ref) {
  return CarouselFunction([
    CarouselTask(
        id: '0',
        text: 'healing',
        list: [
          const Task(id: '0', description: 'Hello there', isDone: true),
          const Task(id: '1', description: 'Hello there', isDone: false),
          const Task(id: '2', description: 'Hello there', isDone: false),
        ]
    ),

    CarouselTask(
        id: '1',
        text: 'workout',
        list: [
          const Task(id: '1', description: 'Hello there')
        ]
    ),

    CarouselTask(
        id: '2',
        text: 'Study',
        list: []
    ),
  ]);
});

class CarouselFunction extends StateNotifier<List<CarouselTask>>{
  CarouselFunction(List<CarouselTask>? initialData) : super(initialData ?? []);

  double getValue(int index, int choice) {
    if (state[index].list.isEmpty) {
      return 0;
    }

    if (choice == 0) {
      int result = state[index].list.where((task) => task.isDone).length;
      return (result / state[index].list.length) * 100;
    } else {
      int result = state[index].list.where((task) => task.isDone).length;
      return result / state[index].list.length;
    }
  }

  void changeCheck({required String idParent, required String idChild, required int index}) {
    final newCarousel = [...state];
    final getCarouselIndex = state.indexWhere((element) => element.id == idParent);
    final replaceIndex = state[getCarouselIndex].list.indexWhere((element) => element.id == idChild);
    final newState = newCarousel[getCarouselIndex].list;

    if (replaceIndex != -1) {
      newState[replaceIndex] = Task(
        id: newState[replaceIndex].id,
        description: newState[replaceIndex].description,
        isDone: !newState[replaceIndex].isDone
      );
    }

    state = newCarousel;
  }
}