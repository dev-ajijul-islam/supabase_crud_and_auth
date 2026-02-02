import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:supabase_crud_and_auth/data/models/note_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TodoController extends ChangeNotifier {
  bool isLoading = false;
  final database = Supabase.instance.client.from("todos");
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController titleTEController = TextEditingController();
  final TextEditingController subTitleTEController = TextEditingController();

  //----------------------read data as stream------------------------------
  var todoStream = Supabase.instance.client
      .from("todos")
      .stream(primaryKey: ["id"]);

  //-----------------------create todos --------------------------------

  Future<void> createTodo({
    TodoModel? existingTodo,
    required BuildContext context,
  }) async {
    if (formKey.currentState!.validate()) {
      isLoading = true;
      notifyListeners();
      try {
        final TodoModel todo = .new(
          uid: "123",
          title: titleTEController.text.trim(),
          body: subTitleTEController.text.trim(),
        );
        existingTodo != null
            ? await database.update(todo.toMap()).eq("id", existingTodo.id!)
            : await database.insert(todo.toMap());
        Navigator.pop(context);
        titleTEController.clear();
        subTitleTEController.clear();
      } on SocketException catch (e) {
        debugPrint(e.message);
      } on FormatException catch (e) {
        debugPrint(e.message);
      } catch (e) {
        debugPrint(e.toString());
      } finally {
        isLoading = false;
        notifyListeners();
      }
    }
  }
}
