import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_crud_and_auth/controllers/todo_controller.dart';
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
          createOrUpdateTodoDialog(context: context,todoController: todoController);
        },
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [Text("All todos", style: TextStyle(fontSize: 20))],
        ),
      ),
    );
  }
}
