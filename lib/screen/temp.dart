import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/model/task.dart';
import 'package:todo/state/provider.dart';

class Temp extends HookConsumerWidget {
  const Temp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(filteredTask);
    final textController = useTextEditingController();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          children: [
            TextField(
              controller: textController,
              decoration: const InputDecoration(
                labelText: 'What do we need to do?',
              ),
              onSubmitted: (value) {
                ref.read(taskListProvider.notifier).add(value);
                textController.clear();
              },
            ),

            const SizedBox(height: 42),

            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                '${ref.watch(unCompleteTask)} items left',
                style: const TextStyle(fontSize: 20),),
            ),

            if (task.isNotEmpty) const Divider(height: 0),
            for (var i = 0; i < task.length; i++) ...[

              if (i > 0) const Divider(height: 0),
              ProviderScope(
                overrides: [
                  _currentTask.overrideWithValue(task[i]),
                ],
                child: const TodoItem(),
              ),
            ],
          ],
        ),
        // bottomNavigationBar: const Menu(),
      ),
    );
  }
}

final _currentTask = Provider<Task>((ref) => throw UnimplementedError());

class TodoItem extends HookConsumerWidget {
  const TodoItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(_currentTask);
    final itemFocusNode = useFocusNode();
    final itemIsFocused = useIsFocused(itemFocusNode);

    final textEditingController = useTextEditingController();
    final textFieldFocusNode = useFocusNode();

    return Material(
      color: Colors.white,
      elevation: 6,
      child: Focus(
        focusNode: itemFocusNode,
        onFocusChange: (focused) {
          if (focused) {
            textEditingController.text = task.description;
          } else {
            // Commit changes only when the textfield is unfocused, for performance
            ref.read(taskListProvider.notifier).edit(id: task.id, description: textEditingController.text);
          }
        },
        child: ListTile(
          onTap: () {
            itemFocusNode.requestFocus();
            textFieldFocusNode.requestFocus();
          },
          leading: Checkbox(
            value: task.isDone,
            onChanged: (value) => ref.read(taskListProvider.notifier).toggle(task.id),
          ),
          title: itemIsFocused
              ? TextField(
            autofocus: true,
            focusNode: textFieldFocusNode,
            controller: textEditingController,
          )
              : Text(task.description),
        ),
      ),
    );
  }
}

bool useIsFocused(FocusNode node) {
  final isFocused = useState(node.hasFocus);

  useEffect(
        () {
      void listener() {
        isFocused.value = node.hasFocus;
      }

      node.addListener(listener);
      return () => node.removeListener(listener);
    },
    [node],
  );

  return isFocused.value;
}