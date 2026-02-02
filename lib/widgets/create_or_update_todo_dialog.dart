import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_crud_and_auth/controllers/todo_controller.dart';
import 'package:supabase_crud_and_auth/data/models/note_model.dart';

void createOrUpdateTodoDialog({
  required TodoController todoController,
  required BuildContext context,
  TodoModel? existingTodo,
}) {
  if (existingTodo != null) {
    todoController.titleTEController.text = existingTodo.title;
    todoController.subTitleTEController.text = existingTodo.body;
  } else {
    todoController.titleTEController.clear();
    todoController.subTitleTEController.clear();
  }
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: .circular(10)),
      title: Text(existingTodo != null ? "Update todo" : "Create Todo"),
      content: Form(
        key: todoController.formKey,
        child: Column(
          spacing: 10,
          mainAxisAlignment: .center,
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please Enter Title here";
                }
                return null;
              },
              controller: todoController.titleTEController,
              decoration: InputDecoration(labelText: "Enter todo title"),
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please Enter SubTitle here";
                }
                return null;
              },
              controller: todoController.subTitleTEController,
              decoration: InputDecoration(labelText: "Enter sub title"),
            ),
            SizedBox(height: 5),
            Consumer<TodoController>(
              builder: (context, provider, child) => SizedBox(
                width: .infinity,
                height: 40,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(borderRadius: .circular(10)),
                  ),
                  onPressed: () => provider.isLoading
                      ? null
                      : provider.createTodo(existingTodo: existingTodo,context: context),
                  child: provider.isLoading
                      ? SizedBox(
                          width: 15,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(existingTodo != null ? "Update" : "Create Todo"),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
