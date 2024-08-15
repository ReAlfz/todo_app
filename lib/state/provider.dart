import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/model/carousel_task.dart';
import 'package:todo/model/task.dart';
import 'package:uuid/uuid.dart';

final taskListProvider = StateNotifierProvider<InsideState, List<Task>>((ref) {
  return InsideState(const [
    Task(id: '0', description: 'Hello there')
  ]);
});

enum TaskFilter {
  all,
  active,
  completed
}

const _uuid = Uuid();
final taskListFilter = StateProvider((ref) => TaskFilter.all);
final filteredTask = Provider<List<Task>>((ref) {
  final filter = ref.watch(taskListFilter);
  final task = ref.watch(taskListProvider);

  switch (filter) {
    case TaskFilter.completed:
      return task.where((task) => task.isDone).toList();
    case TaskFilter.active:
      return task.where((task) => !task.isDone).toList();
    case TaskFilter.all:
      return task;
  }
});

final unCompleteTask = Provider<int>((ref) {
  return ref.watch(taskListProvider).where((task) => !task.isDone).length;
});

class InsideState extends StateNotifier<List<Task>> {
  InsideState([List<Task>? initialData]) : super(initialData ?? []);

  void add(String description) {
    state = [
      ...state,
      Task(
        id: _uuid.v4(),
        description: description,
      ),
    ];
  }

  void toggle(String id) {
    final newState = [...state];
    final replaceIndex = state.indexWhere((task) => task.id == id);

    if (replaceIndex != -1) {
      newState[replaceIndex] = Task(
        id: newState[replaceIndex].id,
        description: newState[replaceIndex].description,
        isDone: !newState[replaceIndex].isDone,
      );
    }

    state = newState;
  }

  void edit({required String id, required String description}) {
    final newState = [...state];
    final replaceIndex = state.indexWhere((task) => task.id == id);

    if (replaceIndex != -1) {
      newState[replaceIndex] = Task(
        id: newState[replaceIndex].id,
        description: description,
        isDone: newState[replaceIndex].isDone,
      );
    }

    state = newState;
  }
}