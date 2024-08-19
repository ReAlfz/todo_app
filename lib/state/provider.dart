import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/model/carousel_task.dart';
import 'package:todo/model/task.dart';
import 'package:uuid/uuid.dart';

final listProvider = StateNotifierProvider<Provider, List<CarouselTask>>((ref) {
  return Provider([
    CarouselTask(
      id: '0',
      text: 'healing',
      list: [
        const Task(id: '0', description: 'Hello therezzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz', isDone: true),
        const Task(id: '1', description: 'Hello there', isDone: false),
        const Task(id: '2', description: 'Hello there', isDone: false),
      ],
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

class Provider extends StateNotifier<List<CarouselTask>>{
  Provider(List<CarouselTask>? initialData) : super(initialData ?? []);

  double getLinear(int index) {
    if (state[index].list.isEmpty) {
      return 0;
    }
    int result = state[index].list.where((task) => task.isDone).length;
    return result / state[index].list.length;
  }

  String getPercentText(int index) {
    if (state[index].list.isEmpty) {
      return '0%';
    }

    int result = state[index].list.where((task) => task.isDone).length;
    return '${((result / state[index].list.length) * 100).round()}%';
  }

  void addInfoTask({required String title}) {
    state.add(
        CarouselTask(
          id: const Uuid().v4(),
          text: title,
          list: [],
        ),
    );
  }

  void removeInfoTask({required String id}) {
    final newState = [...state];
    newState.removeWhere((element) => element.id == id);
    state = newState;
  }

  // Function for list item
  void changeCheck({required String idParent, required String idChild}) {
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

  void removeListTask({required String idParent, required String idChild}) {
    final newCarousel = [...state];
    final getCarouselIndex = state.indexWhere((element) => element.id == idParent);
    newCarousel[getCarouselIndex].list.removeWhere((element) => element.id == idChild);
    state = newCarousel;
  }
}