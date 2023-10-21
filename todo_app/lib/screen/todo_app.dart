import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/provider/add_todo_provider.dart';
import 'package:todo_app/widget/alert_dialog.dart';
import 'package:todo_app/widget/check_box.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> with SingleTickerProviderStateMixin {
  ScrollController scrollController = ScrollController();
  final TextEditingController controller = TextEditingController();
  late AnimationController animationController;
  List<Animation<Offset>>? slideAnimation;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    Future.delayed(Duration(seconds: 1), () {
      animationController.forward();
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    animationController.dispose();
  }

  void createNewTask(
    BuildContext context,
    bool value,
    TodoModel? todo,
  ) {
    showDialog(
      context: context,
      builder: (context) => DialogBox(
        controller: controller,
        onSeleted: () {
          final text = controller.text;
          if (text.isNotEmpty) {
            if (todo != null) {
              // Editing an existing task
              todo.text = text;
              context.read<AddTodoProvider>().updateTofo(todo);
            } else {
              // Creating a new task
              context.read<AddTodoProvider>().addTodo(text, value);
            }
          }
          SchedulerBinding.instance.addPostFrameCallback((_) {
            scrollController.jumpTo(scrollController.position.maxScrollExtent);
          });

          controller.clear();
          Navigator.pop(context);
        },
        initialText: todo?.text ?? '',
        // Set the initial text for editing
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "TO DO",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: context.watch<AddTodoProvider>().getTodos.isEmpty
          ? const Center(
              child: Text(
                "NO TODO!",
                softWrap: true,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          : ListView.builder(
              controller: scrollController,
              itemCount: context.watch<AddTodoProvider>().getTodos.length,
              itemBuilder: (context, index) {
                final todo = context.read<AddTodoProvider>().getTodos[index];
                slideAnimation = List.generate(
                    todo.id.length,
                    (index) =>
                        Tween(begin: const Offset(-1, 1), end: Offset.zero)
                            .animate(CurvedAnimation(
                                parent: animationController,
                                curve: Interval(index * (1 / 8), 1)))).toList();

                return SlideTransition(
                  position: slideAnimation![index],
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 24.0, right: 24.0, bottom: 0),
                    child: Slidable(
                      endActionPane: ActionPane(
                        motion: const StretchMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              context.read<AddTodoProvider>().deletedTodo(todo);
                            },
                            icon: Icons.delete,
                            backgroundColor: Colors.red,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ],
                      ),
                      startActionPane:
                          ActionPane(motion: const StretchMotion(), children: [
                        SlidableAction(
                          onPressed: (context) {
                            createNewTask(context, false, todo);
                          },
                          icon: Icons.edit,
                          backgroundColor: Colors.black,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ]),
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.purple,
                        ),
                        child: Row(
                          children: [
                            CheckBoxWidget(
                                isChecked: todo.isChecked,
                                onChanged: (value) {
                                  todo.isChecked = value!;
                                  setState(() {});
                                }),
                            Flexible(
                              child: Text(
                                todo.text,
                                softWrap: true,
                                style: TextStyle(
                                  color: Colors.white,
                                  decorationThickness: 2.2,
                                  decoration: todo.isChecked
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () {
          createNewTask(context, false, null);
        },
        child: const Icon(
          Icons.add,
          size: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}
