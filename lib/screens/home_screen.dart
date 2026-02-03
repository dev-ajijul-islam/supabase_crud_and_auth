import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_crud_and_auth/controllers/todo_provider.dart';
import 'package:supabase_crud_and_auth/data/models/note_model.dart';
import 'package:supabase_crud_and_auth/widgets/create_or_update_todo_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TodoController todoController = context.read<TodoController>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo App with Supabase"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      floatingActionButtonLocation: .centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createOrUpdateTodoDialog(
            context: context,
            todoController: todoController,
          );
        },
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          spacing: 20,
          crossAxisAlignment: .start,
          children: [
            Text("All todos", style: TextStyle(fontSize: 20)),
            Expanded(
              child: StreamBuilder(
                stream: todoController.todoStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text("There is No Todo "));
                  }

                  final List<TodoModel> todos = snapshot.data!
                      .map((snapshots) => TodoModel.fromMap(snapshots))
                      .toList();
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      final TodoModel todo = todos[index];
                      return ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: .circular(10),
                        ),
                        tileColor: Colors.teal.withAlpha(20),
                        textColor: Colors.teal,
                        title: Text(todo.title),
                        subtitle: Text(todo.body),
                        trailing: Wrap(
                          children: [
                            IconButton(
                              onPressed: () {
                                createOrUpdateTodoDialog(
                                  todoController: todoController,
                                  context: context,
                                  existingTodo: todo,
                                );
                              },
                              icon: Icon(Icons.edit_note_outlined),
                            ),
                            Consumer<TodoController>(
                              builder: (context, provider, child) => IconButton(
                                color: Colors.red,
                                onPressed: () => provider.isLoading
                                    ? null
                                    : provider.deleteTodo(
                                        context: context,
                                        todoId: todo.id!,
                                      ),
                                icon:
                                    provider.isLoading &&
                                        provider.deletingId == todo.id
                                    ? SizedBox(
                                        height: 15,
                                        width: 15,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Icon(Icons.delete_outline),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 10),
                    itemCount: todos.length,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
