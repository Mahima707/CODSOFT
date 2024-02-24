import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/models/todo_model/todo_model.dart';
import 'package:todo_app/models/boxes.dart';
import 'package:todo_app/widgets/todo_item_widget.dart';

class TodoView extends StatelessWidget {
  final TextEditingController todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(10),
      children: [
        TextField(
          controller: todoController,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            hintText: 'Add Todo',
          ),
          onSubmitted: (input) {
            if (input.isNotEmpty) {
              final newTodo = Todo()..todo = input;
              final box = Boxes.getTodos();
              box.add(newTodo);
              todoController.clear();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Todo Added successfully'),
                  duration: Duration(milliseconds: 600),
                ),
              );
            }
          },
        ),
        SizedBox(height: 10),
        ValueListenableBuilder(
          valueListenable: Boxes.getTodos().listenable(),
          builder: (context, box, _) {
            final Box<Todo> todoBox = Boxes.getTodos();
            final List<Todo> todos = todoBox.values.toList().cast<Todo>();
            final List<dynamic> keys = todoBox.keys.toList();

            return Container(
              height: MediaQuery.of(context).size.height * .6,
              child: todos.isEmpty
                  ? Center(
                      child: Text('You are done! Take a break and come back.'),
                    )
                  : Column(
                      children: List.generate(
                        todos.length,
                        (index) => TodoItem(
                          title: todos[index].todo,
                          i: keys[index],
                        ),
                      ),
                    ),
            );
          },
        ),
      ],
    );
  }
}
