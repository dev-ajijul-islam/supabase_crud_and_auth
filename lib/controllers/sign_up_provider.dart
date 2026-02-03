import 'package:flutter/cupertino.dart';
import 'package:supabase_crud_and_auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpProvider extends ChangeNotifier {
  bool isSigningUp = false;
  final auth = Supabase.instance.client.auth;
  final database = Supabase.instance.client.from("users");

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailTEController = .new();
  final TextEditingController passwordTEController = .new();

  Future<bool> signUp() async {
    if (formKey.currentState!.validate()) {
      isSigningUp = true;
      notifyListeners();
      try {
        final credentials = await auth.signUp(
          email: emailTEController.text.trim(),
          password: passwordTEController.text,
        );

        if (credentials.user != null) {
          debugPrint(credentials.user.toString());
          emailTEController.clear();
          passwordTEController.clear();

          final UserModel userModel = UserModel(
            uid: credentials.user!.id,
            email: credentials.user!.email.toString(),
            imageUrl: "",
          );

          await database.insert(userModel.toMap());
          return true;
        } else {
          debugPrint(credentials.user.toString());
          return false;
        }
      } catch (e) {
        debugPrint(e.toString());
        return false;
      } finally {
        isSigningUp = false;
        notifyListeners();
      }
    } else {
      return false;
    }
  }
}
