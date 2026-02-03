import 'package:flutter/cupertino.dart';
import 'package:supabase_crud_and_auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInProvider extends ChangeNotifier {
  bool isSigningIn = false;
  final auth = Supabase.instance.client.auth;
  final database = Supabase.instance.client.from("users");

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailTEController = .new();
  final TextEditingController passwordTEController = .new();

  Future<bool> signIn() async {
    if (formKey.currentState!.validate()) {
      isSigningIn = true;
      notifyListeners();
      try {
        final credentials = await auth.signInWithPassword(
          email: emailTEController.text.trim(),
          password: passwordTEController.text,
        );

        if (credentials.user != null) {
          debugPrint(credentials.user.toString());
          emailTEController.clear();
          passwordTEController.clear();


          return true;
        } else {
          debugPrint(credentials.user.toString());
          return false;
        }
      } catch (e) {
        debugPrint(e.toString());
        return false;
      } finally {
        isSigningIn = false;
        notifyListeners();
      }
    } else {
      return false;
    }
  }
}
